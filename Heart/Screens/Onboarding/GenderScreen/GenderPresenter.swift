//
//  GenderPresenter.swift
//  Heart
//
//  Created by Александр Александрович on 28.07.2022.
//

import Foundation

protocol GenderPresenterLogic {
    func displayPresentation(response: GenderModel.Start.Response)
    func displayRoute(response: GenderModel.Route.Response)
}

final class GenderPresenter {
    // MARK: - Public Properties

    weak var viewController: GenderDisplayLogic?

    // MARK: - Private Properties

}

extension GenderPresenter: GenderPresenterLogic {
    func displayRoute(response: GenderModel.Route.Response) {
        let viewModel = GenderModel.Route.ViewModel()
        viewController?.selectItem(viewModel: viewModel)
    }
    
    func displayPresentation(response: GenderModel.Start.Response) {
        let sections = createSections()
        let viewModel = GenderModel.Start.ViewModel(sections: sections)
        viewController?.initialSetup(viewModel: viewModel)
    }
}

extension GenderPresenter {
    private func createSections() -> [GenderModel.Section] {
        var sections: [GenderModel.Section] = []
        sections.append(createGenderSection())
        return sections
    }
    
    private func createGenderSection() -> GenderModel.Section {
        let items: [GenderModel.ItemType] = GenderPresenter.genderCellModel.map {
            .gender($0)
        }
        return .init(type: .gender,
                     items: items)
    }
}

extension GenderPresenter {
    static var genderCellModel: [GenderCellViewModel] {
        return [
            GenderCellViewModel(title: "Male"),
            GenderCellViewModel(title: "Female"),
            GenderCellViewModel(title: "Non")
        ]
    }
}
