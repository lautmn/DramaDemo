//
//  PreferenceManager.swift
//  DramaDemo
//
//  Created by Hao Lung Chen on 2021/5/9.
//

import Foundation

class PreferenceManager {
  static let instance = PreferenceManager()
  private let userDefaults: UserDefaults

  init() {
    self.userDefaults = .standard
  }

  enum UserDefaultsKeys: String {
    case searchText
  }

  func setValue(_ value: Any?, for key: UserDefaultsKeys) {
    userDefaults.setValue(value, forKey: key.rawValue)
  }

  func getString(by key: UserDefaultsKeys) -> String? {
    return userDefaults.string(forKey: key.rawValue)
  }
}
