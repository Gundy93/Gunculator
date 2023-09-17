//
//  UIStackView+.swift
//  Gunculator
//
//  Created by Gundy on 2023/09/17.
//

import UIKit

extension UIStackView {
    
    convenience init(arrangedSubviews views: [UIView] = [],
                     spacing: CGFloat = 0,
                     axis: NSLayoutConstraint.Axis = .horizontal,
                     alignment: UIStackView.Alignment = .fill,
                     distribution: UIStackView.Distribution = .fill) {
        self.init(arrangedSubviews: views)
        
        self.spacing = spacing
        self.axis = axis
        self.alignment = alignment
        self.distribution = distribution
        translatesAutoresizingMaskIntoConstraints = false
    }
}
