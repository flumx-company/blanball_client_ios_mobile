//
//  BlanRoundedTextField+Constants.swift
//  Blanball
//
//  Created by Nik Dub on 10.03.2023.
//

import UIKit

extension BlanRoundedTextField {
    enum Constants {
        static let textFieldTopInset: CGFloat = 8
        static let borderWidth: CGFloat = 1
        static let cornerRadius: CGFloat = 6
        static let titleHorizontalPadding: CGFloat = 4
        static let titleHeight: CGFloat = 16
        static let containerHorizontalSpacing: CGFloat = 12
        static let defaultTextInsets = UIEdgeInsets(
            top: 8,
            left: 12,
            bottom: 8,
            right: 8
        )
        static let secureTextInsets = UIEdgeInsets(
            top: 8,
            left: 12,
            bottom: 8,
            right: 38
        )
        static let secureButtonInsets = UIEdgeInsets(
            top: 0,
            left: -18,
            bottom: 0,
            right: 0
        )
        static let secureButtonCommonInset: CGFloat = 18
        static let titleColor = Assets.Colors.Text.primary.color
        static let errorColor = Assets.Colors.Border.Placeholder.error.color
        static let borderColor = Assets.Colors.Border.Placeholder.default.color
    }
}
