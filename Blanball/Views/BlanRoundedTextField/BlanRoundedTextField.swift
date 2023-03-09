//
//  BlanRoundedTextField.swift
//  Blanball
//
//  Created by Nik Dub on 06.03.2023.
//

import UIKit
import Combine

class BlanRoundedTextField: UIView {
    
    // MARK: - Internal properties -
    
    @Published private(set) var state: BlanRoundedTextFieldState
    
    override var backgroundColor: UIColor? {
        didSet {
            labelContainerView.backgroundColor = backgroundColor
        }
    }
    
    // MARK: - Private properties -
    
    private lazy var errorLabelHeightConstraint: NSLayoutConstraint = {
        errorLabel.heightAnchor.constraint(
            equalToConstant: 15
        )
    }()
    
    private lazy var labelContainerView: UIView = {
        let container = UIView(frame: .zero)
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = backgroundColor
        container.clipsToBounds = true
        return container
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.text = "Логін"
        return label
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "* Перевірте правильність введених даних"
        return label
    }()
    
    private lazy var editingTextField: EdgeInsetsTextField = {
        let tf = EdgeInsetsTextField(frame: .zero)
        tf.insets = Constants.defaultTextInsets
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = .clear
        tf.borderStyle = .none
        tf.layer.borderWidth = Constants.borderWidth
        tf.layer.borderColor = Assets.Colors.Border.Placeholder.default.color.cgColor
        tf.apply(cornerRadius: Constants.cornerRadius)
        tf.delegate = self
        return tf
    }()
    
//    eye-off
    
    private lazy var secureFieldButton: UIButton = {
        let button = UIButton(type: .custom)
        button.imageEdgeInsets = Constants.secureButtonInsets
        button.tintColor = Assets.Colors.Text.sublet.color
        button.frame = CGRect(
            x: editingTextField.frame.size.width - 18,
            y: .zero,
            width: 18,
            height: 18
        )
        button.addTarget(self, action: #selector(secureButtonDidTap), for: .touchUpInside)
        editingTextField.rightView = button
        editingTextField.rightViewMode = .always
        button.setImage(UIImage(named: "eye-off"), for: .normal)
        button.setImage(UIImage(named: "eye"), for: .selected)
        return button
    }()
    
    // MARK: - Init -
    
    override init(frame: CGRect) {
        state = .updated(value: nil, isValid: true)
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        state = .updated(value: nil, isValid: true)
        super.init(coder: coder)
        setupUI()
        setupConstraints()
        setSecureEntryMode(true)
    }
    
    // MARK: - Internal properties -
    
    // TODO: Make single configure function
    
    func configure(
        title: String?,
        with titleFont: UIFont? = nil,
        text: String?,
        with textFont: UIFont? = nil,
        placeholder: String?,
        with placeholderFont: UIFont? = nil,
        isSecure: Bool = false,
        pattern: String? = nil
    ) {
        editingTextField.text = text
        setSecureEntryMode(isSecure)
    }
    
    func setTitleText(_ text: String?) {
        guard let unwrapped = text, !unwrapped.isEmpty else {
            labelContainerView.isHidden = true
            return
        }
        titleLabel.text = text
        labelContainerView.isHidden = false
    }
    
    func setPlaceholder(text: String?) {
        editingTextField.placeholder = text
    }
    
    // MARK: - Private methods -
    
    private func setSecureEntryMode(_ isSecure: Bool) {
        editingTextField.isSecureTextEntry = isSecure
        editingTextField.rightView = isSecure ? secureFieldButton : nil
        editingTextField.rightViewMode = isSecure ? .always : .never
        editingTextField.insets = isSecure ? Constants.secureTextInsets : Constants.defaultTextInsets
    }
    
    private func setupUI() {
        backgroundColor = Assets.Colors.Bg.primary.color
    }
    
    private func setupViewState(isValid: Bool) {
        errorLabel.isHidden = true
//        errorLabelHeightConstraint.constant = isValid ? .zero : 20
    }
    
    // TODO: Modify regex characters
    
    private func isValid(string: String, literalRegex: String) -> Bool {
        let test = NSPredicate(format: "SELF MATCHES %@", literalRegex)
        return test.evaluate(with: string)
//        #"^[А-ЩЬЮЯҐЄІЇа-щьюяґєії \x{2019} ' –-]{1,}$"#
    }
    
    private func setupConstraints() {
        addSubview(editingTextField)
        addSubview(labelContainerView)
        addSubview(errorLabel)
        labelContainerView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            editingTextField.leftAnchor.constraint(
                equalTo: self.leftAnchor
            ),
            editingTextField.rightAnchor.constraint(
                equalTo: self.rightAnchor
            ),
            editingTextField.topAnchor.constraint(
                equalTo: self.topAnchor,
                constant: Constants.textFieldTopInset
            ),
            // TODO: Add `Error` case handling
            
            errorLabel.leadingAnchor.constraint(
                equalTo: self.leadingAnchor
            ),
            errorLabel.topAnchor.constraint(
                equalTo: editingTextField.bottomAnchor
            ),
            errorLabel.trailingAnchor.constraint(
                equalTo: self.trailingAnchor
            ),
            errorLabel.bottomAnchor.constraint(
                equalTo: self.bottomAnchor
            ),
            errorLabelHeightConstraint,
            
            labelContainerView.leftAnchor.constraint(
                equalTo: editingTextField.leftAnchor,
                constant: Constants.containerHorizontalSpacing
            ),
            labelContainerView.rightAnchor.constraint(
                lessThanOrEqualTo: editingTextField.rightAnchor,
                constant: -Constants.containerHorizontalSpacing
            ),
            labelContainerView.rightAnchor.constraint(
                equalTo: titleLabel.rightAnchor
            ),
            labelContainerView.centerYAnchor.constraint(
                equalTo: editingTextField.topAnchor
            ),
            labelContainerView.heightAnchor.constraint(
                equalTo: titleLabel.heightAnchor
            ),
            
            titleLabel.leftAnchor.constraint(
                equalTo: labelContainerView.leftAnchor,
                constant: Constants.titleHorizontalPadding
            ),
            titleLabel.rightAnchor.constraint(
                lessThanOrEqualTo: labelContainerView.rightAnchor,
                constant: -Constants.titleHorizontalPadding
            ),
            titleLabel.topAnchor.constraint(
                equalTo: labelContainerView.topAnchor
            ),
            titleLabel.bottomAnchor.constraint(
                equalTo: labelContainerView.bottomAnchor
            )
        ])
    }
    
    // MARK: - Actions -
    
    @objc private func secureButtonDidTap()  {
        secureFieldButton.isSelected.toggle()
        editingTextField.isSecureTextEntry.toggle()
    }
}

// MARK: - Extension -

extension BlanRoundedTextField: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        setupViewState(isValid: textField.text?.isEmpty ?? false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension BlanRoundedTextField {
    enum Constants {
        static let textFieldTopInset: CGFloat = 8
        static let borderWidth: CGFloat = 1
        static let cornerRadius: CGFloat = 6
        static let titleHorizontalPadding: CGFloat = 4
        static let titleHeight: CGFloat = 16
        static let containerHorizontalSpacing: CGFloat = 12
        static let defaultTextInsets = UIEdgeInsets(
            top: 8,
            left: 12,
            bottom: 8,
            right: 8
        )
        static let secureTextInsets = UIEdgeInsets(
            top: 8,
            left: 12,
            bottom: 8,
            right: 38
        )
        static let secureButtonInsets = UIEdgeInsets(
            top: 0,
            left: -18,
            bottom: 0,
            right: 0
        )
    }
}
