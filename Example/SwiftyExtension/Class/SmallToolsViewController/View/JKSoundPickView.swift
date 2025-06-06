//
//  JKSoundPickView.swift
//  SwiftyExtension_Example
//
//  Created by 王冲 on 2023/3/3.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit

@objcMembers public class SoundPickViewStyle: NSObject {
    /// 取消的颜色
    public var cancleColor: UIColor = UIColor.hexStringColor(hexString: "#2C2D2E")
    /// 确定的颜色
    public var sureColor: UIColor = UIColor.hexStringColor(hexString: "#426BF2")
}

public typealias SelectedBackClosure = (_ resultStr: String) -> ()

public class JKSoundPickView : UIView {
    /// 样式
    fileprivate var style: SoundPickViewStyle = SoundPickViewStyle()
    /// 界面消失
    public var dismissClosure: (() -> Void)?
    /// 确定按钮的闭包
    public var rowAndComponentCallBack: PickerViewSelectedBackClosure?
    /// 选择的内容
    fileprivate var blockContent: String = ""
    /// 取消
    lazy var cancelButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 16, y: 16, width: jk_kScreenW / 2.0 - 16, height: 26))
        button.setTitle("取消", for: .normal)
        button.setTitleColor(style.cancleColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        return button
    }()
    /// 确定
    lazy var confirmButton: UIButton = {
        let button = UIButton(frame: CGRect(x: jk_kScreenW / 2.0, y: 16, width: jk_kScreenW / 2.0 - 16, height: 26))
        button.setTitle("确定", for: .normal)
        button.setTitleColor(style.sureColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        button.contentHorizontalAlignment = .right
        button.addTarget(self, action: #selector(confirmAction), for: .touchUpInside)
        return button
    }()
    /// window
    var keyWindow : UIWindow?
    /// 背景色
    lazy var bgView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: jk_kScreenH - 274 - jk_kSafeDistanceBottom, width: jk_kScreenW, height: 274 + jk_kSafeDistanceBottom))
        view.backgroundColor = UIColor.white
        view.jk.addCorner(conrners: [.topLeft, .topRight], radius: 20)
        // UIColor.niuColorTheme(lightColor: UIColor.cF2F4F7, darkColor: UIColor.c222222)
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.alpha = 0.0
        self.bgView.alpha = 0.0
        self.backgroundColor = UIColor.black.withAlphaComponent(0.47)
        self.jk.addTapGestureRecognizerAction(self, #selector(hide))
        if (keyWindow == nil) {
            self.keyWindow = UIApplication.jk.keyWindow
        }
        addSubview(bgView)
        bgView.addSubview(cancelButton)
        bgView.addSubview(confirmButton)
        
    }
   
    public convenience init(frame: CGRect, dataSource: [String], inComponent component: Int = 0, style: SoundPickViewStyle = SoundPickViewStyle()) {
        self.init(frame: frame)
        if (dataSource.count != 0) {
            let picker = SoundPickerViewBuilder(frame: CGRect(x: 0, y: 60, width: jk_kScreenW, height: bgView.frame.size.height - 60 - jk_kSafeDistanceBottom - 20), dataSource: dataSource, inComponent: component, contentCallBack:{ [weak self] (resultStr) in
                guard let weakSelf = self else {
                    return
                }
                weakSelf.blockContent = resultStr
            })
            picker.rowAndComponentCallBack = {[weak self](resultStr) in
                guard let weakSelf = self else {
                    return
                }
                weakSelf.blockContent = resultStr
            }
            bgView.addSubview(picker)
        } else {
            assert(dataSource.count != 0, "dataSource is not allowed to be nil")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func showAlert(withTitle title: String?, message: String?) {
        let alertVc = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVc.addAction(UIAlertAction(title: "我知道了", style: .cancel, handler: nil))
        keyWindow?.rootViewController?.present(alertVc, animated: true, completion: nil)
    }
}

//MARK: - 基本事件
public extension JKSoundPickView {
    //MARK: 弹出视图
    func show() {
        keyWindow?.addSubview(self)
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 1.0
            self.bgView.alpha = 1.0
        }) { (isFinished) in
            
        }
    }

    //MARK: 界面消失
    @objc func hide() {
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 0.0
            self.bgView.alpha = 0.0
        }) { (isFinished) in
            self.removeFromSuperview()
            self.dismissClosure?()
        }
    }

    //MARK: 取消
    /// 取消
    @objc func cancelAction() {
        hide()
    }
    
    //MARK: 确定
    /// 确定
    @objc func confirmAction() {
        if blockContent == "" {
            showAlert(withTitle: "提示", message: "未选择任何一项！")
        } else {
            self.rowAndComponentCallBack?(blockContent)
        }
        hide()
    }
}

class SoundPickerViewBuilder: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    let width1 = (jk_kScreenW - 20 - 50) / 2.0
    let width2 = 10.0
    /// 选择内容回调
    fileprivate var rowAndComponentCallBack: PickerViewSelectedBackClosure?
    /// 当前选中的row
    lazy var currentSelectRow: Int = 0
    /// 资源数组
    lazy var dataArray: [String] = []
    /// 资源数组
    lazy var dataArray1: [String] = ["日"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, dataSource: [String], inComponent component: Int = 0, contentCallBack: PickerViewSelectedBackClosure?) {
        self.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.dataArray = dataSource
        self.delegate = self
        self.dataSource = self
        currentSelectRow = component
        self.selectRow(component, inComponent: 0, animated: true)
        self.reloadAllComponents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return dataArray.count
        }
        return dataArray1.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        // pickerView.backgroundColor = .brown
        var pickerLabel = view as? UILabel
        if pickerLabel == nil {
            pickerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: width1, height: 30))
            pickerLabel?.textAlignment = .center
            
            if component == 0 {
                if currentSelectRow == row {
                    pickerLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
                    pickerLabel?.textColor = UIColor.hexStringColor(hexString: "#2C2D2E")
                } else {
                    pickerLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
                    pickerLabel?.textColor = UIColor.hexStringColor(hexString: "#7C828C")
                }
            } else {
                pickerLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
                pickerLabel?.textColor = UIColor.hexStringColor(hexString: "#2C2D2E")
            }
        }
    
        if component == 0 {
            //pickerLabel?.jk.width = width1
            pickerLabel?.text = dataArray[row]
            //pickerLabel?.textAlignment = .center
        } else {
            //pickerLabel?.jk.width = width1
            pickerLabel?.text = dataArray1[row]
            //pickerLabel?.textAlignment = .center
        }
        // pickerLabel?.backgroundColor = .randomColor
        return pickerLabel!
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return dataArray[row]
        } else {
            return dataArray1[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 33
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        if component == 0 {
            return width1
        } else {
            return width1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentSelectRow = row
        rowAndComponentCallBack?(dataArray[currentSelectRow])
        self.reloadAllComponents()
    }
}
