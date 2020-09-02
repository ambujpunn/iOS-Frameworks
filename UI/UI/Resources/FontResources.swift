//
//  FontResources.swift
//  UI
//
//  Created by Ambuj Punn on 8/3/20.
//  Copyright © 2020 Ambuj Punn. All rights reserved.
//

import UIKit

public enum FontResources {
    case regular
    case lightRegular
    case bold
    case custom(String)
}

extension FontResources: Resourceable {
    public typealias ResourceType = UIFont
    
    public var resource: Resource<FontResources> {
        let customFontName: String
        switch self {
        case .regular: customFontName = Files.allerRegular
        case .lightRegular: customFontName = Files.allerLightRegular
        case .bold: customFontName = Files.allerBold
        case .custom(let font): customFontName = font
        }
        
        guard let customFont = UIFont(name: customFontName, size: UIFont.labelFontSize) else {
            fatalError("Failed to load \(customFontName) font. Make sure it is included in the Resources/Images folder in the project.")
        }
        return Resource<FontResources>(value: customFont)
    }

}

private extension FontResources {
    enum Files {
        //public typealias FontInfo = (fileName: String, fontName: String)
        
        // Font names are rarely the same as the file name and have a different name as to how they're created
        // https://developer.apple.com/documentation/uikit/text_display_and_fonts/adding_a_custom_font_to_your_app
        static let allerRegular = "Aller_Regular"
        static let allerLightRegular = "Aller_Light_Regular"
        static let allerBold = "Aller_Bold"
    }
}
