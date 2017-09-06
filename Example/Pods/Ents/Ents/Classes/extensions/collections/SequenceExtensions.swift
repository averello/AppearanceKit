//
//  SequenceExtensions.swift
//  Ents
//
//  Created by Georges Boumis on 22/03/2017.
//  Copyright © 2016-2017 Georges Boumis.
//  Licensed under MIT (https://github.com/averello/Ents/blob/master/LICENSE)
//

import Foundation

public extension Sequence {
    
    /// Returns the last element (if any) in the sequence that satisfies the given pridecate
    ///
    ///     let cast = ["Vivien", "Marlon", "Kim", "Karl"]
    ///     let last = cast.last { $0.characters.count < 5 }
    ///     print(last)
    ///     // Prints "["Karl"]"
    ///
    /// - Parameter pridecate: A predicate
    /// - returns: last element satisfying the predicate if any
    public func last(where predicate: (Iterator.Element) -> Bool) -> Iterator.Element? {
        for element in self.reversed() where predicate(element) {
            return element
        }
        return nil
    }
}

public extension Sequence {
    
    /// - Parameter pridecate: a predicate
    /// - returns: true if all elements satisfy the predicate
    public func all(matching predicate: (Iterator.Element) -> Bool) -> Bool {
        return !self.contains { !predicate($0) }
    }
    
    /// - Parameter pridecate: a predicate
    /// - returns: true if none of the elements satisfy the predicate
    public func none(matching predicate: (Iterator.Element) -> Bool) -> Bool {
        return self.all { !predicate($0) }
    }
}

public extension Sequence where Iterator.Element: Hashable {
    
    /// - returns: an array containing once all elemnts, in order they appear in the sequence
    public func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return self.filter { element in
            if seen.contains(element) {
                return false
            }
            seen.insert(element)
            return true
        }
    }
}

