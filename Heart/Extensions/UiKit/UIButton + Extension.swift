//
//  UIButtin + Extension.swift
//  Heart
//
//  Created by Александр Александрович on 02.08.2022.
//

import UIKit

extension UIButton {
    convenience init(title : String?,
                     titleColor : UIColor = .white,
                     backGroundColor : UIColor = Color.pink!,
                     fornt : UIFont? = .systemFont(ofSize: 20, weight: .bold),
                     isShadow : Bool = false,
                     cornerRadus : CGFloat = 15) {
        
        self.init(type : .system)
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backGroundColor
        self.titleLabel?.font = fornt
        self.layer.cornerRadius = cornerRadus
        
        if isShadow {
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowRadius = 4
            self.layer.shadowOpacity = 0.2
            self.layer.shadowOffset = CGSize(width: 0, height: 4)
        }
    }
}
