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
    private var task: Task?

    weak var coordinator: AppCoordinator!
    var scheduler: TaskScheduler!
    var timer: TaskTimer!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        assert(scheduler != nil && coordinator != nil)

        if let task = scheduler.tasks.filter({ $0.type == .countdown }).first {
            self.task = task
            if task.timestamp > Date().timeIntervalSince1970 {
                scheduler.execute(task)
                countingDown(target: task.timestamp - Date().timeIntervalSince1970)
            } else {
                scheduler.terminate(task)
            }
        }
    }

    deinit {
        log("deinit \(String(describing: self))")
        timer.stop()
    }

    @IBAction private func stopTapped(_ sender: Any) {
        resetUI()
        timer.stop()
        if let task = task {
            scheduler.terminate(task)
        }
    }

    @IBAction private func startTapped(_ sender: UIButton) {
        let timestamp = Date().timeIntervalSince1970 + timePicker.countDownDuration
        let date = Date(timeIntervalSince1970: timestamp)
        let task = RealTask(.countdown, title: "Timer", subtitle: "Countdown", date: date)
        self.task = task
        scheduler.execute(task)
        countingDown(target: timePicker.countDownDuration)
    }

    private func countingDown(target: TimeInterval) {
        var target = target

        countDownLabel.text = target.text()
        countDownLabel.isHidden = false

        timer?.start()
        timer?.onTick(action: { [weak self] _ in
            if target > 0 {
                target -= 1
                self?.countDownLabel.text = target.text()
            } else if let task = self?.task {
                self?.resetUI()
                self?.timer.stop()
                self?.scheduler.terminate(task)
            }
        })
    }

    private func resetUI() {
        countDownLabel.text = nil
        countDownLabel.isHidden = true
    }
}
