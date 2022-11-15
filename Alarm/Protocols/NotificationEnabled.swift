//
//  NotificationEnabled.swift
//  Alarm
//
//  Created by Joey Zhang on 2022/11/15.
//

import Foundation
import UserNotifications

protocol NotificationEnabled {
    var id: String { get set }
    var title: String { get set }
    var subtitle: String { get set }
    var intervals: TimeInterval { get set }
    var isEnabled: Bool { get set }

    func enableNotification()
    func disableNotification()
}

extension NotificationEnabled {
    func enableNotification() {
        guard intervals > 0 else { return }

        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: intervals, repeats: false)
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)

        let center = UNUserNotificationCenter.current()
        center.add(request)
    }

    func disableNotification() {
        let center = UNUserNotificationCenter.current()

        center.getPendingNotificationRequests { (requests) in
          for request in requests {
            if request.identifier == id {
              center.removePendingNotificationRequests(withIdentifiers: [id])
            }
          }
        }
    }
}
