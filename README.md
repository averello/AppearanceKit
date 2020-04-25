# AppearanceKit

Change the appearance of UIKit elements, using classes that declaratively
describe the appearance.

AppearanceKit values immutability.


## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

```swift
// create an appearance
// by passing values throught the constructor
let appearance = ConfigurableUILabelAppearance(
							textColor: BlackColor(),
							numberOfLines: 3)

// or chaining calls
let appearance = ConfigurableUILabelAppearance()
						.updating(field: .textColor(BlackColor())
						.updating(field: .numberOfLines(3)

// or through a mutable container
var appearance = ConfigurableUILabelAppearance()
appearance.textColor = BlackColor()
apperanace.numberOfLines = 3


let label = // ...
// configure the label with the appearance
appearance.configure(label)

// you can use multiple times the appearance
let label2 = // ...
appearance.configure(label2)
```

## Installation

AppearanceKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "AppearanceKit"
```

# Discussion

AppearanceKit provides appearances for:

* UILabel
* UITextField
* UITextView
* UIButton
* CALayer (and shadow)

AppearanceKit provides declarative types for:

* Colors
* Fonts

## Author

Georges Boumis, developer.george.boumis@gmail.com

## License

AppearanceKit is available under the Apache 2.0 license. See the LICENSE file for more info.

