//
//  String+Empty.swift
//  Blanball
//
//  Created by Misha Deneka on 03.03.2023.
//

import UIKit

extension String {
    static let empty = ""
    
    func attributed(
        font: UIFont,
        color: UIColor = .black,
        backgroundColor: UIColor = .clear,
        lineHeightMultiple: CGFloat? = nil,
        lineHeight: CGFloat? = nil,
        lineSpacing: CGFloat? = nil,
        textAlignment: NSTextAlignment = .natural,
        lineBreakMode: NSLineBreakMode = .byWordWrapping
    ) -> NSAttributedString? {
        
        let attributeString = NSMutableAttributedString(string: self)
        let style = NSMutableParagraphStyle()
        style.alignment = textAlignment
        style.lineBreakMode = lineBreakMode
        
        if let heightMultiple = lineHeightMultiple {
            style.lineHeightMultiple = heightMultiple
        } else if let lineHeight = lineHeight {
            let heightMultiple = (lineHeight - (lineSpacing ?? 0)) / font.lineHeight
            style.lineHeightMultiple = heightMultiple
        }
        if let lineSpacing = lineSpacing {
            attributeString.addAttribute(NSAttributedString.Key.baselineOffset, value: lineSpacing/2, range: NSRange(location: 0, length: attributeString.length))
            style.lineSpacing = lineSpacing/2
        }
        
        let textAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color,
            .backgroundColor: backgroundColor,
            .paragraphStyle: style
        ]
        attributeString.addAttributes(textAttributes, range: NSRange(location: 0, length: self.count))
        
        return attributeString
    }
    
    func percentEncodedUrl() -> String? {
        if URL(string: self) != nil {
            return self
        }
        return self.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
    }
    
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}
