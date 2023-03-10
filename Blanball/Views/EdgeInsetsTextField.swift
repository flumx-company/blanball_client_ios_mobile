//
//  EdgeInsetsTextField.swift
//  Blanball
//
//  Created by Nik Dub on 06.03.2023.
//

import UIKit

class EdgeInsetsTextField: UITextField {

    var insets: UIEdgeInsets = .zero {
        didSet {
            setNeedsLayout()
        }
    }

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
}
