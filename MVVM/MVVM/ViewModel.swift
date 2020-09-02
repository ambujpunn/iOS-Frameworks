//
//  ViewModel.swift
//  MVVM
//
//  Created by Ambuj Punn on 7/15/20.
//  Copyright © 2020 Ambuj Punn. All rights reserved.
//

import Foundation
import Common
import Combine

public protocol ViewModel {
    associatedtype StoreType: Store

    /// Allows ability to save and retrieve data
    var store: StoreType { get }
    
    /// Fetches all changes to the view model itself
    func fetch() -> AnyPublisher<StoreType.Data, Error>
    
    // View Model should not give any verification if the save was successful or not, the error handling should capture that within the store..hmmm
    // Revisit
    func save()
}
