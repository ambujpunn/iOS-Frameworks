//
//  Math.swift
//  Common
//
//  Created by Ambuj Punn on 6/11/20.
//  Copyright © 2020 Ambuj Punn. All rights reserved.
//

import Foundation
import Combine

//TODO: Keep digging into making this var for all numbers (if possible)
public extension Int {
    var time: TimeInterval { TimeInterval(self) }
}

public extension Int {
    /// Returns a Sequence Publisher looping from 0 to the int value simulating a for loop for an array
    func loop() -> Publishers.Sequence<[Int], Never> {
        [Int](0..<self).publisher
    }
    
    /// Returns a Sequence Publisher of type T by executing the creation closure looping from 0 to the int value
    func loop<T>(_ creation: @escaping () -> (T)) -> Publishers.Sequence<[T], Never> {
        loop().map { _ in creation() }
    }
}

/// Protocol to allow custom right hand side type for arithmetic purposes
public protocol CustomRHSArithmetic {
    associatedtype Rhs
    
    static func - (lhs: Self, rhs: Rhs) -> Self
    static func + (lhs: Self, rhs: Rhs) -> Self
}
