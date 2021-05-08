//
//  Drama.swift
//  DramaDemo
//
//  Created by Hao Lung Chen on 2021/5/4.
//

import Foundation

struct Drama: Codable {
  let id: Int?
  let name: String?
  let totalViews: Int?
  let createdAt: Date?
  let thumb: URL?
  let rating: Double?

  enum CodingKeys: String, CodingKey {
    case id = "drama_id"
    case name
    case totalViews = "total_views"
    case createdAt = "created_at"
    case thumb
    case rating
  }
}

