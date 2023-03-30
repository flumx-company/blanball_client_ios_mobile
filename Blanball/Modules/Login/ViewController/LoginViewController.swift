//
//  LoginViewController.swift
//  Blanball
//
//  Created by Nikita Dubovik on 03.03.2023.
//

import UIKit
import Combine

class LoginViewController: BaseViewController<LoginViewModel> {
    
    // MARK: - Outlets -
    
    @IBOutlet private weak var logoImageView: UIImageView!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var loginTextField: TitledTextField!
    @IBOutlet private weak var passwordTextField: TitledTextField!
    @IBOutlet private weak var checkBoxButton: CheckBox!
    @IBOutlet private weak var saveUserContainerView: UIView!
    @IBOutlet private weak var saveUserLabel: UILabel!
    @IBOutlet private weak var loginButton: CommonButton!
    @IBOutlet private weak var forgotPasswordButton: UnderlinedDashButton!
    @IBOutlet private weak var signUpButton: UnderlinedDashButton!
    @IBOutlet private weak var signUpLabel: UILabel!
    @IBOutlet private weak var alternativeLabel: UILabel!
    @IBOutlet private weak var appleSignInButton: CommonButton!
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.start()
        bindLoginTextField()
        bindPasswordTextField()
        bindForgotPasswordButton()
    }

    override func setupView() {
        logoImageView.image = Assets.Images.blanballLogo.image
        titleLabel.configure(
            text: "Blanball",
            tintColor: Assets.Colors.Bg.dark.color,
            font: FontFamily.Exo2.bold.font(size: 36)
        )
        subtitleLabel.configure(
            text: "Авторизація у системі",
            tintColor: Assets.Colors.Bg.dark.color,
            font: FontFamily.Exo2.bold.font(size: 23)
        )
        loginTextField.configure(
            title: "Логін",
            titleFont: FontFamily.Inter.regular.font(size: 12),
            textFont: FontFamily.Inter.regular.font(size: 13),
            placeholder: "Введіть логін",
            placeholderFont: FontFamily.Inter.regular.font(size: 13),
            pattern: AppConstants.Regex.email
        )
        passwordTextField.configure(
            title: "Пароль",
            titleFont: FontFamily.Inter.regular.font(size: 12),
            textFont: FontFamily.Inter.regular.font(size: 13),
            placeholder: "Введіть пароль",
            placeholderFont: FontFamily.Inter.regular.font(size: 13),
            isSecure: true,
            pattern: AppConstants.Regex.password
        )
        forgotPasswordButton.configure(
            title: "Я не пам'ятаю пароль",
            font: FontFamily.Inter.regular.font(size: 12),
            color: Assets.Colors.Text.primary.color
        )
        signUpButton.configure(
            title: "Зареєструватися",
            font: FontFamily.Inter.regular.font(size: 12),
            color: Assets.Colors.Text.primary.color
        )
        signUpLabel.configure(
            text: "Ще не маєте акаунту?",
            tintColor: Assets.Colors.Border.Placeholder.selected.color,
            font: FontFamily.Inter.regular.font(size: 12)
        )
        alternativeLabel.configure(
            text: "або",
            tintColor: Assets.Colors.Text.sublet.color,
            font: FontFamily.Inter.regular.font(size: 12)
        )
        appleSignInButton.configure(
            title: "Продовжити з Apple",
            titleFont: FontFamily.Inter.bold.font(size: 14),
            tintEnabled: .white,
            imageEnabled: Assets.Images.appleLogo.image,
            backgroundEnabled: .black
        )
        loginButton.configure(
            title: "Увійти",
            titleFont: FontFamily.Inter.medium.font(size: 13),
            tintEnabled: Assets.Colors.Text.inverse.color,
            backgroundEnabled: Assets.Colors.Bg.accent.color,
            backgroundDisabled: Assets.Colors.Bg.accent.color.withAlphaComponent(0.7)
        )
        saveUserLabel.configure(
            text: "Запам'ятати мене",
            tintColor: Assets.Colors.Bg.Btn.selected.color,
            font: FontFamily.Inter.regular.font(size: 12)
        )
        saveUserContainerView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(saveUserViewTapped)
            )
        )
        loginButton.addTarget(
            self,
            action: #selector(loginButtonTapped),
            for: .touchUpInside
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
    
    private func bindLoginTextField() {
        viewModel.subscribeToLoginTextFieldPublisher(
            loginTextField.$state.eraseToAnyPublisher()
        )
    }
    
    private func bindPasswordTextField() {
        viewModel.subscribeToLoginTextFieldPublisher(
            passwordTextField.$state.eraseToAnyPublisher()
        )
    }
    
    private func bindForgotPasswordButton() {
        viewModel.subscribeToForgotPasswordButtonPublisher(
            forgotPasswordButton.$state.eraseToAnyPublisher()
        )
    }
    
    // MARK: - Actions -
    
    @objc private func loginButtonTapped() {
        showLoadingSpinner()
    }
    
    @objc private func saveUserViewTapped() {
        checkBoxButton.toggleState()
    }
}
