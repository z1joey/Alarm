//
//  UserDefaultService.swift
//  Alarm
//
//  Created by Joey Zhang on 2022/11/15.
//

import Foundation


class UserDefaultService<T: Codable & Hashable>: Logger {
    private let store = UserDefaults.standard

    func items(forKey key: String) -> Set<T> {
        if let data = UserDefaults.standard.data(forKey: key) {
            do {
                let decoder = JSONDecoder()
                let tasks = try decoder.decode(Set<T>.self, from: data)
                return tasks
            } catch {
                log(error)
            }
        }

        return []
    }

    func add(item: T, forKey key: String) {
        do {
            var items = items(forKey: key)
            items.insert(item)

            let encoder = JSONEncoder()
            let data = try encoder.encode(items)

            UserDefaults.standard.set(data, forKey: key)
            log("added: \(item)")
        } catch {
            log(error)
        }
    }

    func remove(item: T, forKey key: String) {
        do {
            var items = items(forKey: key)
            items.remove(item)
            let encoder = JSONEncoder()
            let data = try encoder.encode(items)
            UserDefaults.standard.set(data, forKey: key)
            log("removed: \(item)")
        } catch {
            log(error)
        }
    }
}
