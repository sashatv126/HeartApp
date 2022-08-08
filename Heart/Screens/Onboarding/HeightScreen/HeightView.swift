//
//  HeightView.swift
//  Heart
//
//  Created by Александр Александрович on 02.08.2022.
//

import Foundation
import UIKit
import Stevia

protocol HeightDisplayLogic: AnyObject {
    func initialSetup(viewModel: HeightModel.Start.ViewModel)
    func viewWillAppear(viewModel: HeightModel.Appear.ViewModel)
    func viewWillDisappear(viewModel: HeightModel.Disappear.ViewModel)
    func setupChanges(viewModel: HeightModel.Change.ViewModel)
    func setupKeyBoard(viewModel: HeightModel.Keyboard.ViewModel)
    func buttonTap(viewModel: HeightModel.Route.ViewModel)
}

final class HeightViewController: UIViewController {
    var interactor : HeightLogic!
    var router : (HeightDataPassing & HeightRoutingLogic)!
    
    private let genderLalbel = SceenLabel(frame: .zero, text: Text.height)
    private let segmentControll = CustomSegmentedControl(frame: .zero, type: .height)
    private var textField = OTPStackView(frame: .zero, numberOfFields: 3, style: .cm)
    private let nextButton = UIButton(title: Text.next)
    private let notify = NotificationCenter.default
    private var height: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.viewIsReady(request: HeightModel.Start.Request())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor.viewWillAppear(request: HeightModel.Appear.Request())
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        interactor.viewWillDissapear(request: HeightModel.Disappear.Request())
    }
    
    private func createTextField(index : Int) {
        textField.removeFromSuperview()
        if index == 0 {
            textField = OTPStackView(frame: .zero, numberOfFields: 3, style: .cm)
        } else {
            textField = OTPStackView(frame: .zero, numberOfFields: 2, style: .inch)
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

extension HeightViewController: HeightDisplayLogic {
    func viewWillAppear(viewModel: HeightModel.Appear.ViewModel) {
        view.subviews(nextButton)
        nextButton
            .left(16)
            .right(16)
            .height(52)
            .bottom(50)
        nextButton
            .CenterX == view.CenterX
    }
    
    func viewWillDisappear(viewModel: HeightModel.Disappear.ViewModel) {
        if view.contains(nextButton) {
            nextButton.removeFromSuperview()
        }
    }
    
    func buttonTap(viewModel: HeightModel.Route.ViewModel) {
        router.route()
    }
    
    func initialSetup(viewModel: HeightModel.Start.ViewModel) {
        setupNotification()
        setupView()
    }
    
    func setupChanges(viewModel: HeightModel.Change.ViewModel) {
        if view.contains(nextButton) {
            nextButton.removeFromSuperview()
        }
        let index = viewModel.index
        print(index)
        createTextField(index: index)
    }
    
    func setupKeyBoard(viewModel: HeightModel.Keyboard.ViewModel) {
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

extension HeightViewController {
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
        interactor.buttonContinueTap(request: HeightModel.Route.Request())
    }
    
    @objc
    private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight : Int = Int(keyboardSize.height)
            let request = HeightModel.Keyboard.Request(height: keyboardHeight)
            interactor.keyboardWillShow(request: request)
        }
    }
}

extension HeightViewController: CustomSegmentedControlDelegate {
    func change(to index: Int) {
        let request = HeightModel.Change.Request(index: index)
        interactor.segmentValueIsChanged(request: request)
    }
}

extension HeightViewController: OTPDelegate {
    func didChangeValidity(isValid: Bool) {
        if isValid {
            print("СРАБОТАЛО")
            interactor.keyboardWillShow(request: HeightModel.Keyboard.Request(height: nil))
        } else {
            if view.contains(nextButton) {
                nextButton.removeFromSuperview()
            }
        }
    }
}
