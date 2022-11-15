//
//  Date+.swift
//  Alarm
//
//  Created by Joey Zhang on 2022/11/15.
//

import Foundation

extension Date {
    /// Get hours and minutes from a date
    /// - Returns: (Hours: Minutes: Seconds)
    func getTime() -> (Int, Int, Int) {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: self)
        let minutes = calendar.component(.minute, from: self)
        let seconds = calendar.component(.second, from: self)

        return (hour, minutes, seconds)
    }
}

extension Int {
    /// Convert second intervals into readable format
    func text(_ style: DateComponentsFormatter.UnitsStyle = .positional) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = style

        return formatter.string(from: TimeInterval(self))!
    }
}
