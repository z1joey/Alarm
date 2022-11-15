//
//  AlarmTaskScheduler.swift
//  Alarm
//
//  Created by Joey Zhang on 2022/11/14.
//

import Foundation

class AlarmTaskScheduler: TaskScheduler {
    private var _tasks: [Task] = []

    var tasks: [Task] {
        return _tasks
    }

    func dispatch(_ task: Task) {
        NSLock().lock()
        _tasks.append(task)
        NSLock().unlock()
    }

    func terminate(_ task: Task) {
        NSLock().lock()
        _tasks.append(task)
        NSLock().unlock()
    }    
}
