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

  func toRealmObject() -> DramaObject {
    let object = DramaObject()
    object.id = id ?? 0
    object.name = name
    object.totalViews = totalViews ?? 0
    object.createdAt = createdAt
    object.thumb = thumb?.absoluteString
    object.rating = rating ?? 0
    return object
  }
}

import RealmSwift

class DramaObject: Object {
  @objc dynamic var id: Int = 0
  @objc dynamic var name: String?
  @objc dynamic var totalViews: Int = 0
  @objc dynamic var createdAt: Date? = Date()
  @objc dynamic var thumb: String?
  @objc dynamic var rating: Double = 0

  func toDrama() -> Drama {
    return Drama(id: id,
                 name: name,
                 totalViews: totalViews,
                 createdAt: createdAt,
                 thumb: URL(string: thumb ?? ""),
                 rating: rating)
  }
}
