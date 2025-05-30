//
//  FiveViewController.swift
//  SwiftyExtension_Example
//
//  Created by IronMan on 2020/11/11.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class FiveViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Five"
        self.edgesForExtendedLayout = []
        self.view.backgroundColor = UIColor.randomColor
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.navigationController?.pushViewController(SixViewController(), animated: true)
    }
}
