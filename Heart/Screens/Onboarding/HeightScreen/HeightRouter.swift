//
//  GenderRiuter.swift
//  Heart
//
//  Created by Александр Александрович on 28.07.2022.
//

import Foundation
import UIKit

protocol HeightRoutingLogic {
    func route()
}

protocol HeightDataPassing {
    var dataStore: HeightDataStore? { get }
}

class HeightRouter : HeightDataPassing{
    // MARK: - Public Properties
    
    weak var viewController : HeightViewController?
    var dataStore: HeightDataStore?
    
    // MARK: - Navigation

    // MARK: - Private Properties
}

// MARK: - Routing Logic
extension HeightRouter: HeightRoutingLogic {
    func route() {
        let vc = WeightConfigurator.makeScene()
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}



