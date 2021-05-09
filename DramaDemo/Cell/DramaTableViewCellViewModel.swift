//
//  DramaTableViewCellViewModel.swift
//  DramaDemo
//
//  Created by Hao Lung Chen on 2021/5/4.
//

import Foundation

struct DramaTableViewCellViewModel {

  let drama: Drama

  init(drama: Drama) {
    self.drama = drama
  }

  var name: String {
    return drama.name ?? ""
  }

  var rating: String {
    return "評分" + (drama.rating?.rounded(toDecimal: 1).toString(format: "%.1f") ?? "0.0")
  }

  var createTime: String {
    return "出版日期：" + (drama.createdAt?.toLocalDateString() ?? "")
  }

  var thumbURL: URL? {
    return drama.thumb
  }

  var totalViews: String {
    return (drama.totalViews?.toDouble().divided(by: 10000).rounded(toDecimal: 1).toString(format: "%.1f") ?? "0") + "萬次觀看"
  }
}
