//
//  GenderConfigurator.swift
//  Heart
//
//  Created by Александр Александрович on 28.07.2022.
//

import UIKit

struct HeightConfigurator {
    // MARK: - Public Methods

    static func makeScene() -> HeightViewController {
        let viewController = HeightViewController()
        HeightConfigurator.loadScene(viewController: viewController)
        return viewController
    }
}

// MARK: - Private Methods

extension HeightConfigurator {
    private static func loadScene(viewController: HeightViewController) {
        let worker = HeightWorker()
        let interactor = HeightInteractor(worker: worker)
        let presenter = HeightPresenter()
        let router = HeightRouter()

        interactor.presenter = presenter
        presenter.viewController = viewController

        router.viewController = viewController
        router.dataStore = interactor

        viewController.interactor = interactor
        viewController.router = router
    }
}

