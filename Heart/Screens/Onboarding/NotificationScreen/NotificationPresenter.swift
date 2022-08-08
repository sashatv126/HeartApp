//
//  NotificationPresenter.swift
//  Heart
//
//  Created by Александр Александрович on 03.08.2022.
//

import Foundation

protocol NotificationPresenterLogic {
    func displayPresentation(response: NotificationModel.Start.Response)
    func displayMain(response: NotificationModel.Route.Response)
}

final class NotificationPresenter {
    // MARK: - Public Properties

    weak var viewController: NotificationDisplayLogic?

    // MARK: - Private Properties

}

extension NotificationPresenter: NotificationPresenterLogic {
    func displayMain(response: NotificationModel.Route.Response) {
        let viewModel = NotificationModel.Route.ViewModel()
        viewController?.tapButtonAllow(viewModel: viewModel)
    }
    
    func displayPresentation(response: NotificationModel.Start.Response) {
        let viewModel = NotificationModel.Start.ViewModel()
        viewController?.initialSetup(viewModel: viewModel)
    }
}
