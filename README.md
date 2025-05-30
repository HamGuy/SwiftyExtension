<p align="center">
<!-- <a href="https://cocoapods.org/pods/SwiftyExtension"><img src="https://img.shields.io/cocoapods/v/SwiftyExtension.svg?style=flat"></a>
<a href="https://github.com/JoanKing/SwiftyExtension/blob/master/LICENSE"><img src="https://img.shields.io/cocoapods/l/SwiftyExtension.svg?style=flat"></a>
<a href="https://cocoapods.org/pods/SwiftyExtension"><img src="https://img.shields.io/cocoapods/p/SwiftyExtension.svg?style=flat"></a> -->
</p>

# SwiftyExtension

这个项目 fork 自 [JKSwiftExtension](https://github.com/JoanKing/JKSwiftExtension)，在原有iOS支持的基础上，**新增了对 macOS 的支持**，让您可以在 macOS 应用开发中也能享受到丰富的Swift扩展功能。

## 主要改进

- ✅ **完整的 macOS 支持**：所有适用的扩展都已适配 macOS 平台
- ✅ **跨平台兼容**：同时支持 iOS 和 macOS，代码复用更简单
- ✅ **保持原有功能**：继承了原项目的所有优秀特性
- ✅ **统一API设计**：iOS 和 macOS 使用相同的API接口

## 组成部分  

    FoundationExtension：Foundation 类型的扩展（iOS & macOS）
    UIKitExtension：UIKit类型的扩展（iOS）
    AppKitExtension：AppKit类型的扩展（macOS）
    Protocol：协议工具（iOS & macOS）
    SmallTools：其他小工具（iOS & macOS）
    
## 使用说明

每一个 `Extension` 都会对应一个测试用例的类，如果没有的说明还没有完善，如： String 的分类 `String+Extension` 的测试用例在 `StringExtensionViewController.swift` 里面

![WechatIMG160.jpeg](https://upload-images.jianshu.io/upload_images/1728484-f0bcaccd3f7d26b3.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1024)
   
## 导入方式

#### 方式一：Swift Package Manager

- File > Swift Packages > Add Package Dependency
- Add `https://github.com/hamguy/SwiftyExtension.git`
- Select "Up to Next Major" with "2.0.0"

#### 方式二：CocoaPods

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '13.0'  # iOS 支持
# platform :osx, '10.15'  # macOS 支持
use_frameworks!

target 'MyApp' do
  pod 'SwiftyExtension'
end
```

## 平台支持

| 平台 | 最低版本 | 状态 |
|------|----------|------|
| iOS | 13.0+ | ✅ 完全支持 |
| macOS | 10.13+ | ✅ 新增支持 |

## 跨平台使用示例

```swift
import SwiftyExtension

// Foundation扩展在iOS和macOS上都可以使用
let text = "Hello World"
let length = text.jk.length

// 日期处理
let today = Date.jk.todayDate
let formattedDate = today.jk.toString(format: "yyyy-MM-dd")

#if os(iOS)
// iOS特有的UIKit扩展
let color = UIColor.jk.randomColor
let label = UILabel()
label.jk.text("Hello iOS").textColor(.blue)
#elseif os(macOS)
// macOS特有的AppKit扩展
let color = NSColor.jk.randomColor
let textField = NSTextField()
textField.jk.stringValue("Hello macOS").textColor(.blue)
#endif
```

## Requirements

    Swift 5.0+
    iOS 13.0+ / macOS 10.15+
    
## 致谢

感谢原作者 [JoanKing](https://github.com/JoanKing) 创建了优秀的 [JKSwiftExtension](https://github.com/JoanKing/JKSwiftExtension) 项目。这个 fork 版本在保持原有功能的基础上，扩展了对 macOS 平台的支持。


## 版本说明

### macOS 支持版本
- **macOS 分支**：基于原项目 2.8.3 版本进行 macOS 适配
  - ✅ 添加完整的 macOS 支持
  - ✅ AppKit 扩展适配
  - ✅ 跨平台API统一
  - ✅ 保持与iOS版本的功能一致性

### 原项目版本历史
有关原项目的版本历史，请访问 [JKSwiftExtension README](https://github.com/JoanKing/JKSwiftExtension/blob/master/README.md)。

## Author

原作者：JoanKing, jkironman@163.com

## License

SwiftyExtension is available under the MIT license. See the LICENSE file for more info.
