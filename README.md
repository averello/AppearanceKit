# AppearanceKit

Change the appearance of `UIKit` elements, using classes that declaratively
describe the appearance. AppearanceKit provides a way to strong type
appearances like a label's (`UILabelAppearance`) or a button's appearance
(`UIButtonAppearance`), a color (`UIColor`), a font (`Font`), or text
(`AttributedText`).

AppearanceKit values _immutability_ and _horizontal_ decoration. Thus all top
types are protocols that can be horizontally decorated.

AppearanceKit is (optionally) dependent on
[ContentKit](https://github.com/averello/ContentKit) and
[RepresentationKit](https://github.com/averello/RepresentationKit). It is
recommended to include those dependencies. If you do not want to import them
then comment out those dependencies in the AppearanceKit.podspec file.

## Example

To run the example project, clone the repo, and run `pod install` from the
Example directory first.

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

// or even a textfield
let textField = // ...
appearance.configure(textField)
```

## Installation

AppearanceKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "AppearanceKit"
```

## Discussion

AppearanceKit provides appearances for:

* `UILabel` through `UILabelAppearance`, `ConfigurableUILabelAppearance` and
  `DefaultUILabelAppearance`
* `UITextField` the same as `UILabel`
* `UITextView` the same as `UILabel`
* `UIButton` through `UIButtonAppearance`, `ConfigurableUIButtonAppearance` and
  `DefaultUIButtonAppearance` 
* `CALayer` (and shadow) through `CAContentAppearance` and `CAShadowAppearance`

AppearanceKit provides declarative types for:

* Colors through `Color` and `*Color`:
  - `TextColor` which provides a way to gather the text colors (of a button) of
	different states together.
  - `HexColor` which faciliates construction from hexadecimal strings or
	integers
  - `HueColor` for easy working on HSBA values.
  -  `RandomColor`
* Fonts through `Font` and `*Font`
* Images throught specializations of `ContentKit.Image`:
  - `DrawnImage` which wraps
	`UIGraphicsBeginImageContextWithOptions`/`UIGraphicsImageRenderer` behind a
	strong typed type.
  - `FlippedImage` which flips horizontally/vertically a decorated image
  - `RenderingModeImage` which renders differently the decorated image
  - `ResizableImage` which represents a resizable (stretchable)
  - `RotatedImage` permits arbitrary rotations of the decorated image
  - `ScaledImage` scales the decorated image
  - `TintedImage` tints the decorated image respecting a blend mode
  - `TrimmedImage` trims the decorated images for transparent pixels

### Working with Colors

```swift
// black
let color = BlackColor()

// random color
let random = RandomColor()

// blakc with 20% opacity
let notSoBlack = black.with(alpha: 0.2)

// a (probably) more bright color from the random color
let brightRandom = random.with(brightness: 0.9)
// or
var brightRandom = HueColor(random)
brightRandom.brightness = 0.5
```

### Working with Fonts

```swift
// system font
let font = SystemFont()
// bold system font
let bold = font.bold

// decorate UIFonts
let mainFont = AnyFont(font: /* a UIFont */)
mainFont.with(size: 25)

// or create related fonts with
struct AFont: Font {
	/* properties for Font comformance */
	var normal: Font { return self }
    var bold: Font? { return BFont(font: self) } // provide the bold font
}
// the bold font
struct BFont: Font { 
	/* ... */ 
	var normal: Font { return AFont(font: self) } // provide the normal font
    var bold: Font? { return self }
}
```


### Working with Images

```swift
let image = /* UIImage */
let flipped = FlippedImage(image, flip: .vertical)

// both rotated and flipped
let rotatedNflipped = RotatedImage(flipped, rotation: .left)

// just rotated 90° to the right
let rotated = RotatedImage(image, rotation: .right)

// just rotated 123° to the right
let rotated = RotatedImage(image, rotation: .arbitrary(123))
```

## Author

Georges Boumis, developer.george.boumis@gmail.com

## License

AppearanceKit is available under the Apache 2.0 license. See the LICENSE file for more info.

