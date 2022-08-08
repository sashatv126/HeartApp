//
//  HeightView.swift
//  Heart
//
//  Created by Александр Александрович on 02.08.2022.
//

import Foundation
import UIKit
import Stevia

protocol WeightDisplayLogic: AnyObject {
    func initialSetup(viewModel: WeightModel.Start.ViewModel)
    func viewWillAppear(viewModel: WeightModel.Appear.ViewModel)
    func viewWillDisappear(viewModel: WeightModel.Disappear.ViewModel)
    func setupChanges(viewModel: WeightModel.Change.ViewModel)
    func setupKeyBoard(viewModel: WeightModel.Keyboard.ViewModel)
    func buttonTap(viewModel: WeightModel.Route.ViewModel)
}

final class WeightViewController: UIViewController {
    var interactor : WeightLogic!
    var router : (WeightDataPassing & WeightRoutingLogic)!
    
    private let genderLalbel = SceenLabel(frame: .zero, text: Text.weight)
    private let segmentControll = CustomSegmentedControl(frame: .zero, type: .weight)
    private var textField = OTPStackView(frame: .zero, numberOfFields: 2, style: .kg)
    private let nextButton = UIButton(title: Text.next)
    private let notify = NotificationCenter.default
    private var height: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.viewIsReady(request: WeightModel.Start.Request())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor.viewWillAppear(request: WeightModel.Appear.Request())
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        interactor.viewWillDissapear(request: WeightModel.Disappear.Request())
    }
    
    private func createTextField(index : Int) {
        textField.removeFromSuperview()
        if index == 0 {
            textField = OTPStackView(frame: .zero, numberOfFields: 2, style: .kg)
        } else {
            textField = OTPStackView(frame: .zero, numberOfFields: 2, style: .lb)
        }
        textField.delegate = self
        
        view.subviews(textField)
        
        textField
            .CenterX == view.CenterX
        textField
            .Top == segmentControll.Bottom + 64
        textField
            .height(80)
    }
}

extension WeightViewController: WeightDisplayLogic {
    func viewWillAppear(viewModel: WeightModel.Appear.ViewModel) {
        view.subviews(nextButton)
        nextButton
            .left(16)
            .right(16)
            .height(52)
            .bottom(50)
        nextButton
            .CenterX == view.CenterX
    }
    
    func viewWillDisappear(viewModel: WeightModel.Disappear.ViewModel) {
        if view.contains(nextButton) {
            nextButton.removeFromSuperview()
        }
    }
    
    func buttonTap(viewModel: WeightModel.Route.ViewModel) {
        router.route()
    }
    
    func initialSetup(viewModel: WeightModel.Start.ViewModel) {
        setupNotification()
        setupView()
    }
    
    func setupChanges(viewModel: WeightModel.Change.ViewModel) {
        if view.contains(nextButton) {
            nextButton.removeFromSuperview()
        }
        let index = viewModel.index
        print(index)
        createTextField(index: index)
    }
    
    func setupKeyBoard(viewModel: WeightModel.Keyboard.ViewModel) {
        if viewModel.height != nil {
            height = viewModel.height
        } else {
            guard let height = height else { return }
            
            view.subviews(nextButton)
            
            nextButton
                .CenterX == view.CenterX
            nextButton
                .Bottom == height + 16
            nextButton
                .left(16)
                .right(16)
                .height(52)
        }
    }
}

extension WeightViewController {
    private func setupView() {
        nextButton.addTarget(self, action: #selector(tabToContinue), for: .touchUpInside)
        segmentControll.delegate = self
        textField.delegate = self
        view.backgroundColor = .white
        title = "Height"
        
        view.subviews(genderLalbel,segmentControll,textField)
        
        genderLalbel
            .top(113)
            .height(29)
            .CenterX == view.CenterX
        
        segmentControll
            .height(50)
            .left(116)
            .right(113)
            .Top == genderLalbel.Bottom + 42
        
        textField
            .CenterX == view.CenterX
        textField
            .Top == segmentControll.Bottom + 64
        textField
            .height(80)
    }
    
    private func setupNotification() {
        notify.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc
    private func tabToContinue(_ button: UIButton) {
        interactor.buttonContinueTap(request: WeightModel.Route.Request())
    }
    
    @objc
    private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight : Int = Int(keyboardSize.height)
            let request = WeightModel.Keyboard.Request(height: keyboardHeight)
            interactor.keyboardWillShow(request: request)
        }
    }
}

extension WeightViewController: CustomSegmentedControlDelegate {
    func change(to index: Int) {
        let request = WeightModel.Change.Request(index: index)
        interactor.segmentValueIsChanged(request: request)
    }
}

extension WeightViewController: OTPDelegate {
    func didChangeValidity(isValid: Bool) {
        if isValid {
            interactor.keyboardWillShow(request: WeightModel.Keyboard.Request(height: nil))
        } else {
            if view.contains(nextButton) {
                nextButton.removeFromSuperview()
            }
        }
    }
}
