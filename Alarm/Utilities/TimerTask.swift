//
//  TimerTask.swift
//  Alarm
//
//  Created by Joey Zhang on 2022/11/14.
//

import Foundation

class TimerTask: Task {
    private let timestamp: Int

    init(timestamp: Int) {
        self.timestamp = timestamp
    }

    func execute() {
        print("timer: \(timestamp)")
    }
    
    func terminate() {
        print("terminate")
    }
}
