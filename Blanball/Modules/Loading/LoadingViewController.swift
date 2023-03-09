//
//  LoadingViewController.swift
//  Blanball
//
//  Created by Nik Dub on 08.03.2023.
//

import UIKit

class LoadingViewController: UIViewController {
    
    // MARK: - Outlets -
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var spinnerImageView: UIImageView!
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applicationDidBecomeActive),
            name: UIApplication.didBecomeActiveNotification,
            object: nil
        )
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startSpinning()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopSpinning()
    }
    
    // MARK: - Internal methods -
    
    func startSpinning() {
        rotate()
    }
    
    func stopSpinning() {
        spinnerImageView.layer.removeAnimation(forKey: Constants.rotationAnimationKey)
    }
    
    // MARK: - Private methods -
    
    private func rotate() {
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: Constants.transformRotationZKey)
        rotation.toValue = NSNumber(value: Constants.angle)
        rotation.duration = Constants.duration
        rotation.isCumulative = Constants.isCumulative
        rotation.repeatCount = Float.greatestFiniteMagnitude
        spinnerImageView.layer.add(rotation, forKey: Constants.rotationAnimationKey)
    }
    
    // MARK: - Actions -
    
    @objc private func applicationDidBecomeActive() {
        startSpinning()
    }
}

extension LoadingViewController {
    enum Constants {
        static let transformRotationZKey = "transform.rotation.z"
        static let rotationAnimationKey = "rotationAnimation"
        static let duration: CFTimeInterval = 1.25
        static let isCumulative = true
        static let angle = Double.pi * 2
    }
}
