//
//  Font.swift
//  UI
//
//  Created by Ambuj Punn on 7/30/20.
//  Copyright © 2020 Ambuj Punn. All rights reserved.
//

import UIKit

public protocol Styleable {
    associatedtype ElementType
    
    var style: Styler<Self> { get }
}

public struct Styler<T: Styleable> {
    public var value: T.ElementType
}

public enum FontStyle {
    case regular
    case lightRegular
    case bold
    case custom(String)
}

extension FontStyle: Styleable {
    public typealias ElementType = UIFont
    
    public var style: Styler<FontStyle> {
        let fontManager = ResourceManager<FontResources>()
        let customFont: UIFont
        switch self {
        case .regular: customFont = fontManager.value(for: .regular) 
        case .lightRegular: customFont = fontManager.value(for: .lightRegular)
        case .bold: customFont = fontManager.value(for: .bold)
        case .custom(let font): customFont = fontManager.value(for: .custom(font))
        }
        return Styler<FontStyle>(value: customFont)
    }
}

public extension UIFont {
    static var regular: UIFont { FontStyle.regular.style.value }
    static var lightRegular: UIFont { FontStyle.regular.style.value }
    static var bold: UIFont { FontStyle.regular.style.value }
    static func custom(_ description: String) -> UIFont { FontStyle.custom(description).style.value }

}
