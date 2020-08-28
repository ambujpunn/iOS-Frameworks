//
//  LimitedSinkSubscriberTests.swift
//  MeditatorTests
//
//  Created by Ambuj Punn on 5/29/20.
//  Copyright © 2020 Ambuj Punn. All rights reserved.
//

import XCTest
import Combine
@testable import Common

class LimitedSinkSubscriberTests: XCTestCase {
    
    private var publisher: PassthroughSubject<Int, Error>!
    private var cancellables: Set<AnyCancellable>!
    private let valuesToPublish = [1,3,1,51,25,6,43,3,6,32,6]

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        publisher = PassthroughSubject<Int, Error>()
        cancellables = Set<AnyCancellable>()
    }
    
    func testReceivedOnlyLimitedValues() throws {
        var numOfReceivedElements = 0
        publisher
            .sink(2, receivedCompletion: { _ in
            }) { val in
                numOfReceivedElements += 1
            }.store(in: &cancellables)
        
        publisher.send(valuesToPublish[0])
        XCTAssertEqual(numOfReceivedElements, 1)
        
        publisher.send(valuesToPublish[1])
        XCTAssertEqual(numOfReceivedElements, 2)
        
        publisher.send(valuesToPublish[2])
        XCTAssertEqual(numOfReceivedElements, 2)
        
        publisher.send(valuesToPublish)
        XCTAssertEqual(numOfReceivedElements, 2)
    }
    
    func testReceivedCorrectNumberOfValues() throws {
        var numOfReceivedElements = 0
        publisher
            .sink(5, receivedCompletion: { _ in
            }) { val in
                numOfReceivedElements += 1
        }.store(in: &cancellables)
        
        publisher.send(valuesToPublish[0..<5])
        XCTAssertEqual(numOfReceivedElements, 5)
    }
    
    func testReceivedCompletionFailure() throws {
        var numOfReceivedElements = 0
        let expectedError: Error = "Failure yo"
        publisher
            .sink(5, receivedCompletion: { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    XCTAssertEqual(error.localizedDescription, expectedError.localizedDescription)
                }
            }) { val in
                numOfReceivedElements += 1
        }.store(in: &cancellables)
        
        publisher.send(valuesToPublish[0..<3])
        XCTAssertEqual(numOfReceivedElements, 3)
        
        publisher.send(completion: .failure(expectedError))
        XCTAssertEqual(numOfReceivedElements, 3)
    }
    
    func testReceivedCompletionFinished() throws {
        var numOfReceivedElements = 0
        publisher
            .sink(5, receivedCompletion: { completion in
                if case .failure(_) = completion {
                    XCTFail("Expected a finished completion")
                }
            }) { val in
                numOfReceivedElements += 1
        }.store(in: &cancellables)
        
        publisher.send(valuesToPublish[0..<3])
        XCTAssertEqual(numOfReceivedElements, 3)
        
        publisher.send(completion: .finished)
        XCTAssertEqual(numOfReceivedElements, 3)
    }
    
    func testReceivedAllValues() throws {
        var numOfReceivedElements = 0
        valuesToPublish
            .publisher
            .sink(20, receivedCompletion: { completion in
                if case .failure(_) = completion {
                    XCTFail("Expected a finished completion")
                }
            }) { val in
                numOfReceivedElements += 1
        }.store(in: &cancellables)

        XCTAssertEqual(numOfReceivedElements, valuesToPublish.count)
    }
}
