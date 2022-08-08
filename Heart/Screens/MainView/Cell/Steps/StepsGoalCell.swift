//
//  StepsCell.swift
//  Heart
//
//  Created by Александр Александрович on 04.08.2022.
//

import UIKit
import Stevia

final class StepsGoalCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.image = "steps_ic".image
        return image
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Text.stepsGo
        label.textColor = UIColor(red: 184/255, green: 59/255, blue: 216/255, alpha: 1)
        return label
    }()
    
    let stepsLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureWith(viewModel: StepsGoalCellViewModel) {
        stepsLabel.text = viewModel.steps
    }
}

extension StepsGoalCell {
    private func setupUI() {
        contentView.subviews(imageView, titleLabel, stepsLabel)
        contentView.backgroundColor = UIColor(red: 247/255, green: 249/255, blue: 252/255, alpha: 1)
        contentView.layer.cornerRadius = 16
        
        imageView
            .top(16)
            .leading(16)
            .height(28)
            .width(28)
        
        titleLabel.Leading == imageView.Trailing + 8
        titleLabel.Bottom == imageView.Bottom
        
        stepsLabel.Top == imageView.Bottom + 10
        stepsLabel
            .leading(16)
            .bottom(16)
    }
}


