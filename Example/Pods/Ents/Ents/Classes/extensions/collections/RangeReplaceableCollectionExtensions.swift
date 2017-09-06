//
//  RangeReplaceableCollectionExtensions.swift
//  Ents
//
//  Created by Georges Boumis on 22/03/2017.
//  Copyright © 2016-2017 Georges Boumis.
//  Licensed under MIT (https://github.com/averello/Ents/blob/master/LICENSE)
//

import Foundation

public extension RangeReplaceableCollection where Self.SubSequence.Iterator.Element == Self.Iterator.Element {
    
    /// creates a new collection that was deprived of its last element
    public func dropingLast(_ n: Int = 1) -> Self  {
        guard n > 0 else { return self }
        return Self(self.dropLast(n))
    }
    
    /// creates a new collection that was deprived of its first element
    public func dropingFirst(_ n: Int = 1) -> Self  {
        guard n > 0 else { return self }
        return Self(self.dropFirst(n))
    }
}

public extension RangeReplaceableCollection {
    
    /// iterates over the elements before removing all of them from the collection
    public mutating func removeAll(_ block: (Self.Iterator.Element) throws -> Void) rethrows {
        try self.forEach { (_,e) in
            try block(e)
        }
        self.removeAll()
    }
    
    /// creates a new collection populated by the given element at the end
    ///
    ///     let a = ["1", "2", "3"]
    ///     let appended = a.appending(element: "4")
    ///     print(appended)
    ///     // prints "["1", "2", "3", "4"]"
    ///
    /// - Parameter element: the element to append
    /// - Returns: a new collection populated by the given element at the end
    public func appending(element: Self.Iterator.Element) -> Self {
        var mutant = self
        mutant.append(element)
        return mutant
    }
    
    /// creates a new collection populated by the given element at the start
    ///
    ///     let a = ["1", "2", "3"]
    ///     let prepended = a.prepending(element: "0")
    ///     print(prepended)
    ///     // prints "["0", "1", "2", "3"]"
    ///
    /// - Parameter element: the element to prepend
    /// - Returns: creates a new collection populated by the given element at the start
    public func prepending(element: Self.Iterator.Element) -> Self {
        var mutant = self
        mutant.insert(element, at: mutant.startIndex)
        return mutant
    }
    
    
    // sieve() returns [Self.Iterator.Element],
    /// - Parameter predicate: the predicate
    /// - Returns: a new collection deprived of the elemnets that satisfy the given predicate
    /// - SeeAlso: sieve(:)
    public func removing(elementsSatisfying predicate: (Self.Iterator.Element) throws -> Bool) rethrows -> Self {
        return try Self(self.sieve(predicate))
    }
    
    /// remove elements that satisfy the given predicate
    /// - Parameter predicate: the predicate
    /// - SeeAlso: sieve(:)
    public mutating func remove(elementsSatisfying predicate: (Self.Iterator.Element) throws -> Bool) rethrows {
        self = try self.removing(elementsSatisfying: predicate)
    }
}

//public extension RangeReplaceableCollection
//where Self.Iterator.Element: Comparable,
//    Self.IndexDistance: Integer,
//    Self.Index == Self.IndexDistance,
//Self.SubSequence.Iterator.Element == Self.Iterator.Element {
//    
//    public mutating func mergeSortInPlace() {
//        var tmp: [Self.Iterator.Element] = []
//        tmp.reserveCapacity(Int(self.count.toIntMax()))
//        
//        func merge(lo: Self.Index, mi: Self.Index, hi: Self.Index) {
//            tmp.removeAll(keepingCapacity: true)
//            
//            var i = lo, j = mi
//            while i != mi && j != hi {
//                let sj = self[j], si = self[i]
//                if sj < si {
//                    tmp.append(sj)
//                    j = self.index(after: j)
//                }
//                else {
//                    tmp.append(si)
//                    i = self.index(after: i)
//                }
//            }
//            print("i = \(i), j = \(j), (lo,mi,hi) = (\(lo),\(mi),\(hi))")
//            tmp.append(contentsOf: self[i..<mi])
//            tmp.append(contentsOf: self[j..<hi])
//            self.replaceSubrange(lo..<hi, with: tmp)
//        }
//        
//        let n = self.count
//        let size = 1
//        let end = self.endIndex-1// self.index(self.endIndex, offsetBy: -1)
//        // n-size
//        while size < n {
//            for lo in stride(from: 0, to: n-size, by: size*2)
//                merge(lo: lo, mi: (lo+size), hi: (lo+size*2).minimum(n))
//            }
//            size *= 2
//        }
//    }
//}
