//
//  RealTaskScheduler.swift
//  Alarm
//
//  Created by Joey Zhang on 2022/11/14.
//

import Foundation

class RealTaskScheduler: TaskScheduler, Logger {
    private var _tasks: [Task]
    private var notificationService: NotificationService

    init(notificationService: NotificationService) {
        self._tasks = []
        self.notificationService = notificationService
    }

    var tasks: [Task] {
        return _tasks
    }

    func execute(_ task: Task) {
        NSLock().lock()
        _tasks.append(task)
        notificationService.enableNotification(task: task)
        log("\(task) executed")
        NSLock().unlock()
    }

    func terminate(_ task: Task) {
        NSLock().lock()
        _tasks.append(task)
        notificationService.disableNotification(task: task)
        log("\(task) terminated")
        NSLock().unlock()
    }    
}
