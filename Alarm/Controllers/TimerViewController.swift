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
    @IBOutlet private var startButton: TimerButton!

    private var task: Task?
    private var remainingIntervals: TimeInterval = 0

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
                startButton.isSelected = true
                scheduler.execute(task)
                remainingIntervals = task.timestamp - Date().timeIntervalSince1970
                countingDown()
            } else {
                scheduler.terminate(task)
                timer.stop()
                resetUI()
            }
        }
    }

    deinit {
        log("deinit \(String(describing: self))")
        timer.stop()
        task = nil
    }

    @IBAction private func stopTapped(_ sender: UIButton) {
        resetUI()
        timer.stop()
        remainingIntervals = 0
        if let task = task {
            scheduler.terminate(task)
        }
    }

    @IBAction private func startTapped(_ sender: UIButton) {
        if sender.isSelected && task != nil {
            timer.stop()
            scheduler.terminate(task!)
        } else {
            remainingIntervals = (remainingIntervals == 0) ? timePicker.countDownDuration : remainingIntervals
            let timestamp = Date().timeIntervalSince1970 + remainingIntervals
            let date = Date(timeIntervalSince1970: timestamp)
            let task = RealTask(.countdown, title: "Countdown", subtitle: timePicker.countDownDuration.text(), date: date)
            self.task = task
            scheduler.execute(task)
            countingDown()
        }

        sender.isSelected.toggle()
    }

    private func countingDown() {
        countDownLabel.text = remainingIntervals.text()
        countDownLabel.isHidden = false

        timer.start()
        timer.onTick(action: { [unowned self] _ in
            if remainingIntervals > 0 {
                remainingIntervals -= 1
                countDownLabel.text = remainingIntervals.text()
            } else if let t = task {
                resetUI()
                timer.stop()
                scheduler.terminate(t)
                task = nil
            }
        })
    }

    private func resetUI() {
        countDownLabel.text = nil
        countDownLabel.isHidden = true
        startButton.isSelected = false
    }
}
