//
//  UniqueCollection.swift
//  Ents
//
//  Created by Georges Boumis on 06/07/2017.
//  Copyright © 2016-2017 Georges Boumis.
//  Licensed under MIT (https://github.com/averello/Ents/blob/master/LICENSE)
//

import Foundation

/// Non efficient unique collection based on == operator
public struct UniqueCollection<Element>: Collection, RangeReplaceableCollection where Element: Equatable {
    fileprivate let _array: [Element]
    
    public init() {
        self.init(collection: [])
    }
    
    public init(collection: [Element]) {
        var array: [Element] = Array<Element>()
        array.reserveCapacity(collection.count)
        collection.forEach { _,element in
            guard not(array.contains(element)) else { return }
            array.append(element)
        }
        self._array = array
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
        self = UniqueCollection(collection: array)
    }
}

extension UniqueCollection: CustomStringConvertible {
    
    public var description: String {
        return String(describing: type(of: self))
            + "\(self._array)"
    }
}

