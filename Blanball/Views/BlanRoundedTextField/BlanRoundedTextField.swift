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
    
    private lazy var editingTextField: EdgeInsetsTextField = {
        let tf = EdgeInsetsTextField(frame: .zero)
        tf.insets = Constants.textInsets
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = .clear
        tf.borderStyle = .none
        tf.layer.borderWidth = Constants.borderWidth
        tf.layer.borderColor = Assets.Colors.Border.Placeholder.default.color.cgColor
        tf.apply(cornerRadius: Constants.cornerRadius)
        tf.delegate = self
        return tf
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
    
    private func setupUI() {
        backgroundColor = Assets.Colors.Bg.primary.color
    }
    
    private func setupViewState(isValid: Bool) {}
    
    // TODO: Modify regex characters
    
    private func isValid(string: String) -> Bool {
        let literalRegex = #"^[А-ЩЬЮЯҐЄІЇа-щьюяґєії \x{2019} ' –-]{1,}$"#
        let test = NSPredicate(format: "SELF MATCHES %@", literalRegex)
        return test.evaluate(with: string)
    }
    
    private func setupConstraints() {
        addSubview(editingTextField)
        addSubview(labelContainerView)
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
            editingTextField.bottomAnchor.constraint(
                equalTo: self.bottomAnchor,
                constant: .zero
            ),
            
            labelContainerView.leftAnchor.constraint(
                equalTo: editingTextField.leftAnchor,
                constant: Constants.containerHorizontalSpacing
            ),
            labelContainerView.rightAnchor.constraint(
                lessThanOrEqualTo: editingTextField.rightAnchor, constant: -Constants.containerHorizontalSpacing
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
}

// MARK: - Extension -

extension BlanRoundedTextField: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        titleLabel.text = textField.text
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
        static let textInsets = UIEdgeInsets(
            top: 8,
            left: 12,
            bottom: 8,
            right: 8
        )
    }
}
