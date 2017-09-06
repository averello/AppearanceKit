# RepresentationKit

Influenced by [Printers instead of getters](http://www.yegor256.com/2016/04/05/printers-instead-of-getters.html)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Code Example

```swift
struct Book {
    let name: String
    let edition: String
}

extension Book: Representable {
    func represent(using representation: Representation) -> Representation {
        return representation
            .with(key: "name", value: self.name)
            .with(key: "edition", value: self.edition)
    }
}

extension Book: CustomStringConvertible {
    var description: String {
        return "Book(\(self.name),\(self.edition))"
    }
}

let books = (0..<2).map { Book(name: "Book \($0)", edition: "Edition \($0)") }
print("Books = \(books)")
// Prints "Books = [Book(Book 0,Edition 0), Book(Book 1,Edition 1)]"

let arrayRep = ArrayRepresentationBuilder()
let dictRep = DictionaryRepresentationBuilder()

let arrayResuslt: ArrayRepresentationBuilder = books[0].represent(using: arrayRep)
print(arrayResuslt.array)
// Prints ["Book 0", "Edition 0"]

let dictResuslt: DictionaryRepresentation = books[0].represent(using: dictRep)
print(dictResuslt.dictionary)
// Prints ["name": "Book 0", "edition": "Edition 0"]

let dictionaryRepresentationOfAnArray: DictionaryRepresentation = books.represent(using: dictRep)
print(dictionaryRepresentationOfAnArray.dictionary)
// Prints ["0": Book(Book 0,Edition 0), "1": Book(Book 1,Edition 1)]

let deepRep = DeepArrayRepresentationBuilder(representation: JSONRepresentationBuilder())
let deepRepRes: DeepArrayRepresentationBuilder = books.represent(using: deepRep)
print(deepRepRes.array.map { $0.dictionary })
// Prints [["name": "Book 0", "edition": "Edition 0"], ["name": "Book 1", "edition": "Edition 1"]]
```

## Requirements

## Installation

RepresentationKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "RepresentationKit"
```

## Author

Georges Boumis, developer.george.boumis@gmail.com

## License

RepresentationKit is available under the Apache 2.0 license. See the LICENSE file for more info.
