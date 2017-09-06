//
//  CollectionTypeExtensions.swift
//  Ents
//
//  Created by Georges Boumis on 13/07/2016.
//  Copyright © 2016-2017 Georges Boumis.
//  Licensed under MIT (https://github.com/averello/Ents/blob/master/LICENSE)
//

import Foundation

public extension Collection {
    
    /// Calls the given closure on each element in the sequence in the same order
    /// as a `for`-`in` loop with the index of the elemement in the collection.
    ///
    /// The two loops in the following example produce the same output:
    ///
    ///     let numberWords = ["one", "two", "three"]
    ///     for index,word in numberWords.enumerated() {
    ///         print("\(index): \(word)")
    ///     }
    ///     // Prints "0: one"
    ///     // Prints "1: two"
    ///     // Prints "2: three"
    ///
    ///     numberWords.forEach { index,word in
    ///         print("\(index): \(word)")
    ///     }
    ///     // Same as above
    ///
    /// Using the `forEach` method is distinct from a `for`-`in` loop in two
    /// important ways:
    ///
    /// 1. You cannot use a `break` or `continue` statement to exit the current
    ///    call of the `body` closure or skip subsequent calls.
    /// 2. Using the `return` statement in the `body` closure will exit only from
    ///    the current call to `body`, not from any outer scope, and won't skip
    ///    subsequent calls.
    ///
    /// - Parameter body: A closure that takes an element of the sequence, as 
    ///     well as its index in the collection, as its parameters.
    public func forEach(inReverse rev: Bool = false,
                        body: ((Self.Index, Self.Iterator.Element)) throws -> Void) rethrows {
        try self.forEach(inRange: self.wholeRange, inReverse: rev, body: body)
    }

    /// Trasverses a `Collection` instance from end to start, evaluating the 
    /// given closure for each element.
    public func forEachReversed(body: (Self.Index, Self.Iterator.Element) throws -> Void) rethrows {
        try self.forEach(inRange: self.wholeRange, inReverse: true, body: body)
    }

    /// Calls the given closure on each element starting from a given index in
    /// the sequence in the same order as a `for`-`in` loop with the index of
    /// the elemement in the collection.
    /// The iterations starts from the given index.
    ///     
    ///     let a = ["George", "Martha", "Nick", "Honey"]
    ///     a.forEach(startingFromIndex: 2) { index,element in
    ///         print("\(index): \(word)")
    ///     }
    ///     // Prints "2: Nick"
    ///     // Prints "3: Honey"
    /// - Parameter startingFromIndex: the index to start iterating from
    /// - Parameter body: A closure that takes an element of the sequence, as
    ///     well as its index in the collection, as its parameters.
    public func forEach(startingFromIndex index: Self.Index,
                        body: (Self.Index, Self.Iterator.Element) throws -> Void) rethrows {
        try self.forEach(inRange: index..<self.endIndex, body: body)
    }

    /// Calls the given closure on each element up to a given index in
    /// the sequence in the same order as a `for`-`in` loop with the index of
    /// the elemement in the collection.
    /// The iterations ends to the given index.
    ///
    ///     let a = ["George", "Martha", "Nick", "Honey"]
    ///     a.forEach(upToIndex: 2) { index,element in
    ///         print("\(index): \(word)")
    ///     }
    ///     // Prints "0: George"
    ///     // Prints "1: Martha"
    /// - Parameter upToIndex: the index to end iterating
    /// - Parameter body: A closure that takes an element of the sequence, as
    ///     well as its index in the collection, as its parameters.
    public func forEach(upToIndex index: Self.Index,
                        body: (Self.Index, Self.Iterator.Element) throws -> Void) rethrows {
        try self.forEach(inRange: self.startIndex..<index, body: body)
    }

    public func forEach(inRange range: Range<Self.Index>,
                        inReverse rev: Bool = false,
                        body: (Self.Index, Self.Iterator.Element) throws -> Void) rethrows {
        guard not(range.isEmpty) else { return }
        guard (range.lowerBound >= self.startIndex && range.lowerBound < self.endIndex) &&
            (range.upperBound >= self.startIndex && range.upperBound <= self.endIndex)
            else { return }
        if not(rev) {
            try self._forEachIterateLoop(with: range, body: body)
        }
        else {
			try self._forEachIterateLoopInReverse(with: range, body: body)
        }
    }

	private func _forEachIterateLoop(with range: Range<Self.Index>,
	                                 body: (Self.Index, Self.Iterator.Element) throws -> Void) rethrows {
        try self.__forEachIterateLoop(with: range) { (i, e, b) in
            try body(i,e)
        }
	}
    
    private func __forEachIterateLoop(with range: Range<Self.Index>,
                                      body: (Self.Index, Self.Iterator.Element, _ stop: inout Bool) throws -> Void) rethrows {
        var i = range.lowerBound
        var stop = false
        while (i < range.upperBound) && (stop == false) {
            let element = self[i]
            try body(i, element, &stop)
            i = self.index(after: i)
        }
    }

	private func _forEachIterateLoopInReverse(with range: Range<Self.Index>,
	                                          body: (Self.Index, Self.Iterator.Element) throws -> Void) rethrows {
		try self.__forEachIterateLoopInReverse(with: range) { (i, e, b) in
            try body(i,e)
        }
	}
    
    private func __forEachIterateLoopInReverse(with range: Range<Self.Index>,
                                               body: (Self.Index, Self.Iterator.Element, _ stop: inout Bool) throws -> Void) rethrows {
        var i = self.index(range.upperBound, offsetBy: -1)
        var stop = false
        while (i >= range.lowerBound) && (stop == false) {
            let element = self[i]
            try body(i, element, &stop)
            i = self.index(i, offsetBy: -1)
        }
    }
    
    /// Enumerates over all elements of the this `Collection` instance, evaluating
    /// the given closure, passing the index of the element as well as a `stop`
    /// indicator to stop prematurely the iteration.
    /// Tris to replicate `-enumerateObjectsUsingBlock:` of `NSArray`.
    public func enumerate(_ body: (Self.Index, Self.Iterator.Element, _ stop: inout Bool) throws -> Void) rethrows {
        try self.__forEachIterateLoop(with: self.wholeRange, body: body)
    }
}

public extension Collection {
    
    /// A range that contains all valid indexes of the collection.
    /// This range does not contain "pass the end" indexes.
    public var wholeRange: Range<Self.Index> {
        return self.startIndex..<self.endIndex
    }
    
    
    /// A closed range that contains all valid indexes of the collection.
    /// This range does not contain "pass the end" indexes.
    public var closedWholeRange: ClosedRange<Self.Index> {
        let whole = self.wholeRange
        let upper = self.index(whole.upperBound, offsetBy: -1)
        return ClosedRange(uncheckedBounds: (whole.lowerBound, upper: upper))
    }
}

public extension Collection where Index: Strideable, Index.Stride: SignedInteger {
    
    /// A range that contains all valid indexes of the collection.
    /// This range does not contain "pass the end" indexes.
    public var wholeRange: CountableClosedRange<Self.Index> {
        return CountableClosedRange(self.closedWholeRange)
    }
}

public extension Collection {
    
    /// Find indices satisfying the given predicate.
    /// - parameter predicate: a predicate
    /// - returns: the indices of elements satisfying predicate
    public func indices(where predicate: (Iterator.Element) -> Bool) -> [Index] {
        var indices: [Index] = Array<Index>()
        indices.reserveCapacity(Int(self.count.toIntMax()))
        
        let range: Range<Self.Index> = self.startIndex..<self.endIndex
        var index = range.lowerBound
        while (index < range.upperBound) {
            let element = self[index]
            if predicate(element) {
                indices.append(index)
            }
            index = self.index(after: index)
        }
        return indices
    }
}

public extension Collection {

    /// Returns a tuple with two arrays, one with elements of `self` that satisfy
    /// `includeElement` and another with the elements of `self` that DO NO
    /// satisfy the `includeElement` predicate.
    ///
    /// - Note: The elements of the result are computed on-demand, as
    ///   the result is used. No buffering storage is allocated and each
    ///   traversal step invokes `predicate` on one or more underlying
    ///   elements.
    /// - parameter includeElement: a predicate
    public func filterWithRemainder(includeElement: (Self.Iterator.Element) throws -> Bool) rethrows -> (included:[Self.Iterator.Element], notIncluded:[Self.Iterator.Element]) {
        var filtered: [Self.Iterator.Element] = []
        var unfiltered: [Self.Iterator.Element] = []
        
        let capacity = Int(self.count.toIntMax())/2
        filtered.reserveCapacity(capacity)
        unfiltered.reserveCapacity(capacity)

        for element in self {
            if try includeElement(element) {
                filtered.append(element)
            }
            else {
                unfiltered.append(element)
            }
        }
        return (filtered,unfiltered)
    }

    /// Returns an array **NOT** containing, in order, the elements of the 
    /// sequence that satisfy the given predicate.
    /// This is a **reverted** filter().
    ///
    ///     let cast = ["Vivien", "Marlon", "Kim", "Karl"]
    ///     let shortNames = cast.sieve { $0.characters.count < 5 }
    ///     print(shortNames)
    ///     // Prints "["Vivien", "Marlon"]"
    ///
    /// - Parameter excluding: A closure that takes an element of the
    /// sequence as its argument and returns a Boolean value indicating whether 
    /// the element should be excluded in the returned array.
    /// - Returns: An array of the elements that `excluding` excluded.
    public func sieve(_ excluding: (Self.Iterator.Element) throws -> Bool) rethrows -> [Self.Iterator.Element] {
        return try self.filter { try not(excluding($0)) }
    }
}

public extension Collection {
    
    /// Returns an array containing, in order, the elements of the sequence
    /// that satisfy the given predicate.
    ///
    /// In this example, `filter` is used to include only names shorter than
    /// five characters.
    ///
    ///     let cast = ["Vivien", "Marlon", "Kim", "Karl"]
    ///     let shortNames = cast.filteri { $1.characters.count < 5 || $1 == 0 }
    ///     print(shortNames)
    ///     // Prints "["Vivien", "Kim", "Karl"]"
    ///
    /// - Parameter isIncluded: A closure that takes an element of the
    ///   sequence, as well as its index, as its arguments and returns a Boolean
    ///   value indicating whether the element should be included in the 
    ///   returned array.
    /// - Returns: An array of the elements that `includeElement` allowed.
    public func filteri(_ isIncluded: (Self.Index, Self.Iterator.Element) throws -> Bool) rethrows -> [Self.Iterator.Element] {
        var result: [Iterator.Element] = []
        let count = Int(self.count.toIntMax())
        result.reserveCapacity(count)
        try self.forEach { index,element in
            if try isIncluded(index,element) {
                result.append(element)
            }
        }
        return result
    }
    
    /// Returns an array containing the results of mapping the given closure
    /// over the sequence's elements.
    ///
    /// In this example, `map` is used first to convert the names in the array
    /// to lowercase strings and then to count their characters.
    ///
    ///     let cast = ["Vivien", "Marlon", "Kim", "Karl"]
    ///     let lowercaseNames = cast.mapi { $0 > 1 ? $1.lowercaseString && : $1 }
    ///     // 'lowercaseNames' == ["Vivien", "Marlon", "kim", "karl"]
    ///     let letterCounts = cast.map { $0.characters.count }
    ///     // 'letterCounts' == [6, 6, 3, 4]
    ///
    /// - Parameter transform: A mapping closure. `transform` accepts an
    ///   element of this sequence, as well as its index, as its parameters and
    ///   returns a transformed value of the same or of a different type.
    /// - Returns: An array containing the transformed elements of this
    ///   sequence.
    public func mapi<T>(_ transform: (Self.Index, Self.Iterator.Element) throws -> T) rethrows -> [T] {
        var result: [T] = []
        let count = Int(self.count.toIntMax())
        result.reserveCapacity(count)
        try self.forEach { i,e in
            let e1 = try transform(i, e)
            result.append(e1)
        }
        return result
    }

    public func flatMapi<SegmentOfResult : Sequence>(_ transform: (Self.Index, Self.Iterator.Element) throws -> SegmentOfResult) rethrows -> [SegmentOfResult.Iterator.Element] {
        var result: [SegmentOfResult.Iterator.Element] = []
        let count = Int(self.count.toIntMax())
        result.reserveCapacity(count) // at least
        try self.forEach { i,e in
            let e1 = try transform(i, e)
            result.append(contentsOf: e1)
        }
        return result
    }

    /// Returns the result of combining the elements of the sequence using the
    /// given closure.
    ///
    /// Use the `reduce(_:_:)` method to produce a single value from the elements
    /// of an entire sequence. For example, you can use this method on an array
    /// of numbers to find their sum or product.
    ///
    /// The `nextPartialResult` closure is called sequentially with an
    /// accumulating value initialized to `initialResult` and each element of
    /// the sequence. This example shows how to find the sum of an array of
    /// numbers.
    ///
    ///     let numbers = [1, 2, 3, 4]
    ///     let numberSum = numbers.reduce(0, { x, y in
    ///         x + y
    ///     })
    ///     // numberSum == 10
    ///
    /// When `numbers.reduce(_:_:)` is called, the following steps occur:
    ///
    /// 1. The `nextPartialResult` closure is called with `initialResult`---`0`
    ///    in this case---and the first element of `numbers`, returning the sum:
    ///    `1`.
    /// 2. The closure is called again repeatedly with the previous call's return
    ///    value and each element of the sequence.
    /// 3. When the sequence is exhausted, the last value returned from the
    ///    closure is returned to the caller.
    ///
    /// If the sequence has no elements, `nextPartialResult` is never executed
    /// and `initialResult` is the result of the call to `reduce(_:_:)`.
    ///
    /// - Parameters:
    ///   - initialResult: The value to use as the initial accumulating value.
    ///     `initialResult` is passed to `nextPartialResult` the first time the
    ///     closure is executed.
    ///   - nextPartialResult: A closure that combines an accumulating value and
    ///     an element of the sequence into a new accumulating value, as well as
    ///     an index, to be used in the next call of the `nextPartialResult` 
    ///     closure or returned to the caller.
    /// - Returns: The final accumulated value. If the sequence has no elements,
    ///   the result is `initialResult`.
    public func reducei<Result>(_ initialResult: Result, _ nextPartialResult: (Result, Self.Index, Self.Iterator.Element) throws -> Result) rethrows -> Result {
        var result = initialResult
        try self.forEach { i,e in
            result = try nextPartialResult(result, i, e)
        }
        return result
    }
}


public extension Collection {
    
    /// The "just before past the end" position for the set---that is, the 
    /// position equal to the last valid subscript argument.
    ///
    /// If the set is empty, `endIndex` is equal to `startIndex`.
    public var lastIndex: Index {
        guard self.hasElements else { return self.startIndex }
        let start = self.startIndex
        var index = start
        while self.index(after: index) < self.endIndex {
            index = self.index(after: index)
        }
        return index
    }
}

public extension Collection {

    /// A `Boolean` value indicating whether the collection is *NOT* empty.
    ///
    /// When you need to check whether your collection is not empty, use the
    /// `hasElements` property instead of checking that the `count` property is
    /// different from zero. For collections that don't conform to
    /// `RandomAccessCollection`, accessing the `count` property iterates
    /// through the elements of the collection.
    ///
    ///     let horseName = "Silver"
    ///     if horseName.characters.hasElements {
    ///         print("Hi ho, \(horseName)!")
    ///     } else {
    ///         print("I've been through the desert on a horse with no name.")
    ///     }
    ///     // Prints "Hi ho, Silver!")
    ///
    /// - Complexity: O(1)
    public var hasElements: Bool {
        return (self.isEmpty == false)
    }
}

