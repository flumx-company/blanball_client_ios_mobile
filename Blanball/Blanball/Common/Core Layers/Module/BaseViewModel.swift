//
//  BaseViewModel.swift
//  Blanball
//
//  Created by Misha Deneka on 01.03.2023.
//

import Combine

class BaseViewModel<State>: ObservableObject {

    @Published var state: State

    private var cancellables = Set<AnyCancellable>()

    init(state: State) {
        self.state = state
    }

    deinit {
        cancel()
    }
    
    func bind() {
       
    }

    func cancel() {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
}
