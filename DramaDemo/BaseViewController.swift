//
//  BaseViewController.swift
//  DramaDemo
//
//  Created by Hao Lung Chen on 2021/5/9.
//

import UIKit
import RxSwift
import Network

class BaseViewController: UIViewController {

  let monitor = NWPathMonitor()
  var disposeBag = DisposeBag()

  override func viewDidLoad() {
    super.viewDidLoad()

    monitor.pathUpdateHandler = { [weak self] path in
      DispatchQueue.main.async {
        self?.networkDidUpdate(path: path)
      }
    }

    monitor.start(queue: DispatchQueue.global())
  }

  func networkDidUpdate(path: NWPath) { }
}
