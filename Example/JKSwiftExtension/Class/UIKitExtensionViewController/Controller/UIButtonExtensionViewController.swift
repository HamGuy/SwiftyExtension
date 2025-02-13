//
//  UIButtonExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/11/10.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class UIButtonExtensionViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headDataArray = ["一、基本的扩展", "二、链式调用", "三、UIButton 图片 与 title 位置关系(提示：title和image要在设置布局关系之前设置)", "四、自带倒计时功能的 Button", "五、Button的基本事件", "六、Button扩大点击事件"]
        dataArray = [["创建一个带颜色的 Button", "创建一个常规的 Button", "设置背景色"], ["设置title", "设置文字颜色", "设置字体大小(UIFont)", "设置字体大小(CGFloat)", "设置字体粗体", "设置图片", "设置图片(通过Bundle加载)", "设置图片(通过Bundle加载)", "设置图片(纯颜色的图片)", "设置背景图片", "设置背景图片(通过Bundle加载)", "设置背景图片(通过Bundle加载)", "设置背景图片(纯颜色的图片)", "按钮点击的变化"], ["图片在左", "图片在右", "图片在上", "图片在下"], ["设置 Button 倒计时", "是否可以点击", "是否正在倒计时", "处于倒计时时，前缀文案，如：「再次获取」 + (xxxs)", "销毁定时器"], ["button的事件"], ["扩大UIButton的点击区域，向四周扩展25像素的点击范围"]]
        // deinit 防止崩溃
        _ = testButton
    }
    
    @objc func click() {
        testButton.countDown(9, timering: { (number) in
            debugPrint("\(number)")
        }, complete: {
            debugPrint("完成")
        }, timeringPrefix: "测试", completeText: "再来一次")
    }
    
    lazy var testButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100)).title("点击后3秒后消失", .normal).textColor(.yellow, .normal).boldFont(12)
        button.backgroundColor = .brown
        button.center = self.view.center
        button.add(self, action: #selector(click))
        return button
    }()
    
    func autolayoutWaring(isHidden: Bool) {
        UserDefaults.standard.set(!isHidden, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
    }
    
    deinit {
        debugPrint("-----deinit--------")
        if testButton.isTiming {
            testButton.invalidate()
        }
    }
}

// MARK: - 六、Button扩大点击事件
extension UIButtonExtensionViewController {
    // MARK: 6.01、扩大UIButton的点击区域，向四周扩展25像素的点击范围
    @objc func test601() {
        let testView1 = UIView()
        testView1.backgroundColor = .randomColor
        testView1.center = self.view.center
        self.view.addSubview(testView1)
        
        testView1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(150)
            make.size.equalTo(CGSize(width: 280, height: 280))
        }
        let testView2 = UIView()
        testView2.backgroundColor = .randomColor
        testView2.center = self.view.center
        testView1.addSubview(testView2)
        
        testView2.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 200, height: 200))
        }
        
        var button1 = UIButton().image(.brown).title("哈哈").jk.setImageTitleLayout(.imgLeft, spacing: 6)
        button1.backgroundColor = .randomColor
        button1.tag = 100
        button1.jk.setHandleClick { (btn) in
            guard let weakBtn = btn else { return }
            debugPrint("button的事件", "tag：\(weakBtn.tag)")
        }
        button1.jk.touchExtendInset = UIEdgeInsets(top: -50, left: -50, bottom: -50, right: -50)
        testView2.addSubview(button1)
        
        button1.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
        
        JKAsyncs.asyncDelay(10, {
        }) {
            testView1.removeFromSuperview()
            testView2.removeFromSuperview()
            button1.removeFromSuperview()
        }
    }
}

// MARK: - 五、Button的基本事件
extension UIButtonExtensionViewController {
    
    // MARK: 5.01、button的事件
    @objc func test501() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100)).image(.brown).title("哈哈").jk.setImageTitleLayout(.imgLeft, spacing: 6)
        button.backgroundColor = .randomColor
        button.center = self.view.center
        button.tag = 100
        button.jk.setHandleClick { (btn) in
            guard let weakBtn = btn else { return }
            debugPrint("button的事件", "tag：\(weakBtn.tag)")
        }
        self.view.addSubview(button)
        JKAsyncs.asyncDelay(10, {
        }) {
            button.removeFromSuperview()
        }
    }
}

// MARK: - 四、自带倒计时功能的 Button
extension UIButtonExtensionViewController {
    
    // MARK: 4.05、销毁定时器
    @objc func test405() {
        testButton.invalidate()
        debugPrint("销毁定时器")
    }
    
    // MARK: 4.04、处于倒计时时，前缀文案，如：「再次获取」 + (xxxs)
    @objc func test404() {
        guard let result = testButton.timeringPrefix else {
            debugPrint("-------nil--------")
            return
        }
        debugPrint("处于倒计时时，前缀文案：\(result)")
    }
    
    // MARK: 4.03、是否正在倒计时
    @objc func test403() {
        let result = testButton.isTiming
        debugPrint("是否正在倒计时：\(result)")
    }
    
    // MARK: 4.02、是否可以点击
    @objc func test402() {
        guard let result = testButton.reEnableCond else {
            debugPrint("-------nil--------")
            return
        }
        debugPrint("是否可以点击：\(result)")
    }
    
    // MARK: 4.01、设置 Button 倒计时
    @objc func test401() {
        self.view.addSubview(testButton)
    }
}
// MARK: - 三、UIButton 图片 与 title 位置关系
extension UIButtonExtensionViewController {
    
    // MARK: 3.04、图片在下
    @objc func test304() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100)).font(6).image(.brown, CGSize(width: 20, height: 20), .normal).title("哈哈").jk.setImageTitleLayout(.imgBottom, spacing: 6)
        button.backgroundColor = .randomColor
        button.center = self.view.center
        self.view.addSubview(button)
        JKAsyncs.asyncDelay(3, {
        }) {
            button.removeFromSuperview()
        }
    }
    
    // MARK: 3.03、图片在上
    @objc func test303() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100)).image(.brown).title("哈哈").jk.setImageTitleLayout(.imgTop, spacing: 6)
        button.backgroundColor = .randomColor
        button.center = self.view.center
        self.view.addSubview(button)
        JKAsyncs.asyncDelay(3, {
        }) {
            button.removeFromSuperview()
        }
    }
    
    // MARK: 3.02、图片在右
    @objc func test302() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100)).image(.brown).title("哈哈").jk.setImageTitleLayout(.imgRight, spacing: 6)
        button.backgroundColor = .randomColor
        button.center = self.view.center
        self.view.addSubview(button)
        JKAsyncs.asyncDelay(3, {
        }) {
            button.removeFromSuperview()
        }
    }
    
    // MARK: 3.01、图片在左
    @objc func test301() {
        let button = UIButton().image(.brown).title("收藏")
        button.backgroundColor = .brown
        button.setImage(UIImage(named: "go_favorite_selected"), for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.jk.setImageTitleLayout(.imgLeft, spacing: 6)
        self.view.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 200, height: 40))
        }
        
        JKAsyncs.asyncDelay(3, {
        }) {
            button.setTitle("我是一只小鸟", for: .normal)
            JKAsyncs.asyncDelay(3, {
            }) {
                button.removeFromSuperview()
            }
        }
    }
}

// MARK: - 二、链式调用
extension UIButtonExtensionViewController {
    
    // MARK: 2.14、按钮点击的变化
    @objc func test214() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100)).title("3秒后消失", .normal).textColor(.brown, .normal).boldFont(12).bgImage(.yellow).confirmButton()
        button.backgroundColor = .randomColor
        button.center = self.view.center
        self.view.addSubview(button)
        JKAsyncs.asyncDelay(3, {
        }) {
            button.removeFromSuperview()
        }
    }
    
    // MARK: 2.13、设置背景图片(纯颜色的图片)
    @objc func test213() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100)).title("3秒后消失", .normal).textColor(.brown, .normal).boldFont(12).bgImage(.yellow)
        button.backgroundColor = .randomColor
        button.center = self.view.center
        self.view.addSubview(button)
        JKAsyncs.asyncDelay(3, {
        }) {
            button.removeFromSuperview()
        }
    }
    
    // MARK: 2.12、设置背景图片(通过Bundle加载)
    @objc func test212() {
        guard let path = Bundle.init(for: Self.self).path(forResource: "JKBaseKit", ofType: "bundle") else {
            return
        }
        let bundle = Bundle.init(path: path)
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100)).title("3秒后消失", .normal).textColor(.yellow, .normal).boldFont(12).bgImage(in: bundle, "icon_scan", .normal)
        button.backgroundColor = .randomColor
        button.center = self.view.center
        self.view.addSubview(button)
        JKAsyncs.asyncDelay(3, {
        }) {
            button.removeFromSuperview()
        }
    }
    
    // MARK: 2.11、设置背景图片(通过Bundle加载)
    @objc func test211() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100)).title("3秒后消失", .normal).textColor(.yellow, .normal).boldFont(12).bgImage(forParent: Self.self, bundleName: "JKBaseKit", "icon_scan", .normal)
        button.backgroundColor = .randomColor
        button.center = self.view.center
        self.view.addSubview(button)
        JKAsyncs.asyncDelay(3, {
        }) {
            button.removeFromSuperview()
        }
    }
    
    // MARK: 2.10、设置背景图片
    @objc func test210() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100)).title("3秒后消失", .normal).textColor(.yellow, .normal).boldFont(12).bgImage(UIImage(named: "testicon"))
        button.backgroundColor = .randomColor
        button.center = self.view.center
        self.view.addSubview(button)
        JKAsyncs.asyncDelay(3, {
        }) {
            button.removeFromSuperview()
        }
    }
    
    // MARK: 2.09、设置图片(纯颜色的图片)
    @objc func test209() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100)).title("3秒后消失", .normal).textColor(.yellow, .normal).boldFont(12).image(UIColor.brown)
        button.backgroundColor = .randomColor
        button.center = self.view.center
        self.view.addSubview(button)
        JKAsyncs.asyncDelay(3, {
        }) {
            button.removeFromSuperview()
        }
    }
    
    // MARK: 2.08、设置图片(通过Bundle加载)
    @objc func test208() {
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100)).title("3秒后消失", .normal).textColor(.yellow, .normal).boldFont(12).image(forParent: Self.self, bundleName: "JKBaseKit", "icon_scan", .normal)
        button.backgroundColor = .randomColor
        button.center = self.view.center
        self.view.addSubview(button)
        JKAsyncs.asyncDelay(3, {
        }) {
            button.removeFromSuperview()
        }
    }
    
    // MARK: 2.07、设置图片(通过Bundle加载)
    @objc func test207() {
        
        guard let path = Bundle.init(for: Self.self).path(forResource: "JKBaseKit", ofType: "bundle") else {
            return
        }
        let bundle = Bundle.init(path: path)
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100)).title("3秒后消失", .normal).textColor(.yellow, .normal).boldFont(12).image(in: bundle, "icon_scan", .normal)
        button.backgroundColor = .randomColor
        button.center = self.view.center
        self.view.addSubview(button)
        JKAsyncs.asyncDelay(3, {
        }) {
            button.removeFromSuperview()
        }
    }
    
    // MARK: 2.06、设置图片
    @objc func test206() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100)).title("3秒后消失", .normal).textColor(.yellow, .normal).boldFont(12).image(UIImage(named: "mark_highlighted"), .normal)
        button.backgroundColor = .randomColor
        button.center = self.view.center
        self.view.addSubview(button)
        JKAsyncs.asyncDelay(3, {
        }) {
            button.removeFromSuperview()
        }
    }
    
    // MARK: 2.05、设置字体粗体
    @objc func test205() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100)).title("3秒后消失", .normal).textColor(.yellow, .normal).boldFont(12)
        button.backgroundColor = .randomColor
        button.center = self.view.center
        self.view.addSubview(button)
        JKAsyncs.asyncDelay(3, {
        }) {
            button.removeFromSuperview()
        }
    }
    
    // MARK: 2.04、设置字体大小(CGFloat)
    @objc func test204() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100)).title("3秒后消失", .normal).textColor(.yellow, .normal).font(16)
        button.backgroundColor = .randomColor
        button.center = self.view.center
        self.view.addSubview(button)
        JKAsyncs.asyncDelay(3, {
        }) {
            button.removeFromSuperview()
        }
    }
    
    // MARK: 2.03、设置字体大小(UIFont)
    @objc func test203() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100)).title("3秒后消失", .normal).textColor(.yellow, .normal).font(UIFont.systemFont(ofSize: 12))
        button.backgroundColor = .randomColor
        button.center = self.view.center
        self.view.addSubview(button)
        JKAsyncs.asyncDelay(3, {
        }) {
            button.removeFromSuperview()
        }
    }
    
    // MARK: 2.02、设置文字颜色
    @objc func test202() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100)).title("3秒后消失", .normal).textColor(.yellow, .normal)
        button.backgroundColor = .randomColor
        button.center = self.view.center
        self.view.addSubview(button)
        JKAsyncs.asyncDelay(3, {
        }) {
            button.removeFromSuperview()
        }
    }
    
    // MARK: 2.01、设置title
    @objc func test201() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100)).title("3秒后消失", .normal)
        button.backgroundColor = .randomColor
        button.center = self.view.center
        self.view.addSubview(button)
        JKAsyncs.asyncDelay(3, {
        }) {
            button.removeFromSuperview()
        }
    }
}

// MARK: - 一、基本的扩展
extension UIButtonExtensionViewController {
    
    //MARK: 1.03、设置背景色
    @objc func test103() {
        let button = UIButton.jk.normal()
        button.jk.setBackgroundColor(UIColor.brown, forState: .normal)
        button.jk.setBackgroundColor(UIColor.green, forState: .disabled)
        self.view.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 100, height: 50))
            make.center.equalToSuperview()
        }
        
        JKAsyncs.asyncDelay(2, {
        }) {
            button.isEnabled = true
            JKAsyncs.asyncDelay(2, {
            }) {
                button.isEnabled = false
                JKAsyncs.asyncDelay(2, {
                }) {
                    button.removeFromSuperview()
                }
            }
        }
    }
    
    // MARK: 1.02、创建一个常规的 Button
    @objc func test102() {
        let button = UIButton.jk.normal()
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        button.center = self.view.center
        self.view.addSubview(button)
        JKAsyncs.asyncDelay(3, {
        }) {
            button.removeFromSuperview()
        }
    }
    
    // MARK: 1.01、创建一个带颜色的 Button
    @objc func test101() {
        let button = UIButton.jk.small(type: .red, height: 200)
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        button.center = self.view.center
        self.view.addSubview(button)
        JKAsyncs.asyncDelay(3, {
        }) {
            button.removeFromSuperview()
        }
        
        let familyFonts = UIFont.familyNames
        for fontStr1 in familyFonts {
            let fonts = UIFont.fontNames(forFamilyName: fontStr1)
            for fontStr2 in fonts {
                print(fontStr2)
            }
        }
    }
}
