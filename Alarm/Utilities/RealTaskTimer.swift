//
//  RealTaskTimer.swift
//  Alarm
//
//  Created by Joey Zhang on 2022/11/15.
//

import Foundation

class RealTaskTimer: TaskTimer, Logger {
    private var timer: Timer?
    private var tick: Int
    private var tickAction: ((Int) -> ())?

    init() {
        self.timer = nil
        self.tick = 0
        self.tickAction = nil
    }

    deinit {
        log("deinit \(String(describing: self))")
    }

    func start() {
        timer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(timerDidFire(_:)),
            userInfo: nil,
            repeats: true
        )
    }

    func stop() {
        timer?.invalidate()
        timer = nil
        tick = 0
    }

    func pause() {
        timer?.invalidate()
    }

    func onTick(action: @escaping (Int) -> ()) {
        tickAction = action
    }

    @objc private func timerDidFire(_ timer: Timer) {
        tick += 1
        tickAction?(tick)
    }
}
