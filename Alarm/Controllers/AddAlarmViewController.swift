//
//  AddAlarmViewController.swift
//  Alarm
//
//  Created by Joey Zhang on 2022/11/14.
//

import UIKit

class AddAlarmViewController: UIViewController, Logger {
    @IBOutlet private var daysLabel: UILabel!
    @IBOutlet private var timePicker: UIDatePicker!
    @IBOutlet private var titleTextField: UITextField!

    private var days: Set<Int> = []

    weak var coordinator : AppCoordinator!
    var scheduler: TaskScheduler!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        assert(scheduler != nil && coordinator != nil)
        timePicker.date = Calendar.current.date(byAdding: .minute, value: 5, to: Date()) ?? Date()
    }

    deinit {
        log("deinit \(String(describing: self))")
    }

    @IBAction private func repetitionTapped(_ sender: UIButton) {
        coordinator.showRepetitionVC { [weak self] days in
            let joinedString = Array(days)
                .sorted()
                .map { $0.weekdayName() }
                .joined(separator: " ")

            self?.days = days
            self?.daysLabel.text = days.isEmpty ? "Once" : joinedString
        }
    }

    @IBAction private func cancelTapped(_ sender: UIBarButtonItem) {
        coordinator.pop()
    }

    @IBAction private func saveTapped(_ sender: UIBarButtonItem) {
        let title = (titleTextField.text == nil || titleTextField.text == "") ? "Alarm" : titleTextField.text!
        let (h, m, s) = timePicker.date.getHMS()
        let date = Date(timeIntervalSince1970: timePicker.date.timeIntervalSince1970 - Double(s))

        let task = RealTask(.alarm, title: title, subtitle: "\(h):\(m)", date: date, weekDays: days)

        scheduler.execute(task)
        coordinator.pop()
    }
}
