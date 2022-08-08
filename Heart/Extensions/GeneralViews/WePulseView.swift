//
//  WePulseView.swift
//  Heart
//
//  Created by Александр Александрович on 03.08.2022.
//

import Foundation
import UIKit
import Stevia

class WePulseView: UIView {
    private let imagePusle: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = "pulse".image
        return image
    }()
    
    private let imageBadge: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.image = "badge".image
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addImage()
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.borderWidth = 2
    }
    
    override func layoutSubviews() {
        imagePusle.frame = self.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addImage() {
        self.subviews(imagePusle)
        imagePusle.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
        imagePusle
            .width(100)
            .height(100)
        
        imagePusle
            .CenterX == self.CenterX
        imagePusle
            .CenterY == self.CenterY
        
        imagePusle.subviews(imageBadge)
        
        imageBadge
            .width(27)
            .height(27)
            .top(-6)
            .right(0)
        
    }
}
