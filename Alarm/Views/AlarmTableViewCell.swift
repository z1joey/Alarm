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

    func setCell(alarm: RealTask) {
        let (h, m, _) = Date(timeIntervalSince1970: alarm.timestamp).getHMS()
        timeLabel.text = "\(h) : \(m)"
        titleLabel.text = alarm.title
    }
}
