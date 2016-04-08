# ETAdCycleView
An auto cycle or loop UIScrollview for horizonal advertisement or banner！一个自动无限循环轮播广告图

## Usage
---------
## Installation

ETAdCycleView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "ETAdCycleView"
```
### Run Example
To run the example project, clone the repo, and run `pod install` from the Example directory first.

### Quick Start
* In your podfile, just add `pod 'ETAdCycleView`, then `pod update`.
* Write api code to run a networking call:

* Use frame create
``` 
cycleScrollView = ETAdCycleView(frame: CGRect(x: 0, y: 30, width: view.size_width, height: 100))
view.addSubview(cycleScrollView)

let adImages = ["https://raw.githubusercontent.com/onevcat/Kingfisher/master/images/logo.png"
,
"http://tb1.bdstatic.com/tb/cms/frs/bg/default_head20141014.jpg",
"https://www.baidu.com/img/bd_logo1.png",
""]
cycleScrollView.et_setCycleImagesWithURLs(adImages, placeHolder: UIImage(named: "u86"))
``` 

* Use xib or storyboard create
``` 
let adCycleImages = ["https://raw.githubusercontent.com/onevcat/Kingfisher/master/images/logo.png"
,
"http://tb1.bdstatic.com/tb/cms/frs/bg/default_head20141014.jpg",
"https://www.baidu.com/img/bd_logo1.png",
""]
ibCycleView.et_setCycleImagesWithURLs(adCycleImages, placeHolder: UIImage(named: "u86"))
``` 

* Click image delegate
``` 
cycleScrollView.delegate = self
``` 
* Delegate
```
func et_cycleView(didClickPage pageView: UIImageView, atIndex index: Int) {
print("\(index)")
}
```  
## License

ETAdCycleView is available under the MIT license. See the LICENSE file for more info.
