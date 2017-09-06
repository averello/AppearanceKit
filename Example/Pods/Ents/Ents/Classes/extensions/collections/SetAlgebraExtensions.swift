//
//  SetAlgebraExtensions.swift
//  Ents
//
//  Created by Georges Boumis on 22/03/2017.
//  Copyright © 2016-2017 Georges Boumis.
//  Licensed under MIT (https://github.com/averello/Ents/blob/master/LICENSE)
//

import Foundation

public extension SetAlgebra {
    
    /// inverted .contains
    public func doesNotContain(_ element: Self.Element) -> Bool {
        return doesNot(self.contains(element))
    }
}
