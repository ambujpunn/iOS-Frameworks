//
//  Resource.swift
//  UI
//
//  Created by Ambuj Punn on 8/3/20.
//  Copyright © 2020 Ambuj Punn. All rights reserved.
//

import Foundation

/// Allows concrete types to conform to this protocol to be able to have a type safe resource available to be used
public protocol Resourceable {
    associatedtype ResourceType

    var resource: Resource<Self> { get }
}

public struct Resource<T: Resourceable> {
    public var value: T.ResourceType
}

struct ResourceManager<R: Resourceable> {
    
    /// static funciton in the case if resource manager needs to be used quickly and not initialized and stored as a property
    static func value(for resource: R) -> R.ResourceType {
        self.init().value(for: resource)
    }
    
    func value(for resource: R) -> R.ResourceType {
        resource.resource.value
    }
}
