//
//  GenderConfigurator.swift
//  Heart
//
//  Created by Александр Александрович on 28.07.2022.
//

import UIKit

struct GenderConfigurator {
    // MARK: - Public Methods

    static func makeScene() -> GenderViewController {
        let viewController = GenderViewController()
        GenderConfigurator.loadScene(viewController: viewController)
        return viewController
    }
}

// MARK: - Private Methods

extension GenderConfigurator {
    private static func loadScene(viewController: GenderViewController) {
        let worker = GenderWorker()
        let interactor = GenderInteractor(worker: worker)
        let presenter = GenderPresenter()
        let router = GenderRouter()

        interactor.presenter = presenter
        presenter.viewController = viewController

        router.viewController = viewController
        router.dataStore = interactor

        viewController.interactor = interactor
        viewController.router = router
    }
}
