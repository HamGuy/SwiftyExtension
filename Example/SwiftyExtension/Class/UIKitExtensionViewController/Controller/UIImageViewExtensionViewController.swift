//
//  UIImageViewExtensionViewController.swift
//  SwiftyExtension_Example
//
//  Created by IronMan on 2020/11/16.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class UIImageViewExtensionViewController: BaseViewController {
    var gifImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headDataArray = ["一、加载 gif"]
        dataArray = [["加载本地的gif图片", "加载 asset 里面的图片", "加载网络 url 的 gif 图片"]]
    }
}

// MARK: - 一、加载 gif
extension UIImageViewExtensionViewController {
    // MARK: 1.03、加载网络 url 的 gif 图片
    @objc func test103() {
        gifImageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 100, height: 100))
        gifImageView.jk.loadGif(url: "http://qq.yh31.com/tp/zjbq/201711092144541829.gif")
        gifImageView.jk.centerX = self.view.jk.centerX
        self.view.addSubview(gifImageView)
        JKAsyncs.asyncDelay(5) {
        } _: {[weak self] in
            guard let weakSelf = self else { return }
            weakSelf.gifImageView.removeFromSuperview()
        }
    }
    
    // MARK: 1.02、加载 asset 里面的图片
    @objc func test102() {
        guard let image = UIImage.jk.gif(asset: "pika3") else {
            return
        }
        gifImageView = UIImageView(frame: CGRect(x: 0, y: 150, width: image.size.width, height: image.size.height))
        gifImageView.jk.loadGif(asset: "pika3")
        gifImageView.jk.centerX = self.view.jk.centerX
        self.view.addSubview(gifImageView)
        JKAsyncs.asyncDelay(5) {
        } _: {[weak self] in
            guard let weakSelf = self else { return }
            weakSelf.gifImageView.removeFromSuperview()
        }
    }
    
    // MARK: 1.01、加载本地的gif图片
    @objc func test101() {
      
        gifImageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 100, height: 100))
        gifImageView.jk.loadGif(name: "pika2")
        gifImageView.jk.centerX = self.view.jk.centerX
        self.view.addSubview(gifImageView)
        JKAsyncs.asyncDelay(5) {
        } _: {[weak self] in
            guard let weakSelf = self else { return }
            weakSelf.gifImageView.removeFromSuperview()
        }
    }
}
