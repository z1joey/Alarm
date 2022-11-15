//
//  RealTask.swift
//  Alarm
//
//  Created by Joey Zhang on 2022/11/14.
//

import Foundation

struct RealTask: Task, Codable, Hashable {
    var id: String
    var type: TaskType
    var title: String
    var subtitle: String
    var timestamp: TimeInterval
    var isEnabled: Bool
    var days: Set<Int> = []

    init(_ type: TaskType, title: String, subtitle: String, date: Date, onDays days: Set<Int> = []) {
        self.id = UUID().uuidString
        self.type = type
        self.title = title
        self.subtitle = subtitle
        self.timestamp = date.timeIntervalSince1970
        self.days = days
        self.isEnabled = false
    }
}
