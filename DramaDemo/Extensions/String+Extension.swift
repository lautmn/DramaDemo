//
//  String+Extension.swift
//  DramaDemo
//
//  Created by Hao Lung Chen on 2021/5/9.
//

import Foundation

extension String {
  func getSimilarity(to string: String) -> Int {
    if self == string { return 10 }
    if self.contains(string) { return 6 }
    return Set(self).intersection(string.prefix(5)).count
  }
}
