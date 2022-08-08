//
//  GenderPresenter.swift
//  Heart
//
//  Created by Александр Александрович on 28.07.2022.
//

import Foundation

protocol WeightPresenterLogic {
    func displayPresentation(response: WeightModel.Start.Response)
    func displayAppear(response: WeightModel.Appear.Response)
    func displayDisappear(response: WeightModel.Disappear.Response)
    func displaySegmentChange(response: WeightModel.Change.Response)
    func displayKeyboard(response: WeightModel.Keyboard.Response)
    func displayRoute(response: WeightModel.Route.Response)
}

final class WeightPresenter {
    // MARK: - Public Properties

    weak var viewController: WeightDisplayLogic?

    // MARK: - Private Properties

}

extension WeightPresenter : WeightPresenterLogic {
    func displayAppear(response: WeightModel.Appear.Response) {
        let viewModel = WeightModel.Appear.ViewModel()
        viewController?.viewWillAppear(viewModel: viewModel)
    }
    
    func displayDisappear(response: WeightModel.Disappear.Response) {
        let viewModel = WeightModel.Disappear.ViewModel()
        viewController?.viewWillDisappear(viewModel: viewModel)
    }
    
    func displayRoute(response: WeightModel.Route.Response) {
        let viewModel = WeightModel.Route.ViewModel()
        viewController?.buttonTap(viewModel: viewModel)
    }
    
    func displayPresentation(response: WeightModel.Start.Response) {
        let viewModel = WeightModel.Start.ViewModel()
        viewController?.initialSetup(viewModel: viewModel)
    }
    
    func displaySegmentChange(response: WeightModel.Change.Response) {
        let index = response.index
        let viewModel = WeightModel.Change.ViewModel(index: index)
        viewController?.setupChanges(viewModel: viewModel)
    }
    
    func displayKeyboard(response: WeightModel.Keyboard.Response) {
        let height = response.height
        let viewModel = WeightModel.Keyboard.ViewModel(height: height)
        viewController?.setupKeyBoard(viewModel: viewModel)
    }
}

extension WeightPresenter {}


