//
//  DataControllerInjectable.swift
//  MVVM
//
//  Created by Ambuj Punn on 7/15/20.
//  Copyright © 2020 Ambuj Punn. All rights reserved.
//

import Foundation
import UIKit
import Common

public protocol DataControllerInjectable {
    /// Passes data controller
    func set<T: DataController>(dataController: T)
}

extension DataControllerInjectable where Self: UIViewController {
    public func set<T: DataController>(dataController: T) { }
}

extension UIViewController: DataControllerInjectable {}

/// Adapter that allows the type of view controller to be initialized and retreivable with its data controller set
public struct DataControllerInjectorAdapter<T: UIViewController> {
    public var viewController: T
    
    public init<U: DataController>(dataController: U) {
        viewController = T()
        viewController.set(dataController: dataController)
    }
}
