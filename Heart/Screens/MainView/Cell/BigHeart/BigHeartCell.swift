//
//  BigHeartCell.swift
//  Heart
//
//  Created by Александр Александрович on 04.08.2022.
//

import UIKit
import Stevia

protocol BigHeartCellInteract {
    func buttonTap(duration: Double)
    func finish()
}

final class BigHeartCell: UICollectionViewCell {
    var delegate: BigHeartCellInteract?
    private var flag: Bool = true
    private var progressBar = ProgressView(frame: CGRect(x: 0, y: 0, width: 296, height: 296))
    private var countFired: CGFloat = 0
    private var duration = Double.random(in: 15...20)
    private var timer = Timer()
    var dispatchItem: DispatchWorkItem?
    
    override var isSelected: Bool {
        didSet {
            progress()
        }
    }
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let imageViewAnimate: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.image = "heart".image
        imageView.tintColor = .blue
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let tapLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.text = Text.measure.uppercased()
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    private let bpmLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = Color.borderGray
        label.text = Text.tapToMeasure
        return label
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.alignment = .center
        stack.distribution = .equalCentering
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    override func layoutSubviews() {
        progressBar.center = imageView.center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureWith(viewModel: BigHeartCellViewModel) {
        imageView.image = viewModel.image
        guard let text = viewModel.text else { return }
        if Int(text) != nil {
            configure()
        }
        if text == Text.wait.uppercased() {
            configureInProgress()
        }
        tapLabel.text = text
    }
    
    private func getPulse() {
        delegate?.buttonTap(duration: self.duration)
    }
    
    private func getData() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            self.dispatchItem?.cancel()
            let item = DispatchWorkItem(block: { [weak self] in
                guard let self = self else { return }
                self.getPulse()
                self.getData()
            })
            self.dispatchItem = item
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: item)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + self.duration + 1) {[weak self] in
            self?.configureAfter()
        }
    }
    
    private func progress() {
        DispatchQueue.main.async {
            if self.flag {
                if self.isSelected {
                    self.getData()
                }
                self.progressBar.duration = self.duration
                self.progressBar.value = 1
                self.flag = !self.flag
            }
        }
    }
    
    private func configureAfter() {
        dispatchItem?.cancel()
        isSelected = false
        tapLabel.text = Text.nice.uppercased()
        tapLabel.font = Font.normal
        bpmLabel.text = Text.check
        bpmLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        delegate?.finish()
    }
    
    private func configure() {
        bpmLabel.font = Font.normal
        bpmLabel.textColor = .white
        bpmLabel.text = Text.bpm.uppercased()
        tapLabel.font = UIFont.systemFont(ofSize: 48, weight: .bold)
    }
    
    private func configureInProgress() {
        tapLabel.font = Font.normal
        bpmLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        bpmLabel.text = Text.measuerInProgress
    }
}

extension BigHeartCell {
    private func setupUI() {
        contentView.subviews(imageView,progressBar,imageViewAnimate,stackView)
        contentView.backgroundColor = UIColor(red: 247/255, green: 249/255, blue: 252/255, alpha: 1)
        contentView.layer.cornerRadius = 16
        progressBar.trackColor = UIColor.clear
        progressBar.progressColor = Color.pink!
        
        stackView.addArrangedSubview(tapLabel)
        stackView.addArrangedSubview(bpmLabel)
        
        imageView
            .top(32)
            .bottom(32)
            .height(296)
            .width(296)
        
        imageView
            .CenterX == contentView.CenterX
        
        imageViewAnimate
            .height(190)
            .width(200)
        
        imageViewAnimate
            .CenterX == contentView.CenterX
        
        imageViewAnimate
            .CenterY == contentView.CenterY
        
        stackView
            .CenterX == contentView.CenterX
        
        stackView
            .CenterY == contentView.CenterY
    }
}
