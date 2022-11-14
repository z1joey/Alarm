//
//  AlarmCoordinator.swift
//  Alarm
//
//  Created by Joey Zhang on 2022/11/14.
//

import Foundation
import UIKit

class AlarmCoordinator: Coordinator {
    var parent: Coordinator?
    var children: [Coordinator]

    private var nav: UINavigationController
    private var scheduler: ServiceScheduler

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
        let main = UIStoryboard(name: "Main", bundle: nil)
        let alarmVC: AlarmViewController = main.instantiateViewController()
        alarmVC.scheduler = scheduler
        alarmVC.coordinator = self
        nav.pushViewController(alarmVC, animated: true)
    }

    func showAddAlarmVC() {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let vc: AddAlarmViewController = main.instantiateViewController()
        vc.coordinator = self
        vc.scheduler = scheduler
        nav.pushViewController(vc, animated: true)
    }

    func showRepetitionVC() {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let vc: RepetitionViewController = main.instantiateViewController()
        vc.coordinator = self
        vc.scheduler = scheduler
        nav.pushViewController(vc, animated: true)
    }
}
