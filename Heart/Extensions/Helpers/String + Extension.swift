//
//  String + Extension.swift
//  Heart
//
//  Created by Александр Александрович on 29.07.2022.
//

import UIKit

extension String {
    var image: UIImage {
        guard let image = UIImage(named: self) else {
            fatalError("Такого изображения нет \(self)")
        }
        return image
    }
}
