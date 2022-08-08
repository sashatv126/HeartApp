//
//  GenderConfigurator.swift
//  Heart
//
//  Created by Александр Александрович on 28.07.2022.
//

import UIKit

struct NotificationConfigurator {
    // MARK: - Public Methods

    static func makeScene() -> NotificationViewController {
        let viewController = NotificationViewController()
        NotificationConfigurator.loadScene(viewController: viewController)
        return viewController
    }
}

// MARK: - Private Methods

extension NotificationConfigurator {
    private static func loadScene(viewController: NotificationViewController) {
        let worker = NotificationWorker()
        let interactor = NotificationInteractor(worker: worker)
        let presenter = NotificationPresenter()
        let router = NotificationRouter()

        interactor.presenter = presenter
        presenter.viewController = viewController

        router.viewController = viewController
        router.dataStore = interactor

        viewController.interactor = interactor
        viewController.router = router
    }
}
