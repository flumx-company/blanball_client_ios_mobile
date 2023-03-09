//
//  StorageManager.swift
//  Blanball
//
//  Created by Misha Deneka on 09.03.2023.
//

import Foundation
import RNCryptor

protocol StorageManager {
    func save<T>(_ value: T, type: T.Type, forKey key: StorageKey) where T: Codable
    func getValue<T>(forKey key: StorageKey) -> T? where T: Codable
    func removeValue(forKey key: StorageKey)
    func clearAllData()
}

final class StorageManagerImpl: StorageManager {
    private enum StorageType {
        case userDefaults
        case keychain
        case deviceStorage
        
        init(storageKey: StorageKey) {
            switch storageKey {
            case .accessToken, .refreshToken, .randomKey:
                self = .keychain
            default:
                self = .userDefaults
            }
        }
    }
    
    // MARK: - Properties
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let userDefaults = UserDefaults.standard
    private let fileManager = FileManager.default
    
    func save<T>(_ value: T, type: T.Type, forKey key: StorageKey) where T: Codable {
        do {
            let container: StorageContainer<T> = StorageContainer(value: value)
            let data = try encoder.encode(container)
            switch StorageType(storageKey: key) {
            case .keychain:
                saveKeychain(data, forKey: key.rawValue)
            case .userDefaults:
                saveUserDefaults(data: data, key: key.rawValue)
            case .deviceStorage:
                saveInStorage(data, withName: key.rawValue)
            }
        } catch let err {
            print(err)
            return
        }
    }
    
    func getValue<T>(forKey key: StorageKey) -> T? where T: Codable {
        let data: Data?
        switch StorageType(storageKey: key) {
        case .keychain:
            data = getKeychain(withKey: key.rawValue)
        case .userDefaults:
            data = getUserDefaultsValue(withKey: key.rawValue)
        case .deviceStorage:
            data = getFileInStorage(withName: key.rawValue)
        }
        guard let result = data else { return nil }
        
        let decodedContainer = try? decoder.decode(OptionalDecodable<StorageContainer<T>>.self, from: result)
        
        return decodedContainer?.value?.value
    }
    
    func removeValue(forKey key: StorageKey) {
        switch StorageType(storageKey: key) {
        case .keychain:
            saveKeychain(nil, forKey: key.rawValue)
        case .userDefaults:
            userDefaults.set(nil, forKey: key.rawValue)
            userDefaults.synchronize()
        case .deviceStorage:
            removeItemFromStorage(withName: key.rawValue)
        }
    }
    
    func clearAllData() {
        StorageKey.deletableKeys.forEach { (key) in
            switch StorageType(storageKey: key) {
            case .keychain:
                saveKeychain(nil, forKey: key.rawValue)
            case .userDefaults:
                userDefaults.set(nil, forKey: key.rawValue)
                userDefaults.synchronize()
            case .deviceStorage:
                removeItemFromStorage(withName: key.rawValue)
            }
        }
        clearCache()
    }
}

// MARK: - Helping Device Storage Methods

private extension StorageManagerImpl {
    enum Constants {
        static let documentsDirectory = "kDocuments"
    }
    
    func saveInStorage(_ data: Data?, withName name: String) {
        do {
            try createDirectoryIfNeeded()
        } catch let error as NSError {
            print("Could not create directory by reason: \(error.localizedDescription)")
        }
        
        guard let data = data else { return }
        let cipherText = RNCryptor.encrypt(data: data, withPassword: actualRandomKey())
        
        let filePath = filesDirectoryUrl().appendingPathComponent(name)
        FileManager.default.createFile(atPath: filePath.path, contents: cipherText, attributes: [.protectionKey: FileProtectionType.complete])
        print("Successfully saved file with name \(name)")
    }
    
    func getFileInStorage(withName name: String) -> Data? {
        let filePath = filesDirectoryUrl().appendingPathComponent(name)
        let cipherData = FileManager.default.contents(atPath: filePath.path)
        if let cipherData = cipherData {
            do {
                let originalData = try RNCryptor.decrypt(data: cipherData, withPassword: actualRandomKey())
                return originalData
            } catch {
                print("Could not load file at directory by reason: \(error.localizedDescription)")
            }
        }
        return nil
    }
    
    func removeItemFromStorage(withName name: String) {
        let filePath = filesDirectoryUrl().appendingPathComponent(name)
        do {
            try FileManager.default.removeItem(at: filePath)
        } catch let error as NSError {
            print("Could not remove file with name: \(name) by reason: \(error.localizedDescription)")
        }
    }
    
    // Helping methods for File Manager
    func filesDirectoryUrl() -> URL {
        var fileDirectoryUrl = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
        fileDirectoryUrl = fileDirectoryUrl.appendingPathComponent(Constants.documentsDirectory)
        return fileDirectoryUrl
    }
    
    func createDirectoryIfNeeded() throws {
        var fileDirectoryUrl = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
        fileDirectoryUrl = fileDirectoryUrl.appendingPathComponent(Constants.documentsDirectory)
        guard !fileManager.fileExists(atPath: fileDirectoryUrl.path) else {
            return
        }
        try fileManager.createDirectory(at: fileDirectoryUrl,
                                        withIntermediateDirectories: true,
                                        attributes: [.protectionKey: FileProtectionType.complete])
    }
    
    func clearCache() {
        guard let cacheURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return }
        do {
            let directoryContents = try FileManager.default.contentsOfDirectory( at: cacheURL, includingPropertiesForKeys: nil, options: [])
            for file in directoryContents {
                do {
                    try fileManager.removeItem(at: file)
                } catch let error as NSError {
                    print("Ooops! Something went wrong: \(error)")
                }
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}

// MARK: - Helping UserDefaults Methods
private extension StorageManagerImpl {
    func saveUserDefaults(data: Data, key: String) {
        userDefaults.set(data, forKey: key)
        userDefaults.synchronize()
    }
    
    func getUserDefaultsValue(withKey key: String) -> Data? {
        return userDefaults.object(forKey: key) as? Data
    }
}

// MARK: - Helping Keychain Methods
private extension StorageManagerImpl {
    func saveKeychain(_ data: Data?, forKey key: String) {
        DispatchQueue.global().sync(flags: .barrier) { [weak self] in
            guard let query = self?.keychainQuery(withKey: key) else { return }
            
            if SecItemCopyMatching(query, nil) == noErr {
                if let data = data {
                    let status = SecItemUpdate(query, NSDictionary(dictionary: [kSecValueData: data]))
                    print("Update status: \(status), for key: \(key)")
                } else {
                    let status = SecItemDelete(query)
                    print("Delete status: \(status), for key: \(key)")
                }
            } else {
                if let data = data {
                    query.setValue(data, forKey: kSecValueData as String)
                    let status = SecItemAdd(query, nil)
                    print("Update status: \(status), for key: \(key)")
                }
            }
        }
    }
    
    func getKeychain(withKey key: String) -> Data? {
        let query = keychainQuery(withKey: key)
        query.setValue(kCFBooleanTrue, forKey: kSecReturnData as String)
        query.setValue(kCFBooleanTrue, forKey: kSecReturnAttributes as String)
        
        var result: CFTypeRef?
        let status = SecItemCopyMatching(query, &result)
        
        guard
            let resultsDict = result as? NSDictionary,
            let resultsData = resultsDict.value(forKey: kSecValueData as String) as? Data,
            status == noErr
        else {
            print("Load status: \(status), for key: \(key)")
            return nil
        }
        return resultsData
    }
    
    func keychainQuery(withKey key: String) -> NSMutableDictionary {
        let result = NSMutableDictionary()
        result.setValue(kSecClassGenericPassword, forKey: kSecClass as String)
        result.setValue(key, forKey: kSecAttrService as String)
        result.setValue(kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly, forKey: kSecAttrAccessible as String)
        return result
    }
}

// MARK: - Helping crypto methods
private extension StorageManagerImpl {
    
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map { _ in letters.randomElement()! }) // swiftlint:disable:this force_unwrapping
    }
    
    func actualRandomKey() -> String {
        if let randomKey: String = getValue(forKey: .randomKey) {
            return randomKey
        }
        let randomKey = randomString(length: 16)
        save(randomKey, type: String.self, forKey: .randomKey)
        return randomKey
    }
}
