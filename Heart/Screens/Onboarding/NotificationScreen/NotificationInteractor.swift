//
//  NotificationInteractor.swift
//  Heart
//
//  Created by Александр Александрович on 03.08.2022.
//

import Foundation

protocol NotificationLogic  {
    func viewIsReady(request: NotificationModel.Start.Request)
    func viewIsInteract(request: NotificationModel.Route.Request)
}

protocol NotificationDataStore {
}

final class NotificationInteractor {
    // MARK: - Public Properties

    var presenter: NotificationPresenterLogic?

    // MARK: - Private Properties

    private let worker: NotificationWorking

    // MARK: - Init

    init(worker: NotificationWorking) {
        self.worker = worker
    }
}
 
extension NotificationInteractor: NotificationLogic {
    func viewIsInteract(request: NotificationModel.Route.Request) {
        let response = NotificationModel.Route.Response()
        self.presenter?.displayMain(response: response)
    }
    
    func viewIsReady(request: NotificationModel.Start.Request) {
        let response = NotificationModel.Start.Response()
        self.presenter?.displayPresentation(response: response)
    }
}

extension NotificationInteractor: NotificationDataStore {
    
}
