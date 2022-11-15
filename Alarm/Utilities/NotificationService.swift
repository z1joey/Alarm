//
//  NotificationService.swift
//  Alarm
//
//  Created by Joey Zhang on 2022/11/15.
//

import Foundation
import UserNotifications

class NotificationService: Logger {
    func enableNotification(task: Task) {
        guard task.timestamp > Date().timeIntervalSince1970 else {
            log("invalid timestamp")
            return
        }

        let intervals = task.timestamp - Date().timeIntervalSince1970
        let content = UNMutableNotificationContent()
        content.title = task.title
        content.subtitle = task.subtitle
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: intervals, repeats: false)
        let request = UNNotificationRequest(identifier: task.id, content: content, trigger: trigger)

        let center = UNUserNotificationCenter.current()
        center.add(request)
    }

    func disableNotification(task: Task) {
        let center = UNUserNotificationCenter.current()

        center.getPendingNotificationRequests { (requests) in
          for request in requests {
              if request.identifier == task.id {
              center.removePendingNotificationRequests(withIdentifiers: [task.id])
            }
          }
        }
    }
}
