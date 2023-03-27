//
//  CommonButton.swift
//  Blanball
//
//  Created by Nik Dub on 09.03.2023.
//

import UIKit

class CommonButton: UIButton {
    
    // MARK: - Internal properties -
    
    @Published private(set) var condition: CommonButtonState
    
    override var isEnabled: Bool {
        didSet {
            backgroundColor = isEnabled
            ? backgroundColors.onColor
            : backgroundColors.offColor
        }
    }
    
    // MARK: - Private properties -
    
    private var backgroundColors: (onColor: UIColor?, offColor: UIColor?) = (nil, nil)
    private var borderColors: (onColor: UIColor?, offColor: UIColor?) = (nil, nil) {
        didSet {
            layer.borderColor = isEnabled
            ? borderColors.onColor?.cgColor
            : borderColors.offColor?.cgColor
        }
    }
    private var tintColors: (onColor: UIColor?, offColor: UIColor?) = (nil, nil) {
        didSet {
            setTitleColor(tintColors.onColor, for: .normal)
            setTitleColor(tintColors.offColor, for: .disabled)
        }
    }
    
    // MARK: - Internal methods -
    
    override init(frame: CGRect) {
        self.condition = .ready
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        self.condition = .ready
        super.init(coder: coder)
        configureUI()
    }
    
    // MARK: - Internal properties -
    
    func apply(state: CommonButtonState) {
        switch state {
        case .ready:
            isEnabled = true
            backgroundColor = backgroundColors.onColor
        case .loading:
            isEnabled = false
            backgroundColor = backgroundColors.offColor
        case .disabled:
            isEnabled = false
            backgroundColor = backgroundColors.offColor
        }
    }
    
    func configure(
        title: String? = nil,
        titleFont: UIFont? = nil,
        tintEnabled: UIColor? = nil,
        tintDisabled: UIColor? = nil,
        imageEnabled: UIImage? = nil,
        imageDisabled: UIImage? = nil,
        backgroundEnabled: UIColor? = nil,
        backgroundDisabled: UIColor? = nil,
        borderEnabled: UIColor? = nil,
        borderDisabled: UIColor? = nil
    ) {
        setTitle(title, for: .normal)
        tintColors = (tintEnabled, tintDisabled)
        backgroundColors = (backgroundEnabled, backgroundDisabled)
        borderColors = (borderEnabled, borderDisabled)
        setImage(imageEnabled, for: .normal)
        tintColor = tintEnabled
        apply(state: .ready)
    }
    
    private func configureUI() {
        imageEdgeInsets = Constants.imageInsets
        layer.cornerRadius = 6
        clipsToBounds = true
    }
}

extension CommonButton {
    enum Constants {
        static let imageInsets = UIEdgeInsets(
            top: 1,
            left: 1,
            bottom: 1,
            right: 17
        )
    }
}
