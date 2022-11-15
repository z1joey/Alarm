//
//  AlarmTableViewCell.swift
//  Alarm
//
//  Created by Joey Zhang on 2022/11/14.
//

import UIKit

class AlarmTableViewCell: UITableViewCell {
    @IBOutlet private var timeLabel: UILabel!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var weekdayLabel: UILabel!
    @IBOutlet private var alarmSwitch: UISwitch!

    var switchToogled: ((Bool) -> Void)?

    func setCell(alarm: RealTask) {
        let (h, m, _) = Date(timeIntervalSince1970: alarm.timestamp).getHMS()
        let weekdays = alarm.weekDays.isEmpty ? "Once" : Array(alarm.weekDays)
            .sorted()
            .map { $0.weekdayName() }
            .joined(separator: " ")

        timeLabel.text = "\(h) : \(m)"
        titleLabel.text = alarm.title
        weekdayLabel.text = weekdays
        alarmSwitch.isOn = alarm.isEnabled
    }

    @IBAction private func switchToogled(_ sender: UISwitch) {
        switchToogled?(sender.isOn)
    }
}
