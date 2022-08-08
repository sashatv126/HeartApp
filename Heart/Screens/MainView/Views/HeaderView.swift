//
//  HeaderView.swift
//  Heart
//
//  Created by Александр Александрович on 04.08.2022.
//

import UIKit
import Stevia

final class TitleHeaderView: UICollectionReusableView {
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.font = Font.normal
        label.textColor = .black
        return label
    }()
   
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods

    func configure(title: String?) {
        headerLabel.text = title
    }
}

// MARK: - Private methods

extension TitleHeaderView {
    private func setupUI() {
        subviews(headerLabel)
        
        headerLabel
            .top(0)
            .fillHorizontally()
            .leading(16)
            .bottom(0)
    }
}

