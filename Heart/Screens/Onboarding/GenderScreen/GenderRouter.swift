//
//  GenderRiuter.swift
//  Heart
//
//  Created by Александр Александрович on 28.07.2022.
//

import Foundation
import UIKit

protocol GenderRoutingLogic {
    func route()
}

protocol GenderDataPassing {
    var dataStore: GenderDataStore? { get }
}

class GenderRouter : GenderDataPassing{
    // MARK: - Public Properties
    
    weak var viewController : GenderViewController?
    var dataStore: GenderDataStore?
    
    // MARK: - Navigation

    // MARK: - Private Properties
}

// MARK: - Routing Logic
extension GenderRouter: GenderRoutingLogic {
    func route() {
        let vc = HeightConfigurator.makeScene()
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
}


