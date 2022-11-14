//
//  AddAlarmViewController.swift
//  Alarm
//
//  Created by Joey Zhang on 2022/11/14.
//

import UIKit

class AddAlarmViewController: UIViewController {
    @IBOutlet private var timePicker: UIDatePicker!
    @IBOutlet private var titleTextField: UITextField!

    weak var coordinator : AlarmCoordinator!
    var scheduler: ServiceScheduler!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        assert(scheduler != nil && coordinator != nil)
    }

    @IBAction private func repetitionTapped(_ sender: UIButton) {
        coordinator.showRepetitionVC()
    }

    @IBAction private func cancelTapped(_ sender: UIBarButtonItem) {
        coordinator.pop()
    }

    @IBAction private func saveTapped(_ sender: UIBarButtonItem) {
        scheduler.registerService(
            AlarmService(
                title: titleTextField.text ?? "Alarm",
                time: (10, 10),
                onDays: []
            )
        )
        coordinator.pop()
    }
}
