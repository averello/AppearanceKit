//
//  SortedCollection.swift
//  Ents
//
//  Created by Georges Boumis on 09/05/2017.
//  Copyright © 2016-2017 Georges Boumis.
//  Licensed under MIT (https://github.com/averello/Ents/blob/master/LICENSE)
//

import Foundation

public struct SortedCollection<Element>: Collection, RangeReplaceableCollection where Element: Comparable {
    fileprivate let _array: [Element]
    
    public init() {
        self.init(collection: [])
    }
    
    public init(collection: [Element]) {
        self._array = collection.sorted()
    }

    //MARK: Collection conformance
    public var startIndex: Int { return self._array.startIndex }
    public var endIndex: Int { return self._array.endIndex }
    public subscript(i: Int) -> Element { return self._array[i] }
    public func index(after i: Int) -> Int { return self._array.index(after: i) }

    //MARK: RangeReplaceableCollection conformance
    // performance non optimal
    public mutating func replaceSubrange<C>(_ subrange: Range<Int>, with newElements: C) where C : Collection, C.Iterator.Element == Element {
        var array = self._array
        array.replaceSubrange(subrange, with: newElements)
        self = SortedCollection(collection: array)
    }
}

extension SortedCollection: CustomStringConvertible {
    
    public var description: String {
        return String(describing: type(of: self)) +
        "\(self._array)"
    }
}
