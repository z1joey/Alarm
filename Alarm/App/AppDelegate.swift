//
//  AppDelegate.swift
//  Alarm
//
//  Created by Joey Zhang on 2022/11/14.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var coordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        requestNotificationAuthorization()

        window = UIWindow(frame: UIScreen.main.bounds)
        
        let tabBar = TabBarController()
        let navBar = UINavigationController()
        navBar.setNavigationBarHidden(true, animated: false) // uses custom nav bar

        let userDefaultService = UserDefaultService<RealTask>()
        let tasks = userDefaultService.items(forKey: "tasks")

        coordinator = AppCoordinator(
            tab: tabBar,
            nav: navBar,
            storyboard: UIStoryboard(name: "Main", bundle: .main),
            scheduler: RealTaskScheduler(
                tasks: tasks,
                notificationService: NotificationService(),
                userDefaultService: userDefaultService
            )
        )
        coordinator?.start()

        window?.rootViewController = tabBar
        window?.makeKeyAndVisible()

        return true
    }
}

extension AppDelegate: Logger {
    func requestNotificationAuthorization() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { [weak self] granted, _ in
            if granted {
                self?.log("User has granted notification permission")
            } else {
                self?.log("User has dennied notification permission")
            }
        }
    }
}

