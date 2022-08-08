//
//  MainPresenter.swift
//  Heart
//
//  Created by Александр Александрович on 04.08.2022.
//

import Foundation
import UIKit

protocol MainPresenterLogic {
    func displayPresentation(response: MainModel.Start.Response)
    func displayPresentationCell(response: MainModel.Interact.Response)
    func displayPulse(response: MainModel.Update.Response)
    func displayResultsOfPusle(response: MainModel.Result.Response)
}

final class MainPresenter {
    weak var viewController: MainDisplayLogic?
}

extension MainPresenter: MainPresenterLogic {
    func displayResultsOfPusle(response: MainModel.Result.Response) {
        let arr = response.pulse
        let sections = createSections(text: nil, results: arr)
        let viewModel = MainModel.Result.ViewModel(sections: sections)
        viewController?.cellFinished(viewModel: viewModel)
    }
    
    func displayPulse(response: MainModel.Update.Response) {
        let pulse = response.pulse
        let sections = createSections(text: pulse, results: nil)
        let viewModel = MainModel.Update.ViewModel(sections: sections)
        viewController?.cellIsSelected(viewModel: viewModel)
    }
    
    func displayPresentationCell(response: MainModel.Interact.Response) {
        let viewModel = MainModel.Interact.ViewModel()
        viewController?.cellTapped(viewModel: viewModel)
    }
    
    func displayPresentation(response: MainModel.Start.Response) {
        let sections = createSections(text: nil, results: nil)
        let viewModel = MainModel.Start.ViewModel(sections: sections)
        viewController?.initialSetup(viewModel: viewModel)
    }
}

extension MainPresenter {
    private func createSections(text: String?, results: [String]?) -> [MainModel.Section] {
        var sections: [MainModel.Section] = []
        sections.append(createHorizontalDescriptionSection())
        sections.append(createBigHeartSection(text: text))
        sections.append(createYourPulseSection(results: results))
        sections.append(createSleepTimeSection())
        sections.append(createStepsGoalSection())
        return sections
    }
    
    private func createHorizontalDescriptionSection() -> MainModel.Section {
        let items: [MainModel.ItemType] = MainPresenter.horizontalDescriptionCellModel.map {
            .horizontalDescriptionItem($0)
        }
        return .init(type: .horizontalDescription,
                     items: items)
    }
    
    private func createBigHeartSection(text: String?) -> MainModel.Section {
        let items: [MainModel.ItemType] = [MainModel.ItemType.bigHeart(MainPresenter.bigHeartModelCellModel(text: text))]
        return .init(type: .bigHeart,
                     items: items)
    }
    
    private func createYourPulseSection(results: [String]?) -> MainModel.Section {
        let items: [MainModel.ItemType] = MainPresenter.yourPulseCellModel(arr: results).map {
            .yourPulse($0)
        }
        return .init(type: .yourPulse,
                     items: items)
    }
    
    private func createSleepTimeSection() -> MainModel.Section {
        let items: [MainModel.ItemType] = MainPresenter.sleepTimeCellModel.map {
            .sleepTime($0)
        }
        return .init(type: .sleepTime,
                     items: items)
    }
    
    private func createStepsGoalSection() -> MainModel.Section {
        let items: [MainModel.ItemType] = [MainModel.ItemType.stepsGoal(MainPresenter.stepsGoalCellModel)]
        return .init(type: .stepsGoal,
                     items: items)
    }
}

// MARK: - Mock Data
extension MainPresenter {
    static var horizontalDescriptionCellModel: [HorizontalDescriptionCellViewModel] {
        return [
            HorizontalDescriptionCellViewModel(image: "blood_pressure".image,
                                               title: "Blood pressure",
                                               color: UIColor(red: 83/255, green: 177/255, blue: 121/255, alpha: 1)),
            HorizontalDescriptionCellViewModel(image: "Oxygen".image,
                                               title: "Oxygen",
                                               color: UIColor(red: 61/255, green: 141/255, blue: 216/255, alpha: 1)),
            HorizontalDescriptionCellViewModel(image: "heart_rate".image,
                                               title: "Heart rate",
                                               color: UIColor(red: 255/255, green: 95/255, blue: 114/255, alpha: 1)),
        ]
    }
    
    static func bigHeartModelCellModel(text: String?) -> BigHeartCellViewModel {
        return .init(image: "big_heart_ic".image, text: text)
    }
    
    static func yourPulseCellModel(arr: [String]?) -> [YourPulseCellViewModel] {
        return [
            YourPulseCellViewModel(title: "Average",
                                   numderTitle: arr?[safe: 0]),
            YourPulseCellViewModel(title: "Maximum",
                                   numderTitle: arr?[safe: 1]),
            YourPulseCellViewModel(title: "Today",
                                   numderTitle: arr?[safe: 0])
        ]
    }
    
    static var sleepTimeCellModel: [SleepTimeCellViewModel] {
        return [
            SleepTimeCellViewModel(title: "Beedtime",
                                   image: "bed_ic".image,
                                   color: UIColor(red: 6/255, green: 189/255, blue: 189/255, alpha: 1),
                                   clockTitle: "23:00"),
            SleepTimeCellViewModel(title: "Alarm",
                                   image: "clock_ic".image,
                                   color:  UIColor(red: 149/255, green: 38/255, blue: 201/255, alpha: 1),
                                   clockTitle: "7:00"),
            SleepTimeCellViewModel(title: "Average time in bed",
                                   image: "blue_clock_ic".image,
                                   color:  UIColor(red: 59/255, green: 84/255, blue: 216/255, alpha: 1),
                                   clockTitle: "7h 44min"),
        ]
    }
    
    static var stepsGoalCellModel: StepsGoalCellViewModel {
        .init(steps: "4000/7000 steps")
    }
}
