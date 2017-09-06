//
//  AverageCollection.swift
//  Ents
//
//  Created by Georges Boumis on 25/08/2017.
//  Copyright © 2016-2017 Georges Boumis.
//  Licensed under MIT (https://github.com/averello/Ents/blob/master/LICENSE)
//

import Foundation

public struct AverageCollection<E>: RangeReplaceableCollection, RandomAccessCollection where E: Integer {
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



extension AverageCollection where E: SignedInteger {
    
    public func average<F>() throws -> F where F: FloatingPoint {
        guard self.hasElements else { throw AverageCollection.Error.empty }
        return self.reduce(F(0.toIntMax()), { (res, next) -> F in
            return res + F(next.toIntMax())
        }).divided(by: F(self.count.toIntMax()))
    }
    
    public func average<I>() throws -> I where I: SignedInteger {
        guard self.hasElements else { throw AverageCollection.Error.empty }
        return self.reduce(I(0.toIntMax()), { (res, next) -> I in
            return res + I(next.toIntMax())
        }).divided(by: I(self.count.toIntMax()))
    }
    
    public func median<F>() throws -> F where F: FloatingPoint {
        guard self.hasElements else { throw AverageCollection.Error.empty }
        let odd = self.count % 2 != 0
        if odd {
            return F(self.middle!.toIntMax())
        }
        else {
            return F(self.lowerMiddle!.toIntMax() + self.upperMiddle!.toIntMax())
                .divided(by: F(2.toIntMax()))
        }
    }
}

extension AverageCollection where E: UnsignedInteger {
    
    public func average<F>() throws -> F where F: FloatingPoint {
        guard self.hasElements else { throw AverageCollection.Error.empty }
        return self.reduce(F(UInt(0).toUIntMax()), { (res, next) -> F in
            return res + F(next.toUIntMax())
        }).divided(by: F(UIntMax(self.count.toIntMax())))
    }
    
    public func average<U>() throws -> U where U: UnsignedInteger {
        guard self.hasElements else { throw AverageCollection.Error.empty }
        return self.reduce(U(UInt(0).toUIntMax()), { (res, next) -> U in
            return res + U(next.toUIntMax())
        }).divided(by: U(UIntMax(self.count.toIntMax())))
    }
    
    public func median<F>() throws -> F where F: FloatingPoint {
        guard self.hasElements else { throw AverageCollection.Error.empty }
        let odd = self.count % 2 != 0
        if odd {
            return F(self.middle!.toUIntMax())
        }
        else {
            return F(self.lowerMiddle!.toUIntMax() + self.upperMiddle!.toUIntMax())
                .divided(by: F(2.toIntMax()))
        }
    }
}
