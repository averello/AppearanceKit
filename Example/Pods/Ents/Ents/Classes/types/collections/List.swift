//
//  List.swift
//  Ents
//
//  Created by Georges Boumis on 09/05/2017.
//  Copyright © 2016-2017 Georges Boumis.
//  Licensed under MIT (https://github.com/averello/Ents/blob/master/LICENSE)
//

import Foundation

/// A simple linked list, private implementation
public struct List<Element>: Collection {
    public typealias Index = ListIndex<Element>
    
    public let startIndex: Index
    public let endIndex: Index
    
    public subscript(index: Index) -> Element {
        switch index.node {
        case .end: fatalError("Subscript out of range")
        case let .node(element, _): return element
        }
    }
    
    public func index(after i: Index) -> Index {
        switch i.node {
        case .end: fatalError("Subscript out of range")
        case let .node(_, next): return Index(node: next, tag: i.tag-1)
        }
    }
    
    public var count: Int {
        return self.startIndex.tag - self.endIndex.tag
    }
}

// creating
extension List: ExpressibleByArrayLiteral {
    
    public init(arrayLiteral elements: Element...) {
        self.startIndex = ListIndex(node: elements.reversed().reduce(.end) { $0.cons($1) },
                                    tag: elements.count)
        self.endIndex = ListIndex(node: .end, tag: 0)
    }
}

// slicing
extension List {
    public typealias SubSequence = List<Element>
    
    public subscript(bounds: Range<Index>) -> SubSequence {
        return List(startIndex: bounds.lowerBound,
                    endIndex: bounds.upperBound)
    }
}

public extension List {
    
    public func cons(_ element: Element) -> List<Element> {
        
        let startIndex = self.startIndex
        let newStartIndex = ListIndex(node: startIndex.node.cons(element),
                                      tag: startIndex.tag + 1)
        return List(startIndex: newStartIndex, endIndex: self.endIndex)
    }
    
    public func car() -> Element? {
        return self.startIndex.node.car()
    }
    
    public func cdr() -> List<Element> {
        let newStartIndex = ListIndex(node: self.startIndex.node.cdr(), tag: self.startIndex.tag-1)
        return List(startIndex: newStartIndex, endIndex: self.endIndex)
    }
}



//public extension List {
//    public init() { self = .end }
//
//    public init(_ element: Element) {
//        self = .node(element, next: .end)
//    }
//
//    /// Return a new list by prepending a node with value `element` to the
//    /// front of a list.
//    public func cons(_ element: Element) -> List<Element> {
//        return .node(element, next: self)
//    }
//
//    public func car() -> Element? {
//        switch self {
//        case .end: return nil
//        case let .node(element, _): return element
//        }
//    }
//
//    public func cdr() -> List<Element> {
//        switch self {
//        case .end: return .end
//        case let .node(_, next): return next
//        }
//    }
//}

extension List: CustomStringConvertible {
    
    public var description: String {
        let elements = self.map { String(describing: $0) }.joined(separator: ",")
        return "List[\(elements)]"
    }
}

extension List: Stack {
    
    public mutating func push(_ element: Element) {
        self = self.cons(element)
    }

    public mutating func pop() -> Element? {
        let element = self.car()
        self = self.cdr()
        return element
    }
}


//extension List {
//    public func == <E>(lhs: List<E>, rhs: List<E>) -> Bool where E: Equatable {
//        return lhs.elementsEqual(rhs)
//    }
//}



extension List: IteratorProtocol, Sequence {
    public mutating func next() -> Element? {
        return self.pop()
    }
}



public struct ListIndex<Element>: CustomStringConvertible {
    fileprivate let node: ListNode<Element>
    fileprivate let tag: Int
    
    public var description: String {
        return String(describing: type(of: self)) + "(\(self.tag))"
    }
}

extension ListIndex: Comparable {
    
    public static func == <T>(lhs: ListIndex<T>, rhs: ListIndex<T>) -> Bool {
        return (lhs.tag == rhs.tag)
    }
    
    public static func < <T>(lhs: ListIndex<T>, rhs: ListIndex<T>) -> Bool {
        // start index has the highest tag, endIndex the lowest
        return (lhs.tag > rhs.tag)
    }
}


//MARK: Private implementation of ListNode


fileprivate enum ListNode<Element> {
    case end
    indirect case node(Element, next: ListNode<Element>)
    
    func cons(_ element: Element) -> ListNode<Element> {
        return .node(element, next: self)
    }
    
    func car() -> Element? {
        switch self {
        case .end: return nil
        case let .node(element, _): return element
        }
    }
    
    func cdr() -> ListNode<Element> {
        switch self {
        case .end:
            return .end
        case let .node(_, next):
            return next
        }
    }
}


