//
//  String.swift
//  Common
//
//  Created by Ambuj Punn on 5/29/20.
//  Copyright © 2020 Ambuj Punn. All rights reserved.
//

import Foundation

/// Conforms String to Error type allowing String types to be passed in as Errors
extension String: Error, LocalizedError {
    public var errorDescription: String? { self }
    public var localizedDescription: String { self }
}
