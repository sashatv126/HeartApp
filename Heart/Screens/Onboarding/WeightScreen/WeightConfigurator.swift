//
//  GenderConfigurator.swift
//  Heart
//
//  Created by Александр Александрович on 28.07.2022.
//

import UIKit

struct WeightConfigurator {
    // MARK: - Public Methods

    static func makeScene() -> WeightViewController {
        let viewController = WeightViewController()
        WeightConfigurator.loadScene(viewController: viewController)
        return viewController
    }
}

// MARK: - Private Methods

extension WeightConfigurator {
    private static func loadScene(viewController: WeightViewController) {
        let worker = WeightWorker()
        let interactor = WeightInteractor(worker: worker)
        let presenter = WeightPresenter()
        let router = WeightRouter()

        interactor.presenter = presenter
        presenter.viewController = viewController

        router.viewController = viewController
        router.dataStore = interactor

        viewController.interactor = interactor
        viewController.router = router
    }
}
