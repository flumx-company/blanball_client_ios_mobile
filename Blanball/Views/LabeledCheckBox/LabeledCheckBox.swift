//
//  LabeledCheckBox.swift
//  Blanball
//
//  Created by Nik Dub on 10.03.2023.
//

import UIKit

class LabeledCheckBox: UIView {
    
    // MARK: - Internal properties -
    
    @Published private(set) var state: LabeledCheckBoxState
    
    // MARK: - Private properties -
    
    private lazy var headlineLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    private lazy var checkBox: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(
            self,
            action: #selector(checkBoxTapped),
            for: .touchUpInside
        )
        button.setImage(
            Assets.Images.checkBoxOff.image,
            for: .normal
        )
        button.setImage(
            Assets.Images.checkBoxOn.image,
            for: .selected
        )
        button.isEnabled = true
        return button
    }()
    
    // MARK: - Internal methods -
    
    override init(frame: CGRect) {
        state = .deselected
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        state = .deselected
        super.init(coder: coder)
        configureUI()
    }
    
    // MARK: - Internal properties -
    
    func configure(
        title: String? = nil,
        with titleColor: UIColor? = nil,
        font: UIFont? = nil
    ) {
        headlineLabel.text = title
        headlineLabel.textColor = titleColor
        headlineLabel.font = font
    }
    
    // MARK: - Private methods -
    
    private func configureUI() {
        setupConstraints()
    }
    
    private func setupConstraints() {
        addSubview(checkBox)
        addSubview(headlineLabel)
        NSLayoutConstraint.activate([
            checkBox.heightAnchor.constraint(
                equalToConstant: 20
            ),
            checkBox.widthAnchor.constraint(
                equalTo: checkBox.heightAnchor
            ),
            checkBox.leadingAnchor.constraint(
                equalTo: self.leadingAnchor
            ),
            checkBox.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            headlineLabel.leadingAnchor.constraint(
                equalTo: checkBox.trailingAnchor,
                constant: 7
            ),
            headlineLabel.trailingAnchor.constraint(
                equalTo: self.trailingAnchor,
                constant: 7
            ),
            headlineLabel.centerYAnchor.constraint(
                equalTo: checkBox.centerYAnchor
            )
        ])
    }
    
    // MARK: - Actions -
    
    @objc private func checkBoxTapped() {
        checkBox.isSelected.toggle()
    }
}
