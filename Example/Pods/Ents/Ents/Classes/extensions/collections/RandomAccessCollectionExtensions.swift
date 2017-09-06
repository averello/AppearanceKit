//
//  RandomAccessCollection.swift
//  Ents
//
//  Created by Georges Boumis on 22/03/2017.
//  Copyright © 2016-2017 Georges Boumis.
//  Licensed under MIT (https://github.com/averello/Ents/blob/master/LICENSE)
//

import Foundation

public extension RandomAccessCollection where IndexDistance: Integer {
    
    
    /// the middle element of an odd sized collection.
    /// - Note: only returns an element if the collection has elements and
    /// the count is an odd number
    public var middle: Self.Iterator.Element? {
        guard self.hasElements else { return nil }
        
        let odd = (self.count % 2 != 0)
        let even = not(odd)
        
        if odd {
            if let middle = self._oddMiddleIndex {
                return self[middle]
            }
        }
        if even {
            return self.lowerMiddle
        }
        return nil
    }
    
    
    /// the lower middle element of an even sized collection.
    public var lowerMiddle: Self.Iterator.Element? {
        guard self.hasElements else { return nil }
        guard self.count % 2 == 0 else { return nil }
        
        if let middle = self._evenMiddleIndex {
            return self[self.index(before: middle)]
        }
        return nil
    }
    
    /// the upper middle element of an even sized collection.
    public var upperMiddle: Self.Iterator.Element? {
        guard self.hasElements else { return nil }
        guard self.count % 2 == 0 else { return nil }
        
        if let middle = self._evenMiddleIndex {
            return self[middle]
        }
        return nil
    }
    
    
    
    private var _oddMiddleIndex: Self.Index? {
        guard self.hasElements else { return nil }
        if self.count % 2 == 0 {
            return nil
        }
        let count = self.count
        let offset = Self.IndexDistance((count/2).toIntMax())
        return self.index(self.startIndex, offsetBy: offset)
    }
    
    private var _evenMiddleIndex: Self.Index? {
        guard self.hasElements else { return nil }
        
        let count = self.count
        let offset = Self.IndexDistance((count/2).toIntMax())
        return self.index(self.startIndex, offsetBy: offset)
    }
}

public extension RandomAccessCollection {
    
    /// a "safe" accesor of elements in a `RandomAccessColelction` instance.
    public func element(atIndex i: Self.Index) -> Self.Iterator.Element? {
        guard i < self.endIndex && i >= self.startIndex else { return nil }
        return self[i]
    }
    
    /// returns a random element of the collection.
    public var randomElement: Self.Iterator.Element? {
        guard self.hasElements else { return nil }
        guard self.count > 1 else { return self[self.startIndex] } // optimization
        
        let random = Self.IndexDistance(arc4random_uniform(UInt32(self.count.toIntMax())).toIntMax())
        let index = self.index(self.startIndex, offsetBy: random)
        return self.element(atIndex: index)
    }
}


