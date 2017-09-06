//
//  BidirectionalCollectionExtensions.swift
//  Ents
//
//  Created by Georges Boumis on 13/06/2017.
//  Copyright © 2016-2017 Georges Boumis.
//  Licensed under MIT (https://github.com/averello/Ents/blob/master/LICENSE)
//

import Foundation

public extension BidirectionalCollection {
    
    /// The "just before past the end" position for the set---that is, the
    /// position equal to the last valid subscript argument.
    ///
    /// If the set is empty, `endIndex` is equal to `startIndex`.
    public var lastIndex: Index {
        return self.index(self.endIndex, offsetBy: Self.IndexDistance(-1.toIntMax()))
    }
}
