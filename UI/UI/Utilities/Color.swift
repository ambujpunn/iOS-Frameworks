//
//  Color.swift
//  UI
//
//  Created by Ambuj Punn on 7/15/20.
//  Copyright © 2020 Ambuj Punn. All rights reserved.
//

import Foundation
import UIKit

// https://stackoverflow.com/questions/24263007/how-to-use-hex-color-values?page=1&tab=votes#tab-top
public extension UIColor {
    /// Initializes UIColor taking in all colors
    convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    /// Initializes UIColor taking in RGB as hex
    convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
    }
}

public extension UIColor {
    enum Background {
        public static let primary = UIColor(rgb: 0xF2CBBD)
        public static let secondary = UIColor(rgb: 0x7657D5)
    }
    
    enum Text {
        public static let primary = UIColor(rgb: 0x2D3740)
        public static let secondary = UIColor.white
    }
}
