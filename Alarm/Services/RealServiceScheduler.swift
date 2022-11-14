//
//  RealServiceScheduler.swift
//  Alarm
//
//  Created by Joey Zhang on 2022/11/14.
//

import Foundation

class RealServiceScheduler: ServiceScheduler {
    private let timer: ServiceTimer
    private var _services: [Service]

    var services: [Service] {
        return _services
    }

    init(timer: ServiceTimer) {
        self.timer = timer
        self._services = []
    }

    func start() {
        timer.onTick { tick in
            self.timerDidTick(tick)
        }

        timer.start()
    }

    func stop() {
        timer.stop()
    }
    
    func registerService(_ service: Service) {
        NSLock().lock()
        _services.append(service)
        NSLock().unlock()
    }
}

private extension RealServiceScheduler {
    func timerDidTick(_ tick: Int) {
        runServicesWithTick(tick)
    }
    
    func runServicesWithTick(_ tick: Int) {
        for service in services {
            service.execute()
        }
    }
}
