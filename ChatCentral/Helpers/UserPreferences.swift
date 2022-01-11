//
//  UserPreferences.swift
//  CoinCheck
//
//  Created by Anibal Ventura on 10/1/22.
//

import Foundation

struct Prefs {
    static func set<T>(value: T, key: String) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key)
    }

    static func get<T>(type: T.Type, forKey: String) -> T? {
        let defaults = UserDefaults.standard
        return defaults.object(forKey: forKey) as? T
    }

    static func remove(key: String) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: key)
    }
}
