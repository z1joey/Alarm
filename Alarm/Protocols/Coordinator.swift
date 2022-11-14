//
//  Coordinator.swift
//  Alarm
//
//  Created by Joey Zhang on 2022/11/14.
//

import Foundation

protocol Coordinator {
    var parent: Coordinator? { get set }
    var children: [Coordinator] { get set }

    func start()
}
