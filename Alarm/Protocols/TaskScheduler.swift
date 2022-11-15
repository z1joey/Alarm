//
//  TaskScheduler.swift
//  Alarm
//
//  Created by Joey Zhang on 2022/11/14.
//

import Foundation

protocol TaskScheduler {
    var tasks: [Task] { get }

    func start()
    func stop()
    func dispatch(_ task: Task)
}
