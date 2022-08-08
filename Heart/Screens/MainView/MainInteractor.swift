//
//  MainInteractor.swift
//  Heart
//
//  Created by Александр Александрович on 04.08.2022.
//

import Foundation

protocol MainLogic {
    func viewIsReady(request: MainModel.Start.Request)
    func cellIsReady(request: MainModel.Interact.Request)
    func cellIsSelected(request: MainModel.Update.Request)
    func cellIsFinished(request: MainModel.Result.Request)
}

protocol MainDataStore {
}

final class MainInteractor {
    // MARK: - Public Properties

    var presenter: MainPresenterLogic?

    // MARK: - Private Properties

    private let worker: MainWorkingLogic

    // MARK: - Init

    init(worker: MainWorkingLogic) {
        self.worker = worker
    }
}

// MARK: - Business Logic
extension MainInteractor: MainLogic {
    func cellIsFinished(request: MainModel.Result.Request) {
        worker.getResults { [weak self] result in
            let response = MainModel.Result.Response(pulse: result)
            self?.presenter?.displayResultsOfPusle(response: response)
        }
    }
    
    
    func cellIsSelected(request: MainModel.Update.Request) {
        let duration = request.duration
        worker.get(duration: duration) {[weak self] result in
            let response = MainModel.Update.Response(pulse: result!)
            self?.presenter?.displayPulse(response: response)
        }
    }
    
    func cellIsReady(request: MainModel.Interact.Request) {
        worker.startPulse()
        let response = MainModel.Interact.Response()
        self.presenter?.displayPresentationCell(response: response)
    }
    
    func viewIsReady(request: MainModel.Start.Request) {
        let response = MainModel.Start.Response()
        self.presenter?.displayPresentation(response: response)
    }
}

extension MainInteractor: MainDataStore {}
