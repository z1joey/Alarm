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

    func setCell(task: Task) {
        let (h, m, _) = Date(timeIntervalSince1970: task.timestamp).getHMS()
        let weekdays = task.weekDays.isEmpty ? "Once" : Array(task.weekDays)
            .sorted()
            .map { $0.weekdayName() }
            .joined(separator: " ")

        timeLabel.text = "\(h) : \(m)"
        titleLabel.text = task.title
        weekdayLabel.text = weekdays
        alarmSwitch.isOn = task.isEnabled
    }

    @IBAction private func switchToogled(_ sender: UISwitch) {
        switchToogled?(sender.isOn)
    }
}
