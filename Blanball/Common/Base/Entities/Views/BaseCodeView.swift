//
//  BaseCodeView.swift
//  Blanball
//
//  Created by Misha Deneka on 10.03.2023.
//

import UIKit

class BaseCodeView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }
    
    func setupSubviews() {}
}
