//
//  FIFO.swift
//  Ents
//
//  Created by Georges Boumis on 09/05/2017.
//  Copyright © 2016-2017 Georges Boumis.
//  Licensed under MIT (https://github.com/averello/Ents/blob/master/LICENSE)
//

import Foundation

/// An efficient variable-size FIFO queue of elements of type 'Element'
public struct FIFO<Element>: Queue {
    
    fileprivate var left: Array<Element>
    fileprivate var right: Array<Element>
    
    public typealias Indices = CountableRange<Int>
    public var indices: Indices {
        return self.startIndex..<self.endIndex
    }
    
    public init() {
        self.init(left: [], right: [])
    }
    fileprivate init(left: Array<Element>, right: Array<Element>) {
        self.left = left
        self.right = right
    }
    
    //MARK: Queue conformance
    /// Add an element to the back of the queue.
    /// - Parameter element: the element to enqueue
    /// - Complexity: O(1)
    public mutating func enqueue(_ element: Element) {
        self.right.append(element)
    }
    
    /// Removes front of the queue.
    /// - Returns: the front element of the queue or 'nil' in case of an empty queue
    /// - Complexity: O(1)
    public mutating func dequeue() -> Element? {
        if self.left.isEmpty {
            self.left = self.right.reversed()
            self.right.removeAll()
        }
        return self.left.popLast()
    }
    
    
    //MARK: Collection conformance
    public var startIndex: Int { return 0 }
    public var endIndex: Int { return self.left.count + self.right.count }
    
    public func index(after i: Int) -> Int {
        precondition(i < self.endIndex)
        return i + 1
    }
    
    public subscript(_ index: Int) -> Element {
        precondition((0..<self.endIndex).contains(index), "Index out of bounds")
        if index < self.left.endIndex {
            return self.left[self.left.count - index - 1]
        }
        return self.right[index - self.left.endIndex]
    }
}

extension FIFO: ExpressibleByArrayLiteral {
    
    public init(arrayLiteral elements: Element...) {
        self.init(left: elements.reversed(), right: [])
    }
}

extension FIFO: CustomStringConvertible {
    
    public var description: String {
        let elements = self.left.flatMap { $0 } + self.right.flatMap { $0 }
        return String(describing: type(of: self)) + "\(elements)"
    }
}

extension FIFO: CustomPlaygroundQuickLookable {
    
    public var customPlaygroundQuickLook: PlaygroundQuickLook {
        return PlaygroundQuickLook.text(self.description)
    }
}
