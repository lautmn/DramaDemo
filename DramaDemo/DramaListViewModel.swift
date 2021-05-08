//
//  DramaListViewModel.swift
//  DramaDemo
//
//  Created by Hao Lung Chen on 2021/5/4.
//

import Foundation
import Alamofire
import RxCocoa

class DramaListViewModel {

  let dramas = BehaviorRelay<[Drama]>(value: [])
  let isLoadingIndicatorHidden = BehaviorRelay<Bool>(value: true)

  func getDramas() {
    let decoder = JSONDecoder()
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    decoder.dateDecodingStrategy = .formatted(formatter)
    isLoadingIndicatorHidden.accept(false)
    AF.request("https://static.linetv.tw/interview/dramas-sample.json")
      .validate()
      .responseDecodable(of: [String: [Drama]].self,
                         decoder: decoder,
                         completionHandler: { (response) in
                          self.isLoadingIndicatorHidden.accept(true)
                          guard let dramas = response.value?["data"] else { return }
                          self.dramas.accept(dramas)
                          guard let date = dramas.first?.createdAt else { return }
                          let localFormatter = DateFormatter()
                          localFormatter.dateFormat = "yyyy/MM/dd HH:mm"
                          localFormatter.timeZone = .current
                          print(localFormatter.string(from: date))
                         })
  }
}
