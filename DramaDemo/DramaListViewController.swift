//
//  DramaListViewController.swift
//  DramaDemo
//
//  Created by Hao Lung Chen on 2021/5/4.
//

import UIKit
import RxSwift
import Network

class DramaListViewController: BaseViewController {

  @IBOutlet weak var dramaTableView: UITableView!
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var cancelButton: UIButton!
  @IBOutlet weak var noSearchResultLabel: UILabel!
  @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
  @IBOutlet weak var networkErrorLabel: UILabel!

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

    navigationItem.title = "戲劇列表"
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

    dramaTableView.rx
      .modelSelected(Drama.self)
      .asDriver()
      .drive(
        onNext: { [weak self] drama in
          self?.toDetailVC(drama: drama) })
      .disposed(by: disposeBag)

    searchBar.rx
      .textDidBeginEditing
      .asDriver()
      .drive(
        onNext: { [weak self] in
          self?.setCancelButton(isHidden: false) })
      .disposed(by: disposeBag)

    searchBar.rx.searchButtonClicked
      .subscribe(
        onNext: { [weak self] in
          self?.view.endEditing(true) })
      .disposed(by: disposeBag)

    viewModel?.isLoadingIndicatorHidden
      .asDriver()
      .drive(
        onNext: { [weak self] isHidden in
          self?.loadingIndicator.isHidden = isHidden
          _ = isHidden ? self?.loadingIndicator.stopAnimating() : self?.loadingIndicator.startAnimating() })
      .disposed(by: disposeBag)
  }

  override func viewWillDisappear(_ animated: Bool) {
    disposeBag = DisposeBag()
    super.viewWillDisappear(animated)
  }

  override func networkDidUpdate(path: NWPath) {
    networkErrorLabel.isHidden = path.status == .satisfied
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

  private func toDetailVC(drama: Drama) {
    let detailVC = DramaDetailViewController()
    detailVC.setViewModel(viewModel: DramaDetailViewModel(drama: drama))
    navigationController?.pushViewController(detailVC, animated: true)
  }
}

extension DramaListViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    viewModel?.searchText.accept(searchText)
  }
}
