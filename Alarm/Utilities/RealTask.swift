//
//  RealTask.swift
//  Alarm
//
//  Created by Joey Zhang on 2022/11/14.
//

import Foundation

struct RealTask: Task, Codable {
    var id: String
    var title: String
    var subtitle: String
    var timestamp: TimeInterval
    var isEnabled: Bool
    var days: Set<Int> = []

    init(title: String, date: Date, onDays days: Set<Int> = []) {
        self.id = UUID().uuidString
        self.title = title
        self.subtitle = "Alarm"
        self.timestamp = date.timeIntervalSince1970
        self.days = days
        self.isEnabled = false
    }
}
