//
//  BaseViewController.swift
//  Blanball
//
//  Created by Misha Deneka on 01.03.2023.
//

import UIKit

class BaseViewController<ViewModel>: UIViewController {

    // MARK: - Public properties
    
    var viewModel: ViewModel!

    
    // MARK: - Init

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: Self.self), bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
    }

    func setupView() {
        // Override in subclass to setup view hierarchy and constraints
    }

    func bindViewModel() {
        // Override in subclass to bind viewModel properties to view
    }
}
