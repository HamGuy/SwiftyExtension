//
//  JKTapActionLabelViewController.swift
//  SwiftyExtension_Example
//
//  Created by IronMan on 2021/1/8.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class JKTapActionLabelViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        headDataArray = ["一、基本的使用"]
        dataArray = [["设置可点击的label"]]
    }
}

// MARK: - 一、基本的工具
extension JKTapActionLabelViewController {
    
    // MARK: 1.01、设置可点击的label
    @objc func test101() {
    
        let label = JKTapActionLabel()
        label.frame = CGRect(x: 50, y: 100, width: 200, height: 200)
        label.backgroundColor = UIColor.randomColor
        let sumMutableString = NSMutableAttributedString(string: "我是我是我是我是我是我是是是一只 和 ")
        let paraStyle = NSMutableParagraphStyle()
        // 右对齐
        paraStyle.alignment = .left
        sumMutableString.setAttributes([.paragraphStyle: paraStyle], range: NSRange(location: 0, length: sumMutableString.length))
        var sumDic: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 14)]
        sumDic.updateValue(UIColor.yellow, forKey: .foregroundColor)
        sumMutableString.addAttributes(sumDic, range: NSRange(location: 0, length: sumMutableString.length))
        
        let subString = NSMutableAttributedString(string: "复制")
        var paraDic: [NSAttributedString.Key: Any] = [.font : UIFont.systemFont(ofSize: 14)]
        paraDic.updateValue(UIColor.green, forKey: .foregroundColor)
        subString.setAttributes(paraDic, range: NSRange(location: 0, length: subString.length))
        sumMutableString.append(subString)
        
        
        label.setText(sumMutableString)
        label.tap(string: "复制") {
            // "复制成功".toast()
            JKPrint("点击了：复制")
        }
        
        label.tap(string: "一只") {
            // "复制成功".toast()
            JKPrint("点击了：一只")
        }
        self.view.addSubview(label)
    }
}
