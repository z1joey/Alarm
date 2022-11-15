//
//  RealTaskScheduler.swift
//  Alarm
//
//  Created by Joey Zhang on 2022/11/14.
//

import Foundation

class RealTaskScheduler: TaskScheduler, Logger {
    private var _tasks: Set<RealTask>
    private var notificationService: NotificationService
    private var userDefaultService: UserDefaultService<RealTask>

    init(tasks: Set<RealTask>, notificationService: NotificationService, userDefaultService: UserDefaultService<RealTask>) {
        self._tasks = tasks
        self.notificationService = notificationService
        self.userDefaultService = userDefaultService
    }

    var tasks: [Task] {
        return Array(_tasks)
    }

    func execute(_ task: Task) {
        addTask(task)
        notificationService.enableNotification(task: task)
        log("executed: \(task)")
    }

    func terminate(_ task: Task) {
        removeTask(task)
        notificationService.disableNotification(task: task)
        log("terminated: \(task)")
    }
}

private extension RealTaskScheduler {
    func addTask(_ task: Task) {
        if let task = task as? RealTask {
            NSLock().lock()
            _tasks.insert(task)
            userDefaultService.add(item: task, forKey: "tasks")
            NSLock().unlock()
        }
    }

    func removeTask(_ task: Task) {
        if let task = task as? RealTask {
            NSLock().lock()
            _tasks.remove(task)
            userDefaultService.remove(item: task, forKey: "tasks")
            NSLock().unlock()
        }
    }
}
