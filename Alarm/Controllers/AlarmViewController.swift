//
//  AlarmViewController.swift
//  Alarm
//
//  Created by Joey Zhang on 2022/11/14.
//

import UIKit

class AlarmViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!

    weak var coordinator : AlarmCoordinator!
    var scheduler: ServiceScheduler!

    private var alarms: [AlarmService] {
        let services = scheduler.services.filter { $0 is AlarmService }
        return services.compactMap { $0 as? AlarmService }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        assert(scheduler != nil && coordinator != nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
    }

    @IBAction private func editTapped(_ sender: UIBarButtonItem) {
    }

    @IBAction private func addTapped(_ sender: UIBarButtonItem) {
        coordinator.showAddAlarmVC()
    }
}

extension AlarmViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarms.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AlarmTableViewCell = tableView.dequeueReusableCell(at: indexPath)
        cell.setCell(alarm: alarms[indexPath.row])

        return cell
    }
}

extension AlarmViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88.0
    }
}
