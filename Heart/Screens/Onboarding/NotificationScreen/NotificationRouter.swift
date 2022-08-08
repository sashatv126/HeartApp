//
//  GenderRiuter.swift
//  Heart
//
//  Created by Александр Александрович on 28.07.2022.
//

import Foundation
import UIKit

protocol NotificationRoutingLogic {
    func route()
}

protocol NotificationDataPassing {
    var dataStore: NotificationDataStore? { get }
}

class NotificationRouter : NotificationDataPassing{
    // MARK: - Public Properties
    
    weak var viewController : NotificationViewController?
    var dataStore: NotificationDataStore?
    
    // MARK: - Navigation

    // MARK: - Private Properties
}

// MARK: - Routing Logic
extension NotificationRouter: NotificationRoutingLogic {
    func route() {
        let vc = MainConfigurator.makeScene()
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}



