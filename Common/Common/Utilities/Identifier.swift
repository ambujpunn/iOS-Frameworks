//
//  Identifier.swift
//  Meditator
//
//  Created by Ambuj Punn on 6/18/20.
//  Copyright © 2020 Ambuj Punn. All rights reserved.
//

import Foundation

// https://www.swiftbysundell.com/articles/type-safe-identifiers-in-swift/

/*
 if we do this:
 struct ID {
    let id: String
 }
 bad thing about this is that the id is not strongly typed. it can be passed into anything accepting an id or a string value. Ex:
 magazinesWith(id: user1.id) -- this should only be getting magazine ids not any type's id.

 if strongly typed, it would only accept id's of magazine type:
 func magazinesWith(id: ID<Magazine>)

 that would be dope. using strongly typed powers of swift. something like
 struct Magazine: Identifable { // or whatever it will be called
    var id: ID<Magazine> // Automatic benefit of conformance
 }

 The Swift standard Identifiable protocol doesn't allow us to do that as it allows for the id to be of any type not of the conforming type itself as we'd like it
*/

public struct Identifier<Value: SelfIdentifiable> {
    /// rawValue can be of any type the conforming type of SelfIdentifiable would want it to be
    public let rawValue: Value.RawIdentifier
    
    /// Init that allows for the argument name to be omitted
    public init(_ rawValue: Value.RawIdentifier) {
        self.rawValue = rawValue
    }
}

public protocol SelfIdentifiable {
    associatedtype RawIdentifier: Hashable = UUID // Setting default value of this to UUID
    
    /// id is of type Identifier with a strongly typed as the conforming type of SelfIdentifiable
    var id: Identifier<Self> { get }
}

/*
 Example:
 struct User: SelfIdentfiable {
    typealias RawIdentifier = Int // Changing rawValue property of id to be of Int type instead of default UUID
    var id: Identifier<User> // Acquired by conforming to SelfIdentfiable
 }
 */

extension Identifier: Equatable { }

extension Identifier: ExpressibleByIntegerLiteral where Value.RawIdentifier == Int {
    public init(integerLiteral value: Int) {
        rawValue = value
    }
}

extension Identifier: ExpressibleByStringLiteral, ExpressibleByExtendedGraphemeClusterLiteral, ExpressibleByUnicodeScalarLiteral where Value.RawIdentifier == String {
    public typealias ExtendedGraphemeClusterLiteralType = String
    public typealias UnicodeScalarLiteralType = String
    
    public init(stringLiteral value: String) {
        rawValue = value
    }
}
