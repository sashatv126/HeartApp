//
//  ViewController.swift
//  TestHelpfullIdea
//
//  Created by Александр Александрович on 05.08.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let cp = ProgressView(frame: CGRect(x: 100, y: 100, width: 300, height: 300))
        cp.trackColor = UIColor.red
        cp.progressColor = UIColor.yellow
        cp.value = 0.8
        view.backgroundColor = .blue
        self.view.addSubview(cp)
        cp.center = view.center
    }


}

