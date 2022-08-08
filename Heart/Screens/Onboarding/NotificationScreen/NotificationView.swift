//
//  NotificationView.swift
//  Heart
//
//  Created by Александр Александрович on 03.08.2022.
//

import Foundation
import UIKit
import Stevia

protocol NotificationDisplayLogic: AnyObject {
    func initialSetup(viewModel: NotificationModel.Start.ViewModel)
    func tapButtonAllow(viewModel: NotificationModel.Route.ViewModel)
}

final class NotificationViewController: UIViewController {
    //MARK: - Public Properties
    
    var interactor : NotificationLogic!
    var router : (NotificationDataPassing & NotificationRoutingLogic)!
    
    //MARK: - Private Properties
    
    private var boldLabel: UILabel!
    private var textLabel: UILabel!
    private let nextButton = UIButton(title: Text.allow)
    private let viewWithPulse = WePulseView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.viewIsReady(request : NotificationModel.Start.Request())
    }
    
    // MARK: - Public Methods

    // MARK: - Private Methods

    // MARK: - UI Actions
    @objc
    private func buttonTap() {
        interactor.viewIsInteract(request: NotificationModel.Route.Request())
    }
}

extension NotificationViewController: NotificationDisplayLogic {
    func tapButtonAllow(viewModel: NotificationModel.Route.ViewModel) {
        router.route()
    }
    
    func initialSetup(viewModel: NotificationModel.Start.ViewModel) {
        setupView()
    }
}

extension NotificationViewController {
    private func setupView() {
        nextButton.addTarget(nil, action: #selector(buttonTap), for: .touchUpInside)
        boldLabel = UILabel()
        boldLabel.textColor = Color.blackSegment
        boldLabel.textAlignment = .center
        boldLabel.font = Font.labelText
        boldLabel.text = Text.miss
        textLabel = UILabel()
        textLabel.textColor = Color.gray
        textLabel.font = Font.mid
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 0
        textLabel.text = Text.textLast
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.addArrangedSubview(boldLabel)
        stackView.addArrangedSubview(textLabel)
        
        view.subviews(stackView,nextButton,viewWithPulse)
        
        nextButton
            .left(16)
            .right(16)
            .height(52)
            .bottom(50)
        nextButton
            .CenterX == view.CenterX
        
        stackView
            .CenterX == view.CenterX
        stackView
            .left(16)
            .right(16)
            .bottom(339)
        
        viewWithPulse
            .CenterX == view.CenterX
        viewWithPulse
            .Bottom == stackView.Top - 14
        viewWithPulse
            .top(266)
        
        view.backgroundColor = .white
        title = "Notification"
    }
}
