//
//  MainView.swift
//  Heart
//
//  Created by Александр Александрович on 04.08.2022.
//

import UIKit
import Stevia

protocol MainDisplayLogic: AnyObject {
    func initialSetup(viewModel: MainModel.Start.ViewModel)
    func cellTapped(viewModel: MainModel.Interact.ViewModel)
    func cellIsSelected(viewModel: MainModel.Update.ViewModel)
    func cellFinished(viewModel: MainModel.Result.ViewModel)
}

final class MainViewController: UIViewController {
    // MARK: - Public Properties

    var interactor: MainLogic?
    var router: (MainRoutingLogic & MainDataPassing)?

    // MARK: - Private Properties
    var flag: Bool = true
    var bool: Bool = true
    private lazy var collectionV: UICollectionView = {
        let collectionViewLayout = MainCollectionLayoutBuilder.createLayout(sections: sections)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        HorizontalDescriptionCell.registerWithoutNib(for: collectionView)
        BigHeartCell.registerWithoutNib(for: collectionView)
        YourPulseCell.registerWithoutNib(for: collectionView)
        SleepTimeCell.registerWithoutNib(for: collectionView)
        StepsGoalCell.registerWithoutNib(for: collectionView)
        
        YourPulseHeaderView.registerWithoutNib(for: collectionView,
                                                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader)
        TitleHeaderView.registerWithoutNib(for: collectionView,
                                                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader)
       
        
        return collectionView
    }()
    
    private var sections: [MainModel.Section] = []

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.viewIsReady(request: MainModel.Start.Request())
    }
}

// MARK: - Display Logic

extension MainViewController: MainDisplayLogic {
    func cellFinished(viewModel: MainModel.Result.ViewModel) {
        if bool {
            self.sections = viewModel.sections
            DispatchQueue.main.async {
                self.collectionV.reloadData()
            }
            bool = !bool
        }
    }
    
    func cellIsSelected(viewModel: MainModel.Update.ViewModel) {
        self.sections = viewModel.sections
        collectionV.reloadData()
    }
    
    func cellTapped(viewModel: MainModel.Interact.ViewModel) {
    }
    
    func initialSetup(viewModel: MainModel.Start.ViewModel) {
        self.sections = viewModel.sections
        collectionV.reloadData()
        setupUI()
    }
}

extension MainViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[safe: section]?.items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = sections[safe: indexPath.section],
              let item = section.items[safe: indexPath.row] else {
            return UICollectionViewCell()
        }
        
        switch item {
        case .horizontalDescriptionItem(let viewModel):
            let cell = HorizontalDescriptionCell.dequeue(collectionV, for: indexPath)
            
            cell.configureWith(viewModel: viewModel)
            return cell
        case .bigHeart(let viewModel):
            let cell = BigHeartCell.dequeue(collectionV, for: indexPath)
            cell.delegate = self
            cell.configureWith(viewModel: viewModel)
            return cell
        case .yourPulse(let viewModel):
            let cell = YourPulseCell.dequeue(collectionV, for: indexPath)
            cell.configureWith(viewModel: viewModel)
            return cell
        case .sleepTime(let viewModel):
            let cell = SleepTimeCell.dequeue(collectionV, for: indexPath)
            cell.configureWith(viewModel: viewModel)
            return cell
        case .stepsGoal(let viewModel):
            let cell = StepsGoalCell.dequeue(collectionV, for: indexPath)
            cell.configureWith(viewModel: viewModel)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let section = sections[safe: indexPath.section] else {
            return UICollectionReusableView()
        }

        switch section.type {
        case .horizontalDescription,
             .bigHeart:
            let header = YourPulseHeaderView.dequeue(collectionV, ofKind: kind, for: indexPath)
            header.configure(title: section.headerTitle)
            return header
        case .yourPulse:
            let header = YourPulseHeaderView.dequeue(collectionV, ofKind: kind, for: indexPath)
            header.configure(title: section.headerTitle)
            return header
        case .stepsGoal:
            let header = TitleHeaderView.dequeue(collectionV, ofKind: kind, for: indexPath)
            header.configure(title: section.headerTitle)
            return header
        case .sleepTime:
            let header = TitleHeaderView.dequeue(collectionV, ofKind: kind, for: indexPath)
            header.configure(title: section.headerTitle)
            return header
        }
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let section = sections[safe: indexPath.section],
              let item = section.items[safe: indexPath.row] else {
            return
        }
        switch item {
        case .bigHeart(_):
            if flag {
                interactor?.cellIsReady(request: MainModel.Interact.Request())
                flag = !flag
            }
        default:
            break
        }
    }
}

extension MainViewController: BigHeartCellInteract {
    func finish() {
        interactor?.cellIsFinished(request: MainModel.Result.Request())
    }
    
    func buttonTap(duration: Double) {
        interactor?.cellIsSelected(request: MainModel.Update.Request(duration: duration))
    }
}

// MARK: - Private methods
extension MainViewController {
    private func setupUI() {
        title = "Health"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        
        view.subviews(collectionV)
        collectionV
            .top(0)
            .left(8)
            .right(8)
            .bottom(8)
    }
}

