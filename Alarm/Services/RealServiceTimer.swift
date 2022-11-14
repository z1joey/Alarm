//
//  RealServiceTimer.swift
//  Alarm
//
//  Created by Joey Zhang on 2022/11/14.
//

import Foundation

class RealServiceTimer: ServiceTimer {
    private var timer: Timer?
    private var tick: Int
    private var tickAction: ((Int) -> ())?

    init() {
        self.timer = nil
        self.tick = 0
        self.tickAction = nil
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

    func onTick(action: @escaping (Int) -> ()) {
        tickAction = action
    }

    @objc private func timerDidFire(_ timer: Timer) {
        tick += 1
        tickAction?(tick)
    }
}
