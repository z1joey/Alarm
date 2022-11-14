//
//  TimerService.swift
//  Alarm
//
//  Created by Joey Zhang on 2022/11/14.
//

import Foundation

class TimerService: Service {
    func repetition() -> [Int] {
        return []
    }
    
    private let timestamp: Int

    var id: String {
        return UUID().uuidString
    }

    init(timestamp: Int) {
        self.timestamp = timestamp
    }

    func execute() {
        print("timer: \(timestamp)")
    }
}
