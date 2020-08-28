//
//  Sequences.swift
//  Meditator
//
//  Created by Ambuj Punn on 5/29/20.
//  Copyright © 2020 Ambuj Punn. All rights reserved.
//

import Foundation

public extension Sequence where Self.Element: Hashable {
    /// Checks if the sequence has all the elements of the inputted sequence disregarding order
    func containsAll<S: Sequence>(_ elements: S) -> Bool where S.Element: Hashable, S.Element == Self.Element {
        // Using set algebra
        self == Set<S.Element>(elements)
    }
    
    /// Compare a sequence which has Elements that conform to Hashable with a Set of the same element type. Checks for whether the sequence and the set have equal elements (using Set's == function)
    static func ==(lhs: Self, rhs: Set<Self.Element>) -> Bool {
        // Convert Self to Set to allow usage of set algebra (==)
        Set(lhs) == rhs
    }
    
    /// Creates a set out of a sequence that has an element that conforms to Hashable
    var set: Set<Self.Element> { Set(self) }
}

public extension Set {
    /// Applies a set union
    static func + <S>(lhs: Set<Element>, rhs: S) -> Set<Element> where S: Sequence, S.Element == Element {
        lhs.union(rhs)
    }
    
    /// Applies a set subtracting rhs from lhs
    static func - <S>(lhs: Set<Element>, rhs: S) -> Set<Element> where S: Sequence, S.Element == Element {
        lhs.subtracting(rhs)
    }
}

extension Set: CustomRHSArithmetic {
    /// Applies a set union with another element of the current set's type
    public static func + (lhs: Set<Element>, rhs: Element) -> Set<Element> {
        lhs.union([rhs])
    }
    
    /// Applies a set subtracting with another element of the current set's type
    public static func - (lhs: Set<Element>, rhs: Element) -> Set<Element> {
        lhs.subtracting([rhs])
    }
    
    public typealias Rhs = Element
}

public extension Set {
    /// Creates an array out of a set 
    var array: Array<Self.Element> { Array(self) }
}

public extension Array {
    /// Creates an array containing the elements  created by the element closure repeated `count` amount of times
    init(count: Int, element: @escaping () -> (Element)) {
        self.init(count.loop(element).sequence)
    }
}
