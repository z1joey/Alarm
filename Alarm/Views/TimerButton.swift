//
//  TimerButton.swift
//  Alarm
//
//  Created by Joey Zhang on 2022/11/16.
//

import UIKit

class TimerButton: UIButton {
    override var isSelected: Bool {
        willSet {
            if newValue {
                backgroundColor = .yellow
            } else {
                backgroundColor = .systemMint
            }
        }
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setTitle("Pause", for: .selected)
        setTitle("Start", for: .normal)
    }
}
