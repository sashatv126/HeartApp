//
//  GenderInteractor.swift
//  Heart
//
//  Created by Александр Александрович on 28.07.2022.
//

import Foundation

protocol WeightLogic  {
    func viewIsReady(request: WeightModel.Start.Request)
    func viewWillAppear(request: WeightModel.Appear.Request)
    func viewWillDissapear(request: WeightModel.Disappear.Request)
    func segmentValueIsChanged(request: WeightModel.Change.Request)
    func keyboardWillShow(request: WeightModel.Keyboard.Request)
    func buttonContinueTap(request: WeightModel.Route.Request)
}

protocol WeightDataStore {
}

final class WeightInteractor {
    // MARK: - Public Properties

    var presenter: WeightPresenterLogic?

    // MARK: - Private Properties

    private let worker: WeightWorking

    // MARK: - Init

    init(worker: WeightWorking) {
        self.worker = worker
    }
}
 
extension WeightInteractor : WeightLogic {
    func viewWillAppear(request: WeightModel.Appear.Request) {
        let response = WeightModel.Appear.Response()
        self.presenter?.displayAppear(response : response)
    }
    
    func viewWillDissapear(request: WeightModel.Disappear.Request) {
        let response = WeightModel.Disappear.Response()
        self.presenter?.displayDisappear(response : response)
    }
    
    func buttonContinueTap(request: WeightModel.Route.Request) {
        let response = WeightModel.Route.Response()
        self.presenter?.displayRoute(response : response)
    }
    
    func viewIsReady(request: WeightModel.Start.Request) {
        let response = WeightModel.Start.Response()
        self.presenter?.displayPresentation(response : response)
    }
    
    func segmentValueIsChanged(request: WeightModel.Change.Request) {
        let inxex = request.index
        let response = WeightModel.Change.Response(index: inxex)
        self.presenter?.displaySegmentChange(response : response)
    }
    
    func keyboardWillShow(request: WeightModel.Keyboard.Request) {
        let height = request.height
        let response = WeightModel.Keyboard.Response(height: height)
        self.presenter?.displayKeyboard(response: response)
    }
}

extension WeightInteractor: WeightDataStore {
}
