//
//  Date+Extension.swift
//  DramaDemo
//
//  Created by Hao Lung Chen on 2021/5/8.
//

import Foundation

extension Date {
  func toLocalDateString(_ format: String = "yyyy-MM-dd") -> String {
    let formatter = DateFormatter()
    print(formatter)
    formatter.dateFormat = format
    formatter.timeZone = .current
    return formatter.string(from: self)
  }
}
