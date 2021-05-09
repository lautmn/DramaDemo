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
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var cancelButton: UIButton!
  @IBOutlet weak var noSearchResultLabel: UILabel!
  var disposeBag = DisposeBag()

  var viewModel: DramaListViewModel?

  func setViewModel(viewModel: DramaListViewModel) {
    self.viewModel = viewModel
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel?.getDramas()
    dramaTableView.register(UINib(nibName: "DramaTableViewCell", bundle: nil), forCellReuseIdentifier: "DramaTableViewCell")

    searchBar.delegate = self

    _ = viewModel?.dataSource
      .take(until: rx.deallocated)
      .bind(to: dramaTableView.rx.items(cellIdentifier: "DramaTableViewCell", cellType: DramaTableViewCell.self)) { row, element, cell in
        cell.viewModel = DramaTableViewCellViewModel(drama: element) }

    searchBar.rx
      .textDidBeginEditing
      .asDriver()
      .drive(
        onNext: { [weak self] in
          self?.setCancelButton(isHidden: false) })
      .disposed(by: disposeBag)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    dramaTableView.rx.didScroll
      .subscribe(
        onNext: { [weak self] in
          self?.view.endEditing(true) })
      .disposed(by: disposeBag)

    viewModel?.searchText
      .asDriver()
      .drive(searchBar.rx.text)
      .disposed(by: disposeBag)

    viewModel?.dataSource
      .map { !$0.isEmpty }
      .asDriver(onErrorJustReturn: true)
      .drive(noSearchResultLabel.rx.isHidden)
      .disposed(by: disposeBag)
  }

  override func viewWillDisappear(_ animated: Bool) {
    disposeBag = DisposeBag()
    super.viewWillDisappear(animated)
  }

  @IBAction func pressedCancelButton(_ sender: Any) {
    view.endEditing(true)
    viewModel?.searchText.accept("")
    setCancelButton(isHidden: true)
  }

  private func setCancelButton(isHidden: Bool) {
    UIView.animate(withDuration: 0.3) {
      self.cancelButton.isHidden = isHidden
    }
  }
}

extension DramaListViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    viewModel?.searchText.accept(searchText)
  }
}
