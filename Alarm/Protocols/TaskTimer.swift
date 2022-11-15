//
//  TaskTimer.swift
//  Alarm
//
//  Created by Joey Zhang on 2022/11/15.
//

import Foundation

protocol TaskTimer {
    func start()
    func stop()
    func pause()
    func onTick(action: @escaping (Int) -> ())
}
