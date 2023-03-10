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
    
    var pattern: String?
    
    override var backgroundColor: UIColor? {
        didSet {
            labelContainerView.backgroundColor = backgroundColor
        }
    }
    
    // MARK: - Private properties -
    
    private lazy var errorLabelHeightConstraint: NSLayoutConstraint = {
        errorLabel.heightAnchor.constraint(
            equalToConstant: .zero
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
        return label
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 12)
        label.isHidden = true
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
        tf.layer.borderColor = Constants.borderColor.cgColor
        tf.apply(cornerRadius: Constants.cornerRadius)
        tf.delegate = self
        tf.isSecureTextEntry = false
        return tf
    }()
    
    private lazy var secureFieldButton: UIButton = {
        let button = UIButton(type: .custom)
        button.imageEdgeInsets = Constants.secureButtonInsets
        button.tintColor = Assets.Colors.Text.sublet.color
        button.frame = CGRect(
            x: editingTextField.frame.size.width - Constants.secureButtonCommonInset,
            y: .zero,
            width: Constants.secureButtonCommonInset,
            height: Constants.secureButtonCommonInset
        )
        button.addTarget(
            self,
            action: #selector(secureButtonTapped),
            for: .touchUpInside
        )
        editingTextField.rightView = button
        editingTextField.rightViewMode = .always
        button.setImage(
            Assets.Images.eyeOff.image,
            for: .normal
        )
        button.setImage(
            Assets.Images.eye.image,
            for: .selected
        )
        return button
    }()
    
    // MARK: - Init -
    
    override init(frame: CGRect) {
        state = .updated(value: nil, isValid: true)
        super.init(frame: frame)
        configureUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        state = .updated(value: nil, isValid: true)
        super.init(coder: coder)
        configureUI()
        setupConstraints()
    }
    
    // MARK: - Internal properties -
    
    // TODO: Make single configure function
    
    func configure(
        title: String? = nil,
        titleFont: UIFont? = nil,
        text: String? = nil,
        textFont: UIFont? = nil,
        placeholder: String? = nil,
        placeholderFont: UIFont? = nil,
        isSecure: Bool = false,
        pattern: String? = nil
    ) {
        titleLabel.text = title
        titleLabel.font = titleFont
        editingTextField.text = text
        editingTextField.attributedPlaceholder = NSAttributedString(
            string: placeholder ?? "",
            attributes: [.font: placeholderFont as Any]
        )
        editingTextField.attributedText = NSAttributedString(
            string: text ?? "",
            attributes: [.font: textFont as Any]
        )
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
    
    private func configureUI() {
        backgroundColor = Assets.Colors.Bg.primary.color
    }
    
    private func setupViewState(isValid: Bool) {
        errorLabel.isHidden = isValid
        editingTextField.layer.borderColor = isValid
        ? Constants.borderColor.cgColor
        : Constants.errorColor.cgColor
        titleLabel.textColor = isValid
        ? Constants.titleColor
        : Constants.errorColor
        self.errorLabelHeightConstraint.constant = isValid ? .zero : 20
        UIView.animate(withDuration: 0.1, delay: .zero, options: .curveEaseInOut) {
            self.view.layoutIfNeeded()
        }
    }
    
    // TODO: Modify regex characters
    
    private func isValid(string: String, literalRegex: String) -> Bool {
        let test = NSPredicate(format: "SELF MATCHES %@", literalRegex)
        return test.evaluate(with: string)
    }
    
    private func setupConstraints() {
        addSubview(editingTextField)
        addSubview(labelContainerView)
        addSubview(errorLabel)
        labelContainerView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            editingTextField.leadingAnchor.constraint(
                equalTo: self.leadingAnchor
            ),
            editingTextField.trailingAnchor.constraint(
                equalTo: self.trailingAnchor
            ),
            editingTextField.topAnchor.constraint(
                equalTo: self.topAnchor,
                constant: Constants.textFieldTopInset
            ),
            
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
            
            labelContainerView.leadingAnchor.constraint(
                equalTo: editingTextField.leadingAnchor,
                constant: Constants.containerHorizontalSpacing
            ),
            labelContainerView.trailingAnchor.constraint(
                lessThanOrEqualTo: editingTextField.trailingAnchor,
                constant: -Constants.containerHorizontalSpacing
            ),
            labelContainerView.trailingAnchor.constraint(
                equalTo: titleLabel.trailingAnchor,
                constant: 4
            ),
            labelContainerView.centerYAnchor.constraint(
                equalTo: editingTextField.topAnchor
            ),
            labelContainerView.heightAnchor.constraint(
                equalTo: titleLabel.heightAnchor
            ),
            
            titleLabel.leadingAnchor.constraint(
                equalTo: labelContainerView.leadingAnchor,
                constant: Constants.titleHorizontalPadding
            ),
            titleLabel.trailingAnchor.constraint(
                lessThanOrEqualTo: labelContainerView.trailingAnchor,
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
    
    @objc private func secureButtonTapped()  {
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
