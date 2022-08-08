//
//  GenderInteractor.swift
//  Heart
//
//  Created by Александр Александрович on 28.07.2022.
//

import Foundation

protocol GenderLogic  {
    func viewIsReady(request : GenderModel.Start.Request)
    func buttonContinueTap(request: GenderModel.Route.Request)
}

protocol GenderDataStore {
}

final class GenderInteractor {
    // MARK: - Public Properties

    var presenter: GenderPresenterLogic?

    // MARK: - Private Properties

    private let worker: GenderWorking

    // MARK: - Init

    init(worker: GenderWorking) {
        self.worker = worker
    }
}
 
extension GenderInteractor : GenderLogic {
    func buttonContinueTap(request: GenderModel.Route.Request) {
        let response = GenderModel.Route.Response()
        self.presenter?.displayRoute(response: response)
    }
    
    func viewIsReady(request: GenderModel.Start.Request) {
        let response = GenderModel.Start.Response()
        self.presenter?.displayPresentation(response: response)
    }
}

extension GenderInteractor: GenderDataStore {
    
}
