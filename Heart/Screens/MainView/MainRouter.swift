//
//  MainRouter.swift
//  Heart
//
//  Created by Александр Александрович on 04.08.2022.
//

import UIKit

protocol MainRoutingLogic {
}

protocol MainDataPassing {
    var dataStore: MainDataStore? { get }
}

final class MainRouter {
    // MARK: - Public Properties

    weak var viewController: MainViewController?
    var dataStore: MainDataStore?

    // MARK: - Navigation

    // MARK: - Private Properties

}

// MARK: - Routing Logic
extension MainRouter: MainRoutingLogic {
}

// MARK: - Passing data
extension MainRouter: MainDataPassing {
}
