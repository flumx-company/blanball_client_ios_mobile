//
//  CheckBox.swift
//  Blanball
//
//  Created by Nik Dub on 10.03.2023.
//

import UIKit

class CheckBox: UIView {
    
    // MARK: - Internal properties -
    
    @Published private(set) var state: CheckBoxState {
        didSet {
            apply(state: state)
        }
    }
    
    // MARK: - Private properties -
    
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
    
    // MARK: - Internal methods -
    
    func setInitState(_ value: CheckBoxState) {
        state = value
    }
    
    func toggleState() {
        guard state != .disabled else { return }
        state = state == .selected ? .deselected : .selected
    }
    
    // MARK: - Private methods -
    
    private func configureUI() {
        setupConstraints()
    }
    
    private func setupConstraints() {
        addSubview(checkBox)
        NSLayoutConstraint.activate([
            checkBox.heightAnchor.constraint(
                equalTo: heightAnchor
            ),
            checkBox.widthAnchor.constraint(
                equalTo: checkBox.heightAnchor
            ),
            checkBox.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            checkBox.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
    
    private func apply(state: CheckBoxState) {
        switch state {
        case .selected:
            checkBox.isEnabled = true
            checkBox.isSelected = true
        case .deselected:
            checkBox.isEnabled = true
            checkBox.isSelected = false
        case .disabled:
            checkBox.isEnabled = false
        }
    }
    
    // MARK: - Actions -
    
    @objc private func checkBoxTapped() {
        checkBox.isSelected.toggle()
    }
}
