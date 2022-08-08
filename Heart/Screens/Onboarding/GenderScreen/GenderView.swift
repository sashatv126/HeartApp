//
//  GenderView.swift
//  Heart
//
//  Created by Александр Александрович on 28.07.2022.
//

import UIKit
import Stevia

protocol GenderDisplayLogic: AnyObject {
    func initialSetup(viewModel: GenderModel.Start.ViewModel)
    func selectItem(viewModel: GenderModel.Route.ViewModel)
}

final class GenderViewController: UIViewController {
    //MARK: - Public Properties
    
    var interactor : GenderLogic!
    var router : (GenderDataPassing & GenderRoutingLogic)!
    
    //MARK: - Private Properties
    private let genderLalbel = SceenLabel(frame: .zero, text: Text.gender)
    private lazy var collectionView : UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.dataSource = self
        collection.delegate = self
        GenderCell.registerWithoutNib(for: collection)
        return collection
    }()
    
    private var sections: [GenderModel.Section] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.viewIsReady(request : GenderModel.Start.Request())
    }
}

extension GenderViewController: GenderDisplayLogic {
    func selectItem(viewModel: GenderModel.Route.ViewModel) {
        router.route()
    }
    
    func initialSetup(viewModel: GenderModel.Start.ViewModel) {
        self.sections = viewModel.sections
        collectionView.reloadData()
        setupView()
    }
}

extension GenderViewController {
    private func setupView() {
        view.backgroundColor = .white
        title = "Gender"
        
        view.subviews(collectionView, genderLalbel)
        
        genderLalbel
            .top(113)
            .height(29)
            .CenterX == view.CenterX
        
        collectionView
            .Top == genderLalbel.Bottom + 100
        collectionView
            .height(320)
        collectionView
            .left(16)
            .right(16)
    }
}

extension GenderViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 68)
    }
}
 
extension GenderViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = sections[safe: indexPath.section],
              let item = section.items[safe: indexPath.row] else {
            return UICollectionViewCell()
        }
        
        switch item {
        case .gender(let viewModel):
            let cell = GenderCell.dequeue(collectionView, for: indexPath)
            cell.configureWith(viewModel: viewModel)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let section = sections[safe: indexPath.section],
              let item = section.items[safe: indexPath.row] else {
            return
        }
        switch item {
        case .gender(_):
            collectionView.deselectItem(at: indexPath, animated: true)
            interactor.buttonContinueTap(request: GenderModel.Route.Request())
        }
    }
}
