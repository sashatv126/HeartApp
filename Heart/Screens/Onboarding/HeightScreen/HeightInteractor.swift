//
//  GenderInteractor.swift
//  Heart
//
//  Created by Александр Александрович on 28.07.2022.
//

import Foundation

protocol HeightLogic  {
    func viewIsReady(request: HeightModel.Start.Request)
    func viewWillAppear(request: HeightModel.Appear.Request)
    func viewWillDissapear(request: HeightModel.Disappear.Request)
    func segmentValueIsChanged(request: HeightModel.Change.Request)
    func keyboardWillShow(request: HeightModel.Keyboard.Request)
    func buttonContinueTap(request: HeightModel.Route.Request)
}

protocol HeightDataStore {
}

final class HeightInteractor {
    // MARK: - Public Properties

    var presenter: HeightPresenterLogic?

    // MARK: - Private Properties

    private let worker: HeightWorking

    // MARK: - Init

    init(worker: HeightWorking) {
        self.worker = worker
    }
}
 
extension HeightInteractor : HeightLogic {
    func viewWillAppear(request: HeightModel.Appear.Request) {
        let response = HeightModel.Appear.Response()
        self.presenter?.displayAppear(response: response)
    }
    
    func viewWillDissapear(request: HeightModel.Disappear.Request) {
        let response = HeightModel.Disappear.Response()
        self.presenter?.displayDisappear(response: response)
    }
    
    func buttonContinueTap(request: HeightModel.Route.Request) {
        let response = HeightModel.Route.Response()
        self.presenter?.displayRoute(response: response)
    }
    
    func viewIsReady(request: HeightModel.Start.Request) {
        let response = HeightModel.Start.Response()
        self.presenter?.displayPresentation(response : response)
    }
    
    func segmentValueIsChanged(request: HeightModel.Change.Request) {
        let inxex = request.index
        let response = HeightModel.Change.Response(index: inxex)
        self.presenter?.displaySegmentChange(response : response)
    }
    
    func keyboardWillShow(request: HeightModel.Keyboard.Request) {
        let height = request.height
        let response = HeightModel.Keyboard.Response(height: height)
        self.presenter?.displayKeyboard(response: response)
    }
}

extension HeightInteractor: HeightDataStore {
}
