//
//  StepsGoalCell.swift
//  testProjectPulse
//
//  Created by Владислав Седенков on 27.07.2022.
//

import UIKit
import Stevia

final class GenderCell: UICollectionViewCell {
    
   

    override var isSelected: Bool {
        didSet {
            self.contentView.backgroundColor = isSelected ? Color.pink : Color.background
            self.titleLabel.textColor = isSelected ? Color.background : Color.blackSegment
        }
    }
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.image = "smile".image
        return image
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureWith(viewModel: GenderCellViewModel) {
        titleLabel.text = viewModel.title
    }
}

extension GenderCell {
    private func setupUI() {
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = Color.borderGray?.cgColor
        contentView.subviews(imageView, titleLabel)
        contentView.backgroundColor = Color.background
        contentView.layer.cornerRadius = 25
        
        imageView
            .height(24)
            .width(24)
            .right(16)
            .CenterY == contentView.CenterY
        
        titleLabel
            .left(16)
            .CenterY == contentView.CenterY
    }
}
