//
//  UIView.swift
//  Meditator
//
//  Created by Ambuj Punn on 5/22/20.
//  Copyright © 2020 Ambuj Punn. All rights reserved.
//

import UIKit

enum UIViewErrors: Error {
    case layout
}

public extension UIView {
    func addSubviews<S: Sequence>(_ views: S) where S.Element: UIView {
        views.forEach(addSubview)
    }
    
    /// Sets border color of vie
    func setBorder(width: CGFloat = 1, color: UIColor = .black) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
}

// Layout
public extension UIView {
    var width: CGFloat { return bounds.width }
    var height: CGFloat { return bounds.height}
    
    func frameToCenter() {
        guard let superview = superview else { assertionFailure("Superview is nil"); return }
        frame = CGRect(x: superview.width/2 - width/2, y: superview.height/2 - height/2, width: width, height: height)
    }
}
