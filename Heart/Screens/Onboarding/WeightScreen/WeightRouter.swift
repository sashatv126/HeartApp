//
//  GenderRiuter.swift
//  Heart
//
//  Created by Александр Александрович on 28.07.2022.
//

import Foundation
import UIKit

protocol WeightRoutingLogic {
    func route()
}

protocol WeightDataPassing {
    var dataStore: WeightDataStore? { get }
}

class WeightRouter : WeightDataPassing{
    // MARK: - Public Properties
    
    weak var viewController : WeightViewController?
    var dataStore: WeightDataStore?
    
    // MARK: - Navigation

    // MARK: - Private Properties
}

// MARK: - Routing Logic
extension WeightRouter: WeightRoutingLogic {
    func route() {
        let vc = NotificationConfigurator.makeScene()
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
}



