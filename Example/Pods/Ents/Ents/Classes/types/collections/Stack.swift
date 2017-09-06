//
//  Stack.swift
//  Ents
//
//  Created by Georges Boumis on 10/05/2017.
//  Copyright © 2016-2017 Georges Boumis.
//  Licensed under MIT (https://github.com/averello/Ents/blob/master/LICENSE)
//

import Foundation

/// A LIFO stack type with constant-time push and pop operations
public protocol Stack {
    /// The type of element held stored in the stack
    associatedtype Element
    
    /// Pushes `element` onot the top of `self`
    /// - Complexity: O(1)
    mutating func push(_ element: Element)
    
    /// Removes the topmast element of `self` and returns it.
    /// or `nil` if `self` is empty.
    /// - Complexity: O(1)
    mutating func pop() -> Element?
}

extension Array: Stack {
    public mutating func push(_ element: Element) {
        self.append(element)
    }
    public mutating func pop() -> Element? {
        return self.popLast()
    }
}
