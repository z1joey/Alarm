//
//  ServiceScheduler.swift
//  Alarm
//
//  Created by Joey Zhang on 2022/11/14.
//

import Foundation

protocol ServiceScheduler {
    var services: [Service] { get }

    func start()
    func stop()
    func registerService(_ service: Service)
}
