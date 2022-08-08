//
//  HorizontalDescriptionCell.swift
//  Heart
//
//  Created by Александр Александрович on 04.08.2022.
//

import UIKit
import Stevia

final class HorizontalDescriptionCell: UICollectionViewCell {
    
    override var isSelected: Bool {
        didSet {
            self.contentView.backgroundColor = isSelected ? Color.borderGray : Color.background
            UIView.animate(withDuration: 0.3) {
                self.contentView.backgroundColor = Color.background
            }
        }
    }
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = Font.little
        return label
    }()
   
    override init(frame: CGRect) {
        super.init(frame: frame)        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureWith(viewModel: HorizontalDescriptionCellViewModel) {
        imageView.image = viewModel.image
        titleLabel.text = viewModel.title
        titleLabel.textColor = viewModel.color
    }
}

extension HorizontalDescriptionCell {
    func setupUI() {
        subviews(imageView, titleLabel)
        contentView.backgroundColor = UIColor(red: 247/255, green: 249/255, blue: 252/255, alpha: 1)
        contentView.layer.cornerRadius = 16
        
        imageView
            .leading(42)
            .trailing(41)
            .top(11)
            .height(28)
            .width(28)
        
        titleLabel.Top == imageView.Bottom + 4
        titleLabel
            .leading(11)
            .trailing(11)
            .bottom(11)
    }
}

