//
//  TimerTask.swift
//  Alarm
//
//  Created by Joey Zhang on 2022/11/14.
//

import Foundation

class TimerTask: Task {
    private var timer: TaskTimer
    private var target: TimeInterval

    /// Start a countdown timer task
    /// - Parameters:
    ///   - timer: timer with tick event
    ///   - target: target timestamp
    init(timer: TaskTimer, target: TimeInterval) {
        self.timer = timer
        self.target = target
    }

    deinit {
        print("deinit \(String(describing: self))")
    }

    func execute() {
        timer.start()
    }
    
    func terminate() {
        timer.stop()
    }

    func countdown(_ remaining: @escaping (Int) -> Void) {
        let targetTimestap = target

        timer.onTick { _ in
            let diff = targetTimestap - Date().timeIntervalSince1970
            if diff >= 0 {
                remaining(Int(diff))
            }
        }
    }
}
