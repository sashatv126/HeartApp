//
//  UINavigationController + Extension.swift
//  Heart
//
//  Created by Александр Александрович on 03.08.2022.
//

import Foundation
import UIKit

extension UINavigationController {
    func backButton() {
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            let navAppearance = UINavigationBar.appearance()
            appearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
            appearance.backButtonAppearance.highlighted.titleTextAttributes = [.foregroundColor: UIColor.clear]
            self.navigationItem.leftBarButtonItem = nil;
            navigationItem.backButtonDisplayMode = .minimal
            navAppearance.tintColor = Color.gray
            navAppearance.standardAppearance = appearance
        }
    }
}
