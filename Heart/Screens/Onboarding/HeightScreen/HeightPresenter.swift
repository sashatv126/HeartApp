//
//  GenderPresenter.swift
//  Heart
//
//  Created by Александр Александрович on 28.07.2022.
//

import Foundation

protocol HeightPresenterLogic {
    func displayPresentation(response: HeightModel.Start.Response)
    func displayAppear(response: HeightModel.Appear.Response)
    func displayDisappear(response: HeightModel.Disappear.Response)
    func displaySegmentChange(response: HeightModel.Change.Response)
    func displayKeyboard(response: HeightModel.Keyboard.Response)
    func displayRoute(response: HeightModel.Route.Response)
}

final class HeightPresenter {
    // MARK: - Public Properties

    weak var viewController: HeightDisplayLogic?

    // MARK: - Private Properties

}

extension HeightPresenter : HeightPresenterLogic {
    func displayAppear(response: HeightModel.Appear.Response) {
        let viewModel = HeightModel.Appear.ViewModel()
        viewController?.viewWillAppear(viewModel: viewModel)
    }
    
    func displayDisappear(response: HeightModel.Disappear.Response) {
        let viewModel = HeightModel.Disappear.ViewModel()
        viewController?.viewWillDisappear(viewModel: viewModel)
    }
    
    func displayRoute(response: HeightModel.Route.Response) {
        let viewModel = HeightModel.Route.ViewModel()
        viewController?.buttonTap(viewModel: viewModel)
    }
    
    func displayPresentation(response: HeightModel.Start.Response) {
        let viewModel = HeightModel.Start.ViewModel()
        viewController?.initialSetup(viewModel: viewModel)
    }
    
    func displaySegmentChange(response: HeightModel.Change.Response) {
        let index = response.index
        let viewModel = HeightModel.Change.ViewModel(index: index)
        viewController?.setupChanges(viewModel: viewModel)
    }
    
    func displayKeyboard(response: HeightModel.Keyboard.Response) {
        let height = response.height
        let viewModel = HeightModel.Keyboard.ViewModel(height: height)
        viewController?.setupKeyBoard(viewModel: viewModel)
    }
}

extension HeightPresenter {}


