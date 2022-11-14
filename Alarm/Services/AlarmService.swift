//
//  AlarmService.swift
//  Alarm
//
//  Created by Joey Zhang on 2022/11/14.
//

import Foundation

class AlarmService: Service {
    let title: String
    let time: (Int, Int) //hh: mm
    private var days: Set<Int> = []

    var id: String {
        return UUID().uuidString
    }

    init(title: String, time: (Int, Int), onDays days: Set<Int>) {
        self.title = title
        self.time = time
        self.days = days
    }

    func execute() {
        print("calendar: \(time)")
    }

    func repetition() -> Set<Int> {
        return days
    }
}
