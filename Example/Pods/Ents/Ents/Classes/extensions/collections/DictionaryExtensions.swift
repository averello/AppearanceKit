//
//  DictionaryExtensions.swift
//  Ents
//
//  Created by Georges Boumis on 22/03/2017.
//  Copyright © 2016-2017 Georges Boumis.
//  Licensed under MIT (https://github.com/averello/Ents/blob/master/LICENSE)
//

import Foundation

public extension Dictionary {
    
    /// Merges two dictionaries or a dictionary with a sequence of key-value pairs
    public mutating func merge<S>( _ other: S) where S: Sequence, S.Iterator.Element == Dictionary.Element {
        for (key,value) in other {
            self[key] = value
        }
    }
    
    /// Creates a merged dictionary by merging with another dictionary or with a
    /// sequence of key-value pairs
    public func merging<S>( _ other: S) -> [Key: Value] where S: Sequence, S.Iterator.Element == Dictionary.Element {
        var dict = self
        dict.merge(other)
        return dict
    }
}

public extension Dictionary {
    
    /// Creates a dictionary from a sequence of key-value pairs
    public init<S: Sequence>(_ sequence: S) where S.Iterator.Element == Dictionary.Element {
        self = [:]
        self.merge(sequence)
    }
}

public extension Dictionary {
    
    /// Creates a new dictionary transforming the Values into NewValues using the transform
    /// - parameter transform: a closure that transforms the values of the Dictionary
    /// - returns: a new dictionary with its values transformed
    public func mapValues<NewValue>(transform: (Value) -> (NewValue)) -> Dictionary<Key, NewValue> {
        return Dictionary<Key,NewValue>(self.map { (key,value) in
            return (key, transform(value))
        })
    }
}

public extension Dictionary {
    
    /// Creates a new dictionary that contains the updated (key,value) pair
    public func updating(withKey key: Key, value: Value) -> Dictionary<Key, Value> {
        return self.merging([key: value])
    }
}
