//
//  LoadingViewController.swift
//  Blanball
//
//  Created by Nik Dub on 08.03.2023.
//

import UIKit

class LoadingSpinnerView: UIView {
    
    // MARK: - Outlets -
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var spinnerImageView: UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = Assets.Images.spinner.image
        return iv
    }()
    
    private lazy var backgroundView: UIView = {
        let cw = UIView(frame: .zero)
        cw.translatesAutoresizingMaskIntoConstraints = false
        cw.backgroundColor = Assets.Colors.Bg.forModals.color
        return cw
    }()
    
    private lazy var containerView: UIView = {
        let cw = UIView(frame: .zero)
        cw.translatesAutoresizingMaskIntoConstraints = false
        cw.backgroundColor = .clear
        return cw
    }()
    
    // MARK: - Lifecycle -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        initialSetup()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupConstraints()
        initialSetup()
        setupViews()
    }
    
//    override func () {
//        super.viewDidLoad()
//        initialSetup()
//        setupViews()
//    }
//
    
    override func layoutSubviews() {
        super.layoutSubviews()
        startSpinning()
    }
    
    // MARK: - Internal methods -
    
    func configure(
        text: String? = nil,
        tintColor: UIColor? = nil,
        font: UIFont? = nil
    ) {
        titleLabel.configure(
            text: text,
            tintColor: tintColor,
            font: font
        )
    }
    
    func startSpinning() {
        rotate()
    }
    
    func stopSpinning() {
        spinnerImageView.layer.removeAnimation(forKey: Constants.rotationAnimationKey)
    }
    
    // MARK: - Private methods -
    
    private func initialSetup() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applicationDidBecomeActive),
            name: UIApplication.didBecomeActiveNotification,
            object: nil
        )
    }
    
    private func setupViews() {
        titleLabel.configure(
            text: "Завантаження",
            tintColor: Assets.Colors.Text.inverse.color,
            font: FontFamily.Inter.regular.font(size: 14)
        )
    }
    
    private func rotate() {
        let rotation: CABasicAnimation = CABasicAnimation(
            keyPath: Constants.transformRotationZKey
        )
        rotation.toValue = NSNumber(value: Constants.angle)
        rotation.duration = Constants.duration
        rotation.isCumulative = Constants.isCumulative
        rotation.repeatCount = Float.greatestFiniteMagnitude
        spinnerImageView.layer.add(rotation, forKey: Constants.rotationAnimationKey)
    }
    
    private func setupConstraints() {
        addSubview(backgroundView)
        backgroundView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(spinnerImageView)
        NSLayoutConstraint.activate([
            
            backgroundView.leadingAnchor.constraint(
                equalTo: leadingAnchor
            ),
            
            backgroundView.trailingAnchor.constraint(
                equalTo: trailingAnchor
            ),
            
            backgroundView.bottomAnchor.constraint(
                equalTo: bottomAnchor
            ),
            
            backgroundView.topAnchor.constraint(
                equalTo: topAnchor
            ),
            
            containerView.centerYAnchor.constraint(
                equalTo: backgroundView.centerYAnchor
            ),
            
            containerView.centerXAnchor.constraint(
                equalTo: backgroundView.centerXAnchor
            ),
            
            spinnerImageView.centerXAnchor.constraint(
                equalTo: containerView.centerXAnchor
            ),
            
            spinnerImageView.widthAnchor.constraint(
                equalToConstant: 114
            ),
            
            spinnerImageView.topAnchor.constraint(
                equalTo: containerView.topAnchor
            ),
            
            spinnerImageView.bottomAnchor.constraint(
                equalTo: titleLabel.topAnchor,
                constant: -12
            ),
            
            spinnerImageView.heightAnchor.constraint(
                equalTo: spinnerImageView.widthAnchor
            ),
            
            titleLabel.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor
            ),
            
            titleLabel.trailingAnchor.constraint(
                equalTo: containerView.trailingAnchor
            ),
            
            titleLabel.bottomAnchor.constraint(
                equalTo: containerView.bottomAnchor
            ),
            
            titleLabel.heightAnchor.constraint(
                equalToConstant: 20
            ),
        ])
    }
    
    // MARK: - Actions -
    
    @objc private func applicationDidBecomeActive() {
        startSpinning()
    }
    
    // MARK: - Deinit -
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension LoadingSpinnerView {
    enum Constants {
        static let transformRotationZKey = "transform.rotation.z"
        static let rotationAnimationKey = "rotationAnimation"
        static let duration: CFTimeInterval = 1.25
        static let isCumulative = true
        static let angle = Double.pi * 2
    }
}
