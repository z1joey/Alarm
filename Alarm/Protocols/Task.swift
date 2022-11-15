//
//  Task.swift
//  Alarm
//
//  Created by Joey Zhang on 2022/11/14.
//

import Foundation

protocol Task {
    var id: String { get set }
    var type: TaskType { get set }
    var title: String { get set }
    var subtitle: String { get set }
    var timestamp: TimeInterval { get set }
    var isEnabled: Bool { get set }
}

enum TaskType: Codable, Hashable {
    case countdown, alarm
}
