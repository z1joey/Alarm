//
//  AlarmTask.swift
//  Alarm
//
//  Created by Joey Zhang on 2022/11/14.
//

import Foundation

class AlarmTask: Task, NotificationEnabled, Logger {
    var id: String
    var title: String
    var subtitle: String
    var intervals: TimeInterval
    var isEnabled: Bool

    private var days: Set<Int> = []

    let time: (Int, Int, Int) //hh: mm: ss

    init(title: String, date: Date, onDays days: Set<Int>) {
        self.id = UUID().uuidString
        self.title = title
        self.subtitle = "Alarm"
        self.intervals = date.timeIntervalSince1970 - Date().timeIntervalSince1970
        self.days = days
        self.time = date.getTime()
        self.isEnabled = false
    }

    deinit {
        log("deinit \(String(describing: self))")
    }

    /// In which day should the service work, if returns empty then do not repeat
    /// - Returns: 1-7: Monday-Sunday
    func repetition() -> Set<Int> {
        return days
    }

    func execute() {
        enableNotification()
        isEnabled = true
        log("An alarm is enabled with intervals: \(intervals)s")
    }

    func terminate() {
        disableNotification()
        isEnabled = false
        log("An alarm with id(\(id)) is disabled")
    }
}
