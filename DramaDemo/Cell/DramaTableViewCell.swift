//
//  DramaTableViewCell.swift
//  DramaDemo
//
//  Created by Hao Lung Chen on 2021/5/4.
//

import UIKit

class DramaTableViewCell: UITableViewCell {
  
  @IBOutlet weak var thumbImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var ratingLabel: UILabel!
  @IBOutlet weak var createTimeLabel: UILabel!

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
  }

}
