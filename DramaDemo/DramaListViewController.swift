//
//  DramaListViewController.swift
//  DramaDemo
//
//  Created by Hao Lung Chen on 2021/5/4.
//

import UIKit
import RxSwift

class DramaListViewController: UIViewController {

  @IBOutlet weak var dramaTableView: UITableView!

  var viewModel: DramaListViewModel?

  func setViewModel(viewModel: DramaListViewModel) {
    self.viewModel = viewModel
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel?.getDramas()
    dramaTableView.register(UINib(nibName: "DramaTableViewCell", bundle: nil), forCellReuseIdentifier: "DramaTableViewCell")

    _ = viewModel?.dramas
      .take(until: rx.deallocated)
      .bind(to: dramaTableView.rx.items(cellIdentifier: "DramaTableViewCell", cellType: DramaTableViewCell.self)) { row, element, cell in
        cell.viewModel = DramaTableViewCellViewModel(drama: element) }
  }
}
