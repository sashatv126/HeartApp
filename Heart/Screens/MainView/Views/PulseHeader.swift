//
//  PulseHeader.swift
//  Heart
//
//  Created by Александр Александрович on 04.08.2022.
//

import UIKit
import Stevia

final class YourPulseHeaderView: UICollectionReusableView {
    
    private let bulbImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = "bulb_ic".image
        return imageView
    }()
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.font = Font.normal
        label.textColor = .black
        return label
    }()
    
    private let buldTitleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.normal
        label.text = "Daily advice".uppercased()
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = Text.pulseHeader
        label.numberOfLines = 0
        return label
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Public Methods

    func configure(title: String?) {
        headerLabel.text = title
    }
}

// MARK: - Private methods

extension YourPulseHeaderView {
    private func setupUI() {
        subviews(headerLabel, bulbImage, buldTitleLabel, descriptionLabel)
        
        bulbImage
            .top(16)
            .leading(24)
            .height(28)
            .width(28)
       
        buldTitleLabel.Leading == bulbImage.Trailing + 6
        buldTitleLabel
            .top(16)
        
        descriptionLabel.Top == buldTitleLabel.Bottom + 10
        descriptionLabel
            .leading(24)
            .trailing(19)
        
        headerLabel.Top == descriptionLabel.Bottom + 16
        headerLabel.fillHorizontally()
        headerLabel
            .leading(16)
            .bottom(16)
    }
}


