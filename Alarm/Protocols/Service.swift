//
//  Service.swift
//  Alarm
//
//  Created by Joey Zhang on 2022/11/14.
//

import Foundation

protocol Service {
    var id: String { get }

    func execute()

    /// How often should the service be executed
    /// - Returns: seconds
    func frequency() -> Int

    /// In which day should the service work
    /// - Returns: 1-7: Monday-Sunday
    func repetition() -> [Int]
}

extension Service {
    func frequency() -> Int {
        return 1
    }
}
