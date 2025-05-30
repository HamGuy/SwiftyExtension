//
//  UINavigationControllerExtensionViewController.swift
//  SwiftyExtension_Example
//
//  Created by IronMan on 2020/11/11.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class UINavigationControllerExtensionViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headDataArray = ["一、基本的扩展"]
        dataArray = [["pop返回后再push进某个控制器", "往前返回(Pop)几个控制器", "往前返回(Pop)几个控制器 后 push进某个控制器", "pop 到某个vc，以传入的vc类型为准，从栈顶逐个便利，直到找到这个vc，如果遍历完成后没找到，则返回false"]]
    }
}

// MARK: - 一、基本的扩展
extension UINavigationControllerExtensionViewController {
    
    // MARK: 1.04、pop 到某个vc，以传入的vc类型为准，从栈顶逐个便利，直到找到这个vc，如果遍历完成后没找到，则返回false
    @objc func test104() {
        self.navigationController?.jk.popToViewController(as: ViewController.self, animated: true)
    }
    
    // MARK: 1.03、往前返回(Pop)几个控制器 后 push进某个控制器
    @objc func test103() {
        self.navigationController?.jk.pop(count: 2, andPush: UITableViewExtensionViewController(), animated: true)
    }

    // MARK: 1.02、往前返回(Pop)几个控制器
    @objc func test102() {
        self.navigationController?.jk.pop(count: 2, animated: true)
    }
    
    // MARK: 1.01、pop返回后再push进某个控制器
    @objc func test101() {
        self.navigationController?.jk.popCurrentAndPush(vc: OneViewController(), animated: true)
    }
}

