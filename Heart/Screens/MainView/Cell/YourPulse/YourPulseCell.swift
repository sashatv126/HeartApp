//
//  YourPulseCell.swift
//  Heart
//
//  Created by Александр Александрович on 04.08.2022.
//

import UIKit
import Stevia

final class YourPulseCell: UICollectionViewCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(17)
        return label
    }()
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.image = "little_heart".image
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Semibold", size: 14)
        label.text = Text.noData
        return label
    }()
    
    private let bpmLabel: UILabel = {
        let label = UILabel()
        label.text = Text.bpm.uppercased()
        label.font = label.font.withSize(13)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureWith(viewModel: YourPulseCellViewModel) {
        titleLabel.text = viewModel.title
        guard let text = viewModel.numderTitle else { return }
        numberLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 26)
        numberLabel.text = text
    }
}

extension YourPulseCell {
    private func setupUI() {
        contentView.subviews(imageView, titleLabel, numberLabel, bpmLabel)
        contentView.backgroundColor = UIColor(red: 247/255, green: 249/255, blue: 252/255, alpha: 1)
        contentView.layer.cornerRadius = 16
        
        titleLabel
            .top(16)
            .leading(16)
            .height(20)
        
        imageView.Top == titleLabel.Bottom + 11
        imageView
            .leading(16)
            .width(28)
            .height(28)
            .bottom(17)
        
        numberLabel.Top == titleLabel.Bottom + 11
        numberLabel.Leading == imageView.Trailing + 8
        numberLabel.bottom(17)
        
        bpmLabel.Bottom == numberLabel.Bottom
        bpmLabel.Leading == numberLabel.Trailing + 4
    }
}
