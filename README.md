# UIView-Ripple

[![Version](https://img.shields.io/cocoapods/v/UIView-Ripple.svg?style=flat)](https://cocoapods.org/pods/UIView-Ripple)
[![License](https://img.shields.io/cocoapods/l/UIView-Ripple.svg?style=flat)](https://github.com/janlionly/UIView-Ripple/blob/master/LICENSE)
[![Platform](https://img.shields.io/cocoapods/p/UIView-Ripple.svg?style=flat)](https://github.com/janlionly/UIView-Ripple)
![Swift](https://img.shields.io/badge/%20in-swift%205.1-orange.svg)

![UIView-Ripple demo image](https://media.giphy.com/media/jtKWLwo0KrfWFifbq2/giphy.gif)

## Description
**UIView-Ripple** is an animation which like water ripple expand, it extension UIView, just one line code (addRippleAnimation) for animating ripple effect.


## Installation

### CocoaPods

```ruby
pod 'UIView-Ripple'
```

## Usage

```swift
let testView = UIView(frame: CGRect(x: 100, y: 100, width: 80, height: 80)
testView.layer.cornerRadius = view.frame.size.width/2.0
testView.addRippleAnimation(color: .systemPink, duration: 1.5, repeatCount:1, rippleCount: 3, rippleDistance: nil)
```

## Requirements

- iOS 9.0+
- Swift 4.2 to 5.1

## Author

Visit my github: [janlionly](https://github.com/janlionly)<br>
Contact with me by email: janlionly@gmail.com

## Contribute

I would love you to contribute to **UIView-Ripple**

## License

**UIView-Ripple** is available under the MIT license. See the [LICENSE](https://github.com/janlionly/UIView-Ripple/blob/master/LICENSE) file for more info.
