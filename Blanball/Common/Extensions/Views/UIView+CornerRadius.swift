//
//  UIView+CornerRadius.swift
//  Blanball
//
//  Created by Nik Dub on 06.03.2023.
//

import UIKit

extension UIView {
    func apply(cornerRadius value: CGFloat) {
        layer.cornerRadius = value
        layer.masksToBounds = true
    }
}
