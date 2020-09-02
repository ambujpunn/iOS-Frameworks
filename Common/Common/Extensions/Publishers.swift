//
//  Publishers.swift
//  Common
//
//  Created by Ambuj Punn on 5/21/20.
//  Copyright © 2020 Ambuj Punn. All rights reserved.
//

import Foundation
import Combine

/// Sink with limitation as per demand
extension Publisher where Self.Failure == Never {
    func sink(_ demand: Int, receivedValue: @escaping Subscribers.ReceivedValue<Self.Output>) -> AnyCancellable {
        let limitedSinkSub = Subscribers.LimitedSink<Self.Output, Never>(demand: demand, receivedValue: receivedValue)
        subscribe(limitedSinkSub)
        return AnyCancellable(limitedSinkSub)
    }
}

extension Publisher {
    func sink(_ demand: Int, receivedCompletion: @escaping Subscribers.ReceivedCompletion<Self.Failure>,
              receivedValue: @escaping Subscribers.ReceivedValue<Self.Output>) -> AnyCancellable {
        let limitedSinkSub = Subscribers.LimitedSink<Self.Output, Self.Failure>(demand: demand, receivedCompletion: receivedCompletion, receivedValue: receivedValue)
        subscribe(limitedSinkSub)
        return AnyCancellable(limitedSinkSub)
    }
}

/// Protocol to allow types to create a publisher for their outputs
/// Keeping it as var to mimic Apple API (ex: Sequence)
public protocol Publishing {
    associatedtype Output
    associatedtype Failure: Error
    
    var publisher: AnyPublisher<Output, Failure> { get }
}

/// Protocol to allow types to customize textual representation in the form of a Publisher that emits String values (similar to CustomStringConvertible)
/// Similar to Publishing protocol but this is specific for publisher returning String val
public protocol CombineStringConvertible {
    associatedtype Failure: Error
    
    var publisher: AnyPublisher<String, Failure> { get }
}

extension PassthroughSubject {
    /// Function to send sequences of Object registered by this PassthroughSubject
    func send<S: Sequence>(_ sequence: S) where S.Element == Output {
        sequence.forEach(send)
    }
}
