//
//  MainConfigurator.swift
//  Heart
//
//  Created by Александр Александрович on 04.08.2022.
//

import UIKit

struct MainConfigurator {
    // MARK: - Public Methods

    static func makeScene() -> MainViewController {
        let viewController = MainViewController()
        MainConfigurator.loadScene(viewController: viewController)
        return viewController
    }
}

// MARK: - Private Methods

extension MainConfigurator {
    private static func loadScene(viewController:MainViewController) {
        let pulse = PulseManager()
        let worker = MainWorker(pulse: pulse)
        let interactor = MainInteractor(worker: worker)
        let presenter = MainPresenter()
        let router = MainRouter()

        interactor.presenter = presenter
        presenter.viewController = viewController

        router.viewController = viewController
        router.dataStore = interactor

        viewController.interactor = interactor
        viewController.router = router
    }
}

