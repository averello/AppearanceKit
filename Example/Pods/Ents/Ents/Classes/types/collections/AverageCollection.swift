//
//  AverageCollection.swift
//  Ents
//
//  Created by Georges Boumis on 25/08/2017.
//  Copyright © 2016-2017 Georges Boumis.
//  Licensed under MIT (https://github.com/averello/Ents/blob/master/LICENSE)
//

import Foundation

public struct AverageCollection<E>: RangeReplaceableCollection, RandomAccessCollection where E: BinaryInteger {
    private let storage: [E]
    
    public init() {
        self.init([] as [E])
    }
    public init(_ storage: [E]) {
        self.storage = storage
    }
    
    public var startIndex: Array<E>.Index { return self.storage.startIndex }
    public var endIndex: Array<E>.Index { return self.storage.endIndex }
    public subscript(i: Array<E>.Index) -> E { return self.storage[i] }
    public func index(after i: Array<E>.Index) -> Array<E>.Index { return self.storage.index(after: i) }
    
    enum Error: Swift.Error {
        case empty
    }
    
    public mutating func replaceSubrange<C>(_ subrange: Range<Int>, with newElements: C) where C : Collection, C.Iterator.Element == E {
        var array = self.storage
        array.replaceSubrange(subrange, with: newElements)
        self = AverageCollection(array)
    }
}



extension AverageCollection {
    
    public func average<F>() throws -> F where F: FloatingPoint {
        guard self.hasElements else { throw AverageCollection.Error.empty }
        if E.isSigned {
            return self.reduce(F(numericCast(0) as Int64), { (res, next) -> F in
                return res + F(numericCast(next) as Int64)
            }) / F(numericCast(self.count) as Int64)
        }
        else {
            return self.reduce(F(numericCast(0) as UInt64), { (res, next) -> F in
                return res + F(numericCast(next) as UInt64)
            }) / F(numericCast(self.count) as UInt64)
        }
    }
    
    public func average<I>() throws -> I where I: SignedInteger {
        guard self.hasElements else { throw AverageCollection.Error.empty }
        return self.reduce(I(0), { (res, next) -> I in
            return res + I(next)
        }) / I(self.count)
    }
    
    public func median<F>() throws -> F where F: FloatingPoint {
        guard self.hasElements else { throw AverageCollection.Error.empty }
        let odd = self.count % 2 != 0
        if E.isSigned {
            if odd {
                return F(numericCast(self.middle!) as Int64)
            }
            else {
                return F(numericCast(self.lowerMiddle! + self.upperMiddle!) as Int64) / F(2)
            }
        }
        else {
            if odd {
                return F(numericCast(self.middle!) as UInt64)
            }
            else {
                return F(numericCast(self.lowerMiddle! + self.upperMiddle!) as UInt64) / F(2)
            }
        }
    }
}
