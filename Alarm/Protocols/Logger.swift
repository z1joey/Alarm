//
//  Logger.swift
//  Alarm
//
//  Created by Joey Zhang on 2022/11/15.
//

import UIKit
import Foundation

public protocol Logger {
    func log(_ message: String)
    func log(_ error: Error)
}

extension Logger {
    /// Print a log message with current time
    public func log(_ message: String) {
        print("\(now()) >>> \(message)")
    }

    /// Print an error description with current time
    public func log(_ error: Error) {
        print("\(now()) >>> Error: \(error.localizedDescription)")
    }
}

private func now() -> String {
    let formatter = DateFormatter()
    formatter.timeStyle = .medium
    return formatter.string(from: Date())
}
