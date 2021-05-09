//
//  DramaDetailHeaderTableViewCell.swift
//  DramaDemo
//
//  Created by Hao Lung Chen on 2021/5/9.
//

import UIKit

class DramaDetailHeaderTableViewCell: UITableViewCell {
  
  @IBOutlet weak var thumbImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var ratingLabel: UILabel!
  @IBOutlet weak var createTimeLabel: UILabel!
  @IBOutlet weak var totalViewsLabel: UILabel!

  var viewModel: DramaTableViewCellViewModel? {
    didSet {
      setupViews()
    }
  }

  func setupViews() {
    guard let viewModel = viewModel else { return }
    nameLabel.text = viewModel.name
    ratingLabel.text = viewModel.rating
    createTimeLabel.text = viewModel.createTime
    totalViewsLabel.text = viewModel.totalViews
  }
}
