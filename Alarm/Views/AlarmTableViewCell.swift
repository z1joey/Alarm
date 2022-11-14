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
    @IBOutlet private var alarmSwitch: UISwitch!

    func setCell(alarm: AlarmService) {
        titleLabel.text = alarm.title
        timeLabel.text = "\(alarm.time.0) : \(alarm.time.1)"
    }
}
