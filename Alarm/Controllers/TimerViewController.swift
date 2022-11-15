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
    var scheduler: TaskScheduler!
    var timer: TaskTimer!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        assert(scheduler != nil && coordinator != nil)
    }

    deinit {
        log("deinit \(String(describing: self))")
        timer.stop()
    }

    @IBAction private func stopTapped(_ sender: Any) {
        countDownLabel.text = nil
        countDownLabel.isHidden = true
        timer.stop()
    }

    @IBAction private func startTapped(_ sender: UIButton) {
        executeTask()
        countingDown()
    }
}

private extension TimerViewController {
    func executeTask() {
        let timestamp = Date().timeIntervalSince1970 + timePicker.countDownDuration
        let date = Date(timeIntervalSince1970: timestamp)
        let task = RealTask(title: "Countdown", date: date)
        scheduler.execute(task)
    }

    func countingDown() {
        var target = timePicker.countDownDuration

        countDownLabel.text = target.text()
        countDownLabel.isHidden = false

        timer?.start()
        timer?.onTick(action: { [weak self] _ in
            if target > 0 {
                target -= 1
                self?.countDownLabel.text = target.text()
            }
        })
    }
}
