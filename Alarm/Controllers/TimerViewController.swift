//
//  TimerViewController.swift
//  Alarm
//
//  Created by Joey Zhang on 2022/11/14.
//

import UIKit

class TimerViewController: UIViewController, Logger {
    @IBOutlet private var countDownLabel: UILabel!
    @IBOutlet private var timePicker: UIDatePicker!

    weak var coordinator: AppCoordinator!

    private var task: TimerTask?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        assert(coordinator != nil)
    }

    deinit {
        log("deinit \(String(describing: self))")
        task?.terminate()
    }

    @IBAction private func stopTapped(_ sender: Any) {
        countDownLabel.isHidden = true
        task?.terminate()
        task = nil
    }

    @IBAction private func startTapped(_ sender: UIButton) {
        countDownLabel.text = nil
        countDownLabel.isHidden = false

//        let target = Date().timeIntervalSince1970 + timePicker.countDownDuration
        task = TimerTask(timer: RealTaskTimer(), target: timePicker.countDownDuration)
        task?.execute()
        task?.countdown { [weak self] intervals in
            self?.countDownLabel.text = intervals.text()
        }
    }
}
