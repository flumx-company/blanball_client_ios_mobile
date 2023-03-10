//
//  UnderlinedDashButton.swift
//  Blanball
//
//  Created by Nik Dub on 10.03.2023.
//

import UIKit

class UnderlinedDashButton: UIView {
    
    // MARK: - Private properties -
    
    private lazy var mainButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(
            self,
            action: #selector(checkBoxTapped),
            for: .touchUpInside
        )
        button.isEnabled = true
        return button
    }()
    
    // MARK: - Internal methods -
    
    override init(frame: CGRect) {
//        state = .deselected
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
//        state = .deselected
        super.init(coder: coder)
        configureUI()
    }
    
    func configure(
        title: String? = nil,
        font: UIFont? = nil,
        color: UIColor? = nil
    ) {
        mainButton.setAttributedTitle(
            NSAttributedString(
                string: title ?? "",
                attributes: [.font: font as Any, .foregroundColor: color as Any]
            ),
            for: .normal
        )
    }
    
    // MARK: - Private properties -
    
    private func setupConstraints() {
        addSubview(mainButton)
        NSLayoutConstraint.activate([
            mainButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            mainButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            mainButton.widthAnchor.constraint(equalTo: self.widthAnchor),
            mainButton.heightAnchor.constraint(equalTo: self.heightAnchor),
            self.leadingAnchor.constraint(equalTo: mainButton.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: mainButton.trailingAnchor)
        ])
    }
    
    // TODO: Clean up
    
    private func configureUI() {
        setupConstraints()
        let caShapeLayer = CAShapeLayer()
        caShapeLayer.strokeColor = Assets.Colors.Border.Placeholder.default.color.cgColor
        caShapeLayer.lineWidth = 1
        caShapeLayer.lineDashPattern = [2,3]
        let cgPath = CGMutablePath()
        let cgPoint = [CGPoint(x: 0, y: frame.maxY), CGPoint(x: frame.maxX, y: frame.maxY)]
        cgPath.addLines(between: cgPoint)
        caShapeLayer.path = cgPath
        layer.addSublayer(caShapeLayer)
        clipsToBounds = true
    }
    
    // MARK: - Actions -
    
    @objc private func checkBoxTapped() {
        
    }
}
