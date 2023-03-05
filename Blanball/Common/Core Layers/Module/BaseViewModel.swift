//
//  BaseViewModel.swift
//  Blanball
//
//  Created by Misha Deneka on 01.03.2023.
//

import Foundation
import Combine

class BaseViewModel<State: ViewModelState>: ObservableObject {

    @Published private(set) var state: State

    var cancellables = Set<AnyCancellable>()

    func start() {
       
    }
    
    func updateState(newValue: State) {
        state = newValue
    }
    
    init(state: State) {
        self.state = state
    }

    deinit {
        cancel()
    }

    private func cancel() {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
}
