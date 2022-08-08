//
//  SleepTimeCell.swift
//  Heart
//
//  Created by Александр Александрович on 04.08.2022.
//

import UIKit
import Stevia

final class SleepTimeCell: UICollectionViewCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(17)
        return label
    }()
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let clockLabel: UILabel = {
        let label = UILabel()
        label.font = Font.normal
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureWith(viewModel: SleepTimeCellViewModel) {
        titleLabel.text = viewModel.title
        imageView.image = viewModel.image
        titleLabel.textColor = viewModel.color
        clockLabel.text = viewModel.clockTitle
    }
}

extension SleepTimeCell {
    private func setupUI() {
        contentView.subviews(imageView, titleLabel, clockLabel)
        contentView.backgroundColor = UIColor(red: 247/255, green: 249/255, blue: 252/255, alpha: 1)
        contentView.layer.cornerRadius = 16
        
        imageView
            .top(16)
            .leading(16)
            .height(28)
            .width(28)
        
        titleLabel.Leading == imageView.Trailing + 8
        titleLabel
            .top(16)
        
        clockLabel.Top == titleLabel.Bottom + 10
        clockLabel
            .leading(16)
            .bottom(16)
    }
}

