//
//  ServiceTimer.swift
//  Alarm
//
//  Created by Joey Zhang on 2022/11/14.
//

import Foundation

protocol ServiceTimer {
    func start()
    func stop()
    func onTick(action: @escaping (Int) -> ())
}
