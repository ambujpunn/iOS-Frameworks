//
//  UserNotificationContent.swift
//  Common
//
//  Created by Ambuj Punn on 7/9/20.
//  Copyright © 2020 Ambuj Punn. All rights reserved.
//

import Foundation
import UserNotifications

/// Protocol that provides the content for a notification
public protocol UserNotificationContent {
    var notificationContent: UNMutableNotificationContent { get }
}

/// Protocol that provides the textual display for a notification
public protocol UserNotificationDisplay {
    var notificationDisplay: String { get }
}
