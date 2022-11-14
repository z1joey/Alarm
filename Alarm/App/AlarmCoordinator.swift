//
//  AlarmCoordinator.swift
//  Alarm
//
//  Created by Joey Zhang on 2022/11/14.
//

import Foundation
import UIKit

class AlarmCoordinator: Coordinator {
    private let main = UIStoryboard(name: "Main", bundle: nil)
    private var nav: UINavigationController
    private var scheduler: ServiceScheduler

    var parent: Coordinator?
    var children: [Coordinator]

    init(nav: UINavigationController, scheduler: ServiceScheduler) {
        self.nav = nav
        self.parent = nil
        self.children = []
        self.scheduler = scheduler
    }

    func start() {
        showAlarmVC()
    }

    func pop() {
        nav.popViewController(animated: true)
    }

    func showAlarmVC() {
        let alarmVC: AlarmViewController = main.instantiateViewController()
        alarmVC.scheduler = scheduler
        alarmVC.coordinator = self
        nav.pushViewController(alarmVC, animated: true)
    }

    func showAddAlarmVC() {
        let vc: AddAlarmViewController = main.instantiateViewController()
        vc.coordinator = self
        vc.scheduler = scheduler
        nav.pushViewController(vc, animated: true)
    }

    func showRepetitionVC(_ completion: ((Set<Int>) -> Void)?) {
        let vc: RepetitionViewController = main.instantiateViewController()
        vc.coordinator = self
        vc.scheduler = scheduler
        vc.onDays = completion
        nav.pushViewController(vc, animated: true)
    }
}
