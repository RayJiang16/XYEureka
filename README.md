## XYEureka

[![GitHub Actions](https://github.com/RayJiang16/XYEureka/workflows/build/badge.svg?branch=master)](https://github.com/RayJiang16/XYEureka/actions?query=workflow%3Abuild)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/XYEureka.svg)](https://cocoapods.org/pods/XYEureka)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Platform](https://img.shields.io/cocoapods/p/XYEureka.svg?style=flat)](./)
[![License](https://img.shields.io/cocoapods/l/XYEureka.svg?style=flat)](./LICENSE)

基于 [Eureka](https://github.com/xmartlabs/Eureka) 进行二次开发，重写了一套 UI 层的 row，以及增加了一些方便方法。



## 要求

- iOS 10.0+
- Swift 5.3+
- Xcode 12.0+



## 安装

**[CocoaPods](https://cocoapods.org/):**

```
pod 'XYEureka'
```

**[Carthage](https://github.com/Carthage/Carthage):**

```
github "RayJiang16/XYEureka"
```



## 使用

Cell 增加了必填项（红星）和右侧箭头。

```swift
cell.hasMust = true
cell.hasArrow = true
// or
cell.hasMustAndArrow = true
```

增加反向数据同步，当 `row.value` 发生变化时触发回调，修改 model 中的数据。

```swift
<<< XYDatePickerRow("row").cellSetup({ (cell, row) in
    self.observe(tag: row.tag) { [weak self] in
        self?.model.xxx = row.value
    }
})
```

其他使用内容请看 [Eureka](https://github.com/xmartlabs/Eureka)。



## 协议

**XYEureka** 基于 MIT 协议进行分发和使用，更多信息参见[协议文件](LICENSE)。
