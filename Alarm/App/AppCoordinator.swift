//
//  AppCoordinator.swift
//  Alarm
//
//  Created by Joey Zhang on 2022/11/14.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    private let tab: UITabBarController
    private let nav: UINavigationController
    private let storyboard: UIStoryboard

    private var scheduler: TaskScheduler

    var parent: Coordinator?
    var children: [Coordinator]

    init(tab: UITabBarController, nav: UINavigationController, storyboard: UIStoryboard, scheduler: TaskScheduler) {
        self.tab = tab
        self.nav = nav
        self.parent = nil
        self.children = []
        self.scheduler = scheduler
        self.storyboard = storyboard

        setupTabBar()
    }

    func start() {
        showAlarmVC()
    }

    func showAlarmVC() {
        let alarmVC: AlarmViewController = storyboard.instantiateViewController()
        alarmVC.scheduler = scheduler
        alarmVC.coordinator = self
        nav.pushViewController(alarmVC, animated: true)
    }

    func showAddAlarmVC() {
        let vc: AddAlarmViewController = storyboard.instantiateViewController()
        vc.coordinator = self
        vc.scheduler = scheduler
        nav.pushViewController(vc, animated: true)
    }

    func showRepetitionVC(_ completion: ((Set<Int>) -> Void)?) {
        let vc: RepetitionViewController = storyboard.instantiateViewController()
        vc.coordinator = self
        vc.scheduler = scheduler
        vc.onDays = completion
        nav.pushViewController(vc, animated: true)
    }

    func pop() {
        nav.popViewController(animated: true)
    }
}

private extension AppCoordinator {
    func setupTabBar() {
        let alarmItem = UITabBarItem(title: "Alarm", image: nil, tag: 0)
        let timerItem = UITabBarItem(title: "Timer", image: nil, tag: 1)

        nav.tabBarItem = alarmItem

        let timerVC: TimerViewController = storyboard.instantiateViewController()
        timerVC.tabBarItem = timerItem
        timerVC.scheduler = scheduler
        timerVC.coordinator = self

        tab.viewControllers = [nav, timerVC]
    }
}
