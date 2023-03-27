//
//  ResetPasswordViewController.swift
//  Blanball
//
//  Created by Nik Dub on 24.03.2023.
//

import UIKit

class ResetPasswordViewController: BaseViewController<ResetPasswordViewModel> {
    
    // MARK: - Outlets -
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var canvasView: UIView!
    @IBOutlet private weak var emailTextField: BlanRoundedTextField!
    @IBOutlet private weak var sendCodeButton: CommonButton!
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Private methods -
    
    override func setupView() {
        emailTextField.configure(
            title: "Email",
            titleFont: FontFamily.Inter.regular.font(size: 12),
            textFont: FontFamily.Inter.regular.font(size: 13),
            placeholder: "Введіть email",
            placeholderFont: FontFamily.Inter.regular.font(size: 13),
            pattern: AppConstants.Regex.email
        )
        sendCodeButton.configure(
            title: "Надіслати код",
            titleFont: FontFamily.Inter.medium.font(size: 13),
            tintEnabled: Assets.Colors.Text.inverse.color,
            backgroundEnabled: Assets.Colors.Bg.accent.color,
            backgroundDisabled: Assets.Colors.Bg.accent.color.withAlphaComponent(0.7)
        )
        imageView.image = Assets.Images.ukraine.image
//        imageView.backgroundColor =
        canvasView.layer.cornerRadius = 28
        canvasView.clipsToBounds = true
    }
}
