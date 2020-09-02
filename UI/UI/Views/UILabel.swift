//
//  UILabel.swift
//  UI
//
//  Created by Ambuj Punn on 7/30/20.
//  Copyright © 2020 Ambuj Punn. All rights reserved.
//

import UIKit

public enum MDLabelStyle {
    case body(FontStyle)
    case headline(FontStyle)
    case title1(FontStyle)
    case title2(FontStyle)
    case largeTitle(FontStyle)
    case caption(FontStyle)
}

extension MDLabelStyle: Styleable {
    public typealias ElementType = UILabel
    
    public var style: Styler<MDLabelStyle> {
        let fontInfo: (UIFont.TextStyle, UIFont)
        switch self {
        case .body(let fontStyle): fontInfo = (.body, fontStyle.style.value)
        case .headline(let fontStyle): fontInfo = (.headline, fontStyle.style.value)
        case .title1(let fontStyle): fontInfo = (.title1, fontStyle.style.value)
        case .title2(let fontStyle): fontInfo = (.title2, fontStyle.style.value)
        case .largeTitle(let fontStyle): fontInfo = (.largeTitle, fontStyle.style.value)
        case .caption(let fontStyle): fontInfo = (.caption1, fontStyle.style.value)
        }

        let label = UILabel()
        label.font = UIFontMetrics(forTextStyle: fontInfo.0).scaledFont(for: fontInfo.1)
        label.adjustsFontForContentSizeCategory = true
        return Styler<MDLabelStyle>(value: label)
    }
}


public extension UILabel {
    
//    static func body(fontStyle: Styler<FontStyle> = FontStyle.regular.style, _ text: String, alignment: NSTextAlignment = .left) -> UILabel {
    static func body(fontStyle: FontStyle = .regular, _ text: String, alignment: NSTextAlignment = .left) -> UILabel {
        let label = MDLabelStyle.body(fontStyle).style.value
        label.text = text
        label.textAlignment = alignment
        return label
    }
}
