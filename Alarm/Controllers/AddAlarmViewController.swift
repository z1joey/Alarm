//
//  AddAlarmViewController.swift
//  Alarm
//
//  Created by Joey Zhang on 2022/11/14.
//

import UIKit

class AddAlarmViewController: UIViewController {
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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    deinit {
        print("deinit \(String(describing: self))")
    }

    @IBAction private func repetitionTapped(_ sender: UIButton) {
        coordinator.showRepetitionVC { [weak self] days in
            let joinedString = Array(days)
                .sorted()
                .compactMap{ day in
                    switch day {
                    case 1: return "Monday"
                    case 2: return "Tuesday"
                    case 3: return "Wednesday"
                    case 4: return "Thursday"
                    case 5: return "Friday"
                    case 6: return "Saturday"
                    case 7: return "Sunday"
                    default:
                        return nil
                    }
                }
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

        scheduler.dispatch(
            AlarmTask(
                title: title,
                time: timePicker.date.getTime(),
                onDays: days
            )
        )
        coordinator.pop()
    }
}
