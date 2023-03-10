//
//  CommonButton.swift
//  Blanball
//
//  Created by Nik Dub on 09.03.2023.
//

import UIKit

class CommonButton: UIButton {
    
    //TODO: Implement another solution or enhance current
    
    // MARK: - Private properties -
    
    override var isEnabled: Bool {
        didSet {
            backgroundColor = isEnabled
            ? switchedBackgroundColor.0
            : switchedBackgroundColor.1
        }
    }
    
    private var switchedBackgroundColor: (UIColor?, UIColor?) = (nil, nil) {
        didSet {
            backgroundColor = isEnabled
            ? switchedBackgroundColor.0
            : switchedBackgroundColor.1
        }
    }
    private var disabledBorderColor: UIColor? {
        didSet {
            layer.borderColor = isEnabled
            ? nil
            : disabledBorderColor?.cgColor
        }
    }
    private var switchedTintColor: (UIColor?, UIColor?) = (nil, nil) {
        didSet {
            setTitleColor(switchedTintColor.0, for: .normal)
            setTitleColor(switchedTintColor.1 ?? switchedTintColor.0, for: .disabled)
        }
    }
    
    // MARK: - Internal methods -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }
    
    // MARK: - Internal properties -
    
    // TODO: MAKE INSETS
    
    func configure(
        title: String? = nil,
        titleFont: UIFont? = nil,
        tintEnabled: UIColor? = nil,
        tintDisabled: UIColor? = nil,
        imageEnabled: UIImage? = nil,
        imageDisabled: UIImage? = nil,
        backgroundEnabled: UIColor? = nil,
        backgroundDisabled: UIColor? = nil,
        borderDisabled: UIColor? = nil
    ) {
        setTitle(title, for: .normal)
        switchedTintColor = (tintEnabled, tintDisabled)
        switchedBackgroundColor = (backgroundEnabled, backgroundDisabled)
        disabledBorderColor = borderDisabled
        setImage(imageEnabled, for: .normal)
        tintColor = tintEnabled
    }
    
    private func configureUI() {
        layer.cornerRadius = 6
        clipsToBounds = true
    }
}
