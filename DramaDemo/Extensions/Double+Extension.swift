//
//  Double+Extension.swift
//  DramaDemo
//
//  Created by Hao Lung Chen on 2021/5/8.
//

import Foundation

extension Double {

  func rounded(toDecimal decimal: Int) -> Double {
    let numberOfDigits = pow(10.0, Double(decimal))
    return (self * numberOfDigits).rounded(.toNearestOrAwayFromZero) / numberOfDigits
  }

  func toString(format: String? = nil) -> String {
    guard let format = format else { return String(self) }
    return String(format: format, self)
  }

  func divided(by num: Double) -> Double {
    return self / num
  }
}
