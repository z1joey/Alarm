//
//  RepetitionViewController.swift
//  Alarm
//
//  Created by Joey Zhang on 2022/11/14.
//

import UIKit

class RepetitionViewController: UITableViewController, Logger {
    weak var coordinator : AppCoordinator!
    var scheduler: TaskScheduler!

    private var days: Set<Int> = []
    var onDays: ((Set<Int>) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        assert(scheduler != nil && coordinator != nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        onDays?(days)
    }

    deinit {
        log("deinit \(String(describing: self))")
    }
}

extension RepetitionViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        days.insert(indexPath.row + 1)
    }
}
