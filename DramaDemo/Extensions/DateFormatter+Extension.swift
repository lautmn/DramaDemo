//
//  DateFormatter+Extension.swift
//  DramaDemo
//
//  Created by Hao Lung Chen on 2021/5/9.
//

import Foundation

extension DateFormatter {
  static let currentDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.timeZone = .current
    return formatter
  }()
}
