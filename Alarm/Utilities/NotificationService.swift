//
//  NotificationService.swift
//  Alarm
//
//  Created by Joey Zhang on 2022/11/14.
//

import UIKit
import Foundation
import UserNotifications

final class NotificationService {
    static let shared = NotificationService()

    private init() {}

    func request() {
        let content = UNMutableNotificationContent()
        content.title = "Feed the cat"
        content.subtitle = "It looks hungry"
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        let center = UNUserNotificationCenter.current()
        center.add(request)
    }

    func remove() {
        UNUserNotificationCenter.current().getPendingNotificationRequests { (requests) in
          for request in requests {
            if request.identifier == "identifier" {
              UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["identifier"])
            }
          }
        }
    }
}
