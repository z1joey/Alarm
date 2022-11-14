//
//  AppCoordinator.swift
//  Alarm
//
//  Created by Joey Zhang on 2022/11/14.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    var parent: Coordinator?
    var children: [Coordinator]

    private var root: UITabBarController
    private var scheduler: ServiceScheduler

    init(root: UITabBarController, scheduler: ServiceScheduler) {
        self.root = root
        self.parent = nil
        self.children = []
        self.scheduler = scheduler
    }

    func start() {
        let alarmItem = UITabBarItem(title: "Alarm", image: nil, tag: 0)
        let timerItem = UITabBarItem(title: "Timer", image: nil, tag: 1)

        let main = UIStoryboard(name: "Main", bundle: nil)
        let alarmNav = UINavigationController()
        alarmNav.setNavigationBarHidden(true, animated: false) // uses custom nav bar
        alarmNav.tabBarItem = alarmItem

        let alarmCoordinator = AlarmCoordinator(nav: alarmNav, scheduler: scheduler)
        alarmCoordinator.start()
        alarmCoordinator.parent = self
        children.append(alarmCoordinator)

        let timerVC: TimerViewController = main.instantiateViewController()
        timerVC.tabBarItem = timerItem
        timerVC.scheduler = scheduler
        timerVC.coordinator = self

        root.viewControllers = [alarmNav, timerVC]
    }
}
