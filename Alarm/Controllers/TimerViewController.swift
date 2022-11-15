//
//  TimerViewController.swift
//  Alarm
//
//  Created by Joey Zhang on 2022/11/14.
//

import UIKit

class TimerViewController: UIViewController {
    weak var coordinator : AppCoordinator!
    var scheduler: TaskScheduler!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        assert(scheduler != nil && coordinator != nil)
    }
}
