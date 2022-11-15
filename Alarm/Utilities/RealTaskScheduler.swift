//
//  RealTaskScheduler.swift
//  Alarm
//
//  Created by Joey Zhang on 2022/11/14.
//

import Foundation

class RealTaskScheduler: TaskScheduler {
    private var _task: [Task] = []

    var tasks: [Task] {
        return _task
    }

    func start() {
        for task in tasks {
            task.execute()
        }
    }

    func stop() {
        for task in tasks {
            task.terminate()
        }
    }

    func dispatch(_ task: Task) {
        NSLock().lock()
        _task.append(task)
        NSLock().unlock()
    }
}
