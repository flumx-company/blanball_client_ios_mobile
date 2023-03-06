//
//  LoginViewController.swift
//  Blanball
//
//  Created by Nikita Dubovik on 03.03.2023.
//

import UIKit
import Combine

class LoginViewController: BaseViewController<LoginViewModel> {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var loginTextField: BlanRoundedTextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var agreementLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.start()
    }
    
    override func setupView() {
        viewModel.emailSubject.send(.idle)
    }
    
    override func bindViewModel() {
        viewModel
            .$state
            .sink { state in
                switch state {
                case .started:
                    break
                case .failure(error: _):
                    break
                case .loading:
                    break
                case .updated:
                    break
                }
            }.store(in: &viewModel.cancellables)
    }
}
