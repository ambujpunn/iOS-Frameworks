//
//  DataController.swift
//  Common
//
//  Created by Ambuj Punn on 7/7/20.
//  Copyright © 2020 Ambuj Punn. All rights reserved.
//

import Foundation

/// Performs some type of work and has data of some output type
public protocol Provider {
    associatedtype Output
    
    var data: Output { get }
}

/// Gives ability to use the a given provider to provide some service or save/retrieve data from the store
public protocol DataController {
    associatedtype StoreType: Store
    associatedtype ProviderType: Provider
    
    /// Allows ability to save and retrieve data
    var store: StoreType { get }
    
    /// Allows ability to provide some sort of service that provides data
    var provider: ProviderType { get }
}
