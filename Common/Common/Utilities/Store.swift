//
//  Store.swift
//  Common
//
//  Created by Ambuj Punn on 7/7/20.
//  Copyright © 2020 Ambuj Punn. All rights reserved.
//

import Foundation
import Combine

// Note: Keeping inside Common module so that Stores can be created easily from anywhere. This would allow this main file for Store declaration to sit independently
// of different Store modules. All the Store modules will be stored inside a "Stores" group
// Note: Making all functions mutating because we want Stores to be structs so they can be easily passed around rather than references. Change in future if need be
public protocol Store {
    associatedtype Data: SelfIdentifiable
    
    /// cache storing limited amount of data accessible without going to the DB
    var cache: StoreCache<Self> { get }

    /// Saves the data and returns a publisher with a Bool representing if the save happened and if not an error
    mutating func save(_ data: Self.Data) -> AnyPublisher<Bool, Error>
    
    /// Retrieves the data contained by this store or returns an error
    mutating func retreive() -> AnyPublisher<Self.Data, Error>
    
    /// Retrieves the data contained based on id by this store or returns an error
    mutating func retreive(_ id: Identifier<Self.Data>) -> AnyPublisher<Self.Data, Error>
}

// Make changes to this accordingly as design shifts
public struct StoreCache<Storage: Store> {
    public var data: [Storage.Data]
}
