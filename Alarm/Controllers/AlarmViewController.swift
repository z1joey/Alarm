//
//  AlarmViewController.swift
//  Alarm
//
//  Created by Joey Zhang on 2022/11/14.
//

import UIKit

class AlarmViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!

    weak var coordinator : AppCoordinator!
    var scheduler: TaskScheduler!

    private var alarmTasks: [Task] {
        return scheduler.tasks.filter { $0.type == .alarm }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        assert(scheduler != nil && coordinator != nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.isEditing = false
        tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
    }

    @IBAction private func editTapped(_ sender: UIBarButtonItem) {
        tableView.isEditing.toggle()
    }

    @IBAction private func addTapped(_ sender: UIBarButtonItem) {
        coordinator.showAddAlarmVC()
    }
}

extension AlarmViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarmTasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AlarmTableViewCell = tableView.dequeueReusableCell(at: indexPath)
        cell.setCell(task: alarmTasks[indexPath.row])
        cell.switchToogled = { [unowned self] isOn in
            let scheduler = scheduler as? RealTaskScheduler
            if isOn {
                scheduler?.enableNotification(alarmTasks[indexPath.row])
            } else {
                scheduler?.disableNotification(alarmTasks[indexPath.row])
            }
        }

        return cell
    }
}

extension AlarmViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            scheduler.terminate(alarmTasks[indexPath.row])
            tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
        }
    }
}
