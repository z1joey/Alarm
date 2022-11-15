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
        switch task.type {
        case .alarm:
            requestAlarmNotification(task: task)
        case .countdown:
            requestCountdownNotification(task: task)
        }
    }

    func disableNotification(task: Task) {
        let center = UNUserNotificationCenter.current()

        center.getPendingNotificationRequests { [weak self] (requests) in
            if task.weekDays.isEmpty {
                center.removePendingNotificationRequests(withIdentifiers: [task.id])
                self?.log("removed a local notification without weekdays")
            } else {
                let ids = task.weekDays.map { task.id + "-weekday\($0)" }
                center.removePendingNotificationRequests(withIdentifiers: ids)
                self?.log("removed a local notification with weekdays: \(task.weekDays)")
            }
        }
    }
}

private extension NotificationService {
    func requestCountdownNotification(task: Task) {
        guard task.type == .countdown else {
            log("invalid Task for countdown notification")
            return
        }

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
        log("requested a countdown notification for interval \(intervals)")
        center.add(request)
    }

    func requestAlarmNotification(task: Task) {
        guard task.type == .alarm else {
            log("invalid Task for alarm notification")
            return
        }

        let center = UNUserNotificationCenter.current()

        let content = UNMutableNotificationContent()
        content.title = task.title
        content.subtitle = task.subtitle
        content.sound = UNNotificationSound.default

        let date = Date(timeIntervalSince1970: task.timestamp)
        let (h, m, _) = date.getHMS()
        var components = DateComponents()
        components.hour = h
        components.minute = m
        
        if task.weekDays.isEmpty {
            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
            let request = UNNotificationRequest(identifier: task.id, content: content, trigger: trigger)
            log("requested an alarm notification without weekdays")
            center.add(request)
        } else {
            for day in task.weekDays {
                components.weekday = day
                let id = task.id + "-weekday\(day)"
                let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
                let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)

                log("requested a countdown notification for weekDay: \(day)")
                center.add(request)
            }
        }
    }
}
