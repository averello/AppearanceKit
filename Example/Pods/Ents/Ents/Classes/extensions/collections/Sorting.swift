//
//  Sorting.swift
//  Ents
//
//  Created by Georges Boumis on 20/08/2017.
//  Copyright © 2016-2017 Georges Boumis.
//  Licensed under MIT (https://github.com/averello/Ents/blob/master/LICENSE)
//

import Foundation

public typealias SortDescriptor<Value> = (Value,Value) -> Bool

public func sortDescriptor<Value, Key>(
    key: @escaping (Value) -> Key,
    _ areInIncreasingOrder: @escaping (Key, Key) -> Bool
    ) -> SortDescriptor<Value> {
    return { areInIncreasingOrder(key($0), key($1)) }
}

public func sortDescriptor<Value, Key>(
    key: @escaping (Value) -> Key
) -> SortDescriptor<Value> where Key: Comparable {
    return { key($0) < key($1) }
}

public func sortDescriptor<Value, Key>(
    key: @escaping (Value) -> Key,
    ascending: Bool = true,
    _ comparator: @escaping (Key) -> (Key) -> ComparisonResult
    ) -> SortDescriptor<Value> {
    return { lhs, rhs in
        let order: ComparisonResult = ascending
        ? .orderedAscending
        : .orderedDescending
        return comparator(key(lhs))(key(rhs)) == order
    }
}

public func combine<Value>(sortDescriptors: [SortDescriptor<Value>]) -> SortDescriptor<Value> {
    return { lhs, rhs in
        for areInIncreasingOrder in sortDescriptors {
            if areInIncreasingOrder(lhs,rhs) { return true }
            if areInIncreasingOrder(rhs,lhs) { return false }
        }
        return false
    }
}

public func lift<A>(_ compare: @escaping (A) -> (A) -> ComparisonResult) -> (A?) -> (A?) -> ComparisonResult {
    return { lhs in { rhs in
        switch (lhs,rhs) {
        case (nil,nil): return .orderedSame
        case (nil,_): return .orderedAscending
        case (_,nil): return .orderedDescending
        case let (l?, r?): return compare(l)(r)
        default: fatalError() // Impossible case
        }}
    }
}
