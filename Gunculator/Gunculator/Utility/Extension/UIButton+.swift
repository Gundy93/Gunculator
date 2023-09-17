//
//  UIButton+.swift
//  Gunculator
//
//  Created by Gundy on 2023/09/17.
//

import UIKit

extension UIButton {
    
    convenience init(type buttonType: UIButton.ButtonType = .system,
                     primaryAction: UIAction?,
                     font: UIFont,
                     titleColor title: UIColor,
                     backgroundColor background: UIColor?) {
        self.init(primaryAction: primaryAction)
        self.titleLabel?.font = font
        self.setTitleColor(title, for: .normal)
        self.backgroundColor = background
    }
}
