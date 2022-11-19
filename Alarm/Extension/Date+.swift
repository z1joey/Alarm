//
//  Date+.swift
//  Alarm
//
//  Created by Joey Zhang on 2022/11/15.
//

import Foundation

extension Date {
    /// Get hours, minutes and seconds from a date
    /// - Returns: (hours, minutes, seconds)
    func getHMS() -> (Int, Int, Int) {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: self)
        let minutes = calendar.component(.minute, from: self)
        let seconds = calendar.component(.second, from: self)

        return (hour, minutes, seconds)
    }
}

extension TimeInterval {
    /// Convert second intervals into readable format
    func text(_ style: DateComponentsFormatter.UnitsStyle = .positional) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = style

        return formatter.string(from: TimeInterval(self))!
    }
}

extension Int {
    /// Convert number to weekday name, if it is not valid weekday number, then return "Once"
    func weekdayName() -> String {
        switch self {
        case 1: return "Monday"
        case 2: return "Tuesday"
        case 3: return "Wednesday"
        case 4: return "Thursday"
        case 5: return "Friday"
        case 6: return "Saturday"
        case 7: return "Sunday"
        default:
            return "Once"
        }
    }
}
