//
//  UserNotifications.swift
//  Common
//
//  Created by Ambuj Punn on 6/16/20.
//  Copyright © 2020 Ambuj Punn. All rights reserved.
//

import Foundation
import UserNotifications
import Combine

public extension UNUserNotificationCenter {
    enum Errors: String, LocalizedError, Equatable {
        case requestAdding
        case requestAuthorization
    }

    /// Wraps requestAuthorization inside Publisher
    func requestAuthorization(options: UNAuthorizationOptions) -> AnyPublisher<Bool, UNUserNotificationCenter.Errors> {
        return Future { promise in
            self.requestAuthorization(options: options) { granted, error in
                if let _ = error { promise(.failure(.requestAuthorization)) }
                else { promise(.success(granted)) }
            }
        }.eraseToAnyPublisher()
    }
    
    /// Wraps add(_ request:) inside Publisher
    func add(_ request: UNNotificationRequest) -> AnyPublisher<Void, UNUserNotificationCenter.Errors> {
        return Future { promise in
            self.add(request) { error in
                if let _ = error { promise(.failure(.requestAdding)) }
            }
        }.eraseToAnyPublisher()
    }
}

public extension UNNotificationRequest {
    convenience init(uuid: UUID, content: UNNotificationContent, trigger: UNNotificationTrigger) {
        self.init(identifier: uuid.uuidString, content: content, trigger: trigger)
    }
}
