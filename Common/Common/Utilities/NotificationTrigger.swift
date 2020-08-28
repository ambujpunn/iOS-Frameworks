//
//  NotificationTrigger.swift
//  Common
//
//  Created by Ambuj Punn on 7/9/20.
//  Copyright © 2020 Ambuj Punn. All rights reserved.
//

import Foundation

public struct NotificationTriggerInfo {
    public let dateComponents: [DateComponents]
    /// Indicates whether this notification trigger repeats or not
    public let repeats: Bool
    
    public init(dateComponents: [DateComponents], repeats: Bool) {
        self.dateComponents = dateComponents
        self.repeats = repeats
    }
}

public protocol NotificationTriggering {
    var triggerInfo: NotificationTriggerInfo { get }
}
