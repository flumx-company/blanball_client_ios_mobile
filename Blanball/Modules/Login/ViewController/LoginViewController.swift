//
//  LoginViewController.swift
//  Blanball
//
//  Created by Nikita Dubovik on 03.03.2023.
//

import UIKit
import Combine

class LoginViewController: BaseViewController<LoginViewModel> {
    
    @IBOutlet private weak var logoImageView: UIImageView!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var loginTextField: BlanRoundedTextField!
    @IBOutlet private weak var passwordTextField: BlanRoundedTextField!
    @IBOutlet private weak var checkBoxButton: UIButton!
    @IBOutlet private weak var agreementLabel: UILabel!
    @IBOutlet private weak var loginButton: CommonButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.start()
        configureUI()
    }
    
    override func setupView() {
        viewModel.emailSubject.send(.idle)
    }
    
    private func configureUI() {
        loginTextField.configure(
            title: "Логін",
            placeholder: "Введіть логін"
        )
        passwordTextField.configure(
            title: "Пароль",
            placeholder: "Введіть пароль",
            isSecure: true
        )
        loginButton.configure(
            title: "Увійти",
            tintEnabled: Assets.Colors.Text.inverse.color,
            backgroundEnabled: Assets.Colors.Bg.accent.color,
            backgroundDisabled: Assets.Colors.Bg.accent.color.withAlphaComponent(0.7)
        )
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
