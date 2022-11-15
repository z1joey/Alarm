//
//  RealTask.swift
//  Alarm
//
//  Created by Joey Zhang on 2022/11/14.
//

import Foundation

struct RealTask: Task, Codable {
    var id: String
    var type: TaskType
    var title: String
    var subtitle: String
    var timestamp: TimeInterval
    var isEnabled: Bool
    var weekDays: Set<Int> = []

    init(_ type: TaskType, title: String, subtitle: String, date: Date, weekDays days: Set<Int> = [], isEnabled: Bool = true) {
        self.id = UUID().uuidString
        self.type = type
        self.title = title
        self.subtitle = subtitle
        self.timestamp = date.timeIntervalSince1970
        self.weekDays = days
        self.isEnabled = isEnabled
    }
}

extension RealTask: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func ==(lhs: RealTask, rhs: RealTask) -> Bool {
        return lhs.id == rhs.id
    }
}
