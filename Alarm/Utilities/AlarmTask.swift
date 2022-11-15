//
//  AlarmTask.swift
//  Alarm
//
//  Created by Joey Zhang on 2022/11/14.
//

import Foundation

class AlarmTask: Task {
    private let id: String
    private var days: Set<Int> = []

    let title: String
    let time: (Int, Int) //hh: mm

    init(title: String, time: (Int, Int), onDays days: Set<Int>) {
        self.id = UUID().uuidString
        self.title = title
        self.time = time
        self.days = days
    }

    /// In which day should the service work, if returns empty then do not repeat
    /// - Returns: 1-7: Monday-Sunday
    func repetition() -> Set<Int> {
        return days
    }

    func execute() {
        print("calendar: \(time)")
    }

    func terminate() {
        print("terminate")
    }
}
