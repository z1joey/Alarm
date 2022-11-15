//
//  TimerTask.swift
//  Alarm
//
//  Created by Joey Zhang on 2022/11/14.
//

import Foundation

class TimerTask: Task, NotificationEnabled, Logger {
    var id: String
    var title: String
    var subtitle: String
    var intervals: TimeInterval
    var isEnabled: Bool

    private var timer: TaskTimer

    /// Start a countdown timer task
    /// - Parameters:
    ///   - timer: timer with tick event
    ///   - target: target timestamp
    init(timer: TaskTimer, target: TimeInterval) {
        self.id = UUID().uuidString
        self.title = "Alarm"
        self.subtitle = "Countdown"
        self.timer = timer
        self.intervals = target
        self.isEnabled = false
    }

    deinit {
        log("deinit \(String(describing: self))")
    }

    func execute() {
        timer.start()
        enableNotification()
        isEnabled = true
        log("A timer is enabled with intervals: \(intervals)s")
    }
    
    func terminate() {
        timer.stop()
        disableNotification()
        isEnabled = false
        log("A timer with id(\(id)) is disabled")
    }

    func countdown(_ remaining: @escaping (Int) -> Void) {
        var target = intervals

        timer.onTick { _ in
            target -= 1
            if target >= 0 {
                remaining(Int(target))
            }
        }
    }
}
