//
//  Notifications.swift
//  Meditator
//
//  Created by Ambuj Punn on 6/16/20.
//  Copyright © 2020 Ambuj Punn. All rights reserved.
//

import Foundation
import Combine
import UserNotifications

/// Protocol that provides functionality for Notifications
public protocol Notifiable {
    /// Request notification authorization from the user (provisional if need be)
    func requestAuthorization(provisional: Bool?) -> AnyPublisher<Bool, UNUserNotificationCenter.Errors>
}

public struct NotificationService: Notifiable {
    
    public func requestAuthorization(provisional: Bool?) -> AnyPublisher<Bool, UNUserNotificationCenter.Errors> {
        var notificationOptions: UNAuthorizationOptions = [.alert, .sound, .badge]
        if let provisional = provisional, provisional {
            notificationOptions.insert(.provisional)
        }
        return UNUserNotificationCenter.current()
            .requestAuthorization(options: notificationOptions)
    }
}

