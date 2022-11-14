//
//  Date+.swift
//  Alarm
//
//  Created by Joey Zhang on 2022/11/15.
//

import Foundation

extension Date {
    /// Get hours and minutes from a date
    /// - Returns: (Hours: Minutes)
    func getTime() -> (Int, Int) {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: self)
        let minutes = calendar.component(.minute, from: self)

        return (hour, minutes)
    }
}
