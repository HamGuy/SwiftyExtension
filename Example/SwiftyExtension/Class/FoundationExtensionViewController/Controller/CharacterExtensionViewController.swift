//
//  CharacterExtensionViewController.swift
//  SwiftyExtension_Example
//
//  Created by IronMan on 2020/11/3.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class CharacterExtensionViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        headDataArray = ["一、Character 与其他类型的转换", "二、常用的属性和方法"]
        dataArray = [["Character 转 String", "Character 转 Int"], ["判断是不是 Emoji 表情"]]
    }
}

// MARK: - 二、常用的属性和方法
extension CharacterExtensionViewController {
    
    // MARK: 2.01、判断是不是 Emoji 表情
    @objc func test201() {
        let emoji: Character = "🙃"
        JKPrint("判断是不是 Emoji 表情", "\(emoji) 是不是emoji表情：\(emoji.jk.isEmoji)")
    }
}

// MARK: - 一、Character 与其他类型的转换
extension CharacterExtensionViewController {
    
    // MARK: 1.02、Character 转 Int
    @objc func test102() {
        let charater: Character = "f"
        JKPrint("Character 转 Int", "\(charater) 转 Int 后为 \(charater.jk.charToInt ?? 0)")
    }
    
    // MARK: 1.01、Character 转 String
    @objc func test101() {
        let charater: Character = "a"
        JKPrint("Character 转 String", "\(charater) 转 String 后为 \(charater.jk.charToString)")
    }
}

