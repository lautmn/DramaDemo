//
//  DramaDetailViewController.swift
//  DramaDemo
//
//  Created by Hao Lung Chen on 2021/5/9.
//

import UIKit

class DramaDetailViewController: UIViewController {

  @IBOutlet weak var detailTableView: UITableView!

  var viewModel: DramaDetailViewModel?

  func setViewModel(viewModel: DramaDetailViewModel) {
    self.viewModel = viewModel
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    detailTableView.register(UINib(nibName: "DramaDetailHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "DramaDetailHeaderTableViewCell")
    detailTableView.dataSource = self
  }
}

extension DramaDetailViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "DramaDetailHeaderTableViewCell", for: indexPath) as? DramaDetailHeaderTableViewCell,
          let viewModel = viewModel else { return UITableViewCell() }
    cell.viewModel = DramaTableViewCellViewModel(drama: viewModel.drama)
    return cell
  }
}
