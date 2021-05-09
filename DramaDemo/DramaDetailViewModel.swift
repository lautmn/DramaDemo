//
//  DramaDetailViewModel.swift
//  DramaDemo
//
//  Created by Hao Lung Chen on 2021/5/9.
//

import Foundation
import RxSwift
import RxCocoa

class DramaDetailViewModel {

  let drama: Drama

  init(drama: Drama) {
    self.drama = drama
  }

  var dataSource: Observable<Drama> {
    return Observable.just(drama)
  }

}
