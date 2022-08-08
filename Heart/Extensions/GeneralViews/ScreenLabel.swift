//
//  ScreenLabel.swift
//  Heart
//
//  Created by Александр Александрович on 29.07.2022.
//

import UIKit

class SceenLabel : UILabel {   
    init(frame: CGRect, text : String) {
        super.init(frame: frame)
        setupLabel(text: text)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupLabel(text : String) {
        self.text = text
        self.font = Font.labelText
    }
}
