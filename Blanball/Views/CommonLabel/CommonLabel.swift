//
//  CommonLabel.swift
//  Blanball
//
//  Created by Nik Dub on 10.03.2023.
//

import UIKit

class CommonLabel: UILabel {
    func configure(
        text: String? = nil,
        tintColor: UIColor? = nil,
        font: UIFont? = nil
    ) {
        self.text = text
        self.textColor = tintColor
        self.font = font
    }
}
