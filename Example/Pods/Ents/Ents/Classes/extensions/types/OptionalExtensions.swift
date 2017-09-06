//
//  OptionalExtensions.swift
//  Ents
//
//  Created by Georges Boumis on 11/08/2016.
//  Copyright © 2016-2017 Georges Boumis.
//  Licensed under MIT (https://github.com/averello/Ents/blob/master/LICENSE)
//

import Foundation

public extension Optional {
    
    /// indicates wether the Wrapped value is `nil`.
    public var optional: Bool {
        if let _ = self {
            return false
        }
        else {
            return true
        }
    }

    /// indicates wether the Wrapped value is not `nil`.
    public var nonOptional: Bool {
        return not(self.optional)
    }

    /// returns the wrapped value or the default if the wrapped value is `nil`.
    public func unwrap(defaultValue value: Wrapped) -> Wrapped {
        return self ?? value
    }
    
    /// converts an optional to a concrete value
    public mutating func materialize(_ materialize: () throws -> Wrapped) rethrows {
        if self.optional {
            self = try materialize()
        }
    }
}


infix operator !!

/// This operator unwraps an optional, if the optional is `nil` then it crashes
/// printing the givent text as a reason why it crashed
///
///     let i: Int? = nil
///     i !? "should not be `nil`" // crashes in DEBUG printing "should not be `nil`"
///
public func !!<T>(wrapped: T?, failureText: @autoclosure () -> String) -> T {
    if let x = wrapped { return x }
    fatalError(failureText())
}

infix operator !?

/// This operator unwraps an optional, if the optional is `nil` then it crashes
/// in DEBUG builds, printing the givent text as a reason why it crashed
///
///     let i: Int? = nil
///     i !! "should not be `nil`" // crashes printing "should not be `nil`"
///
//public func !?<T>(wrapped: T?, failureText: @autoclosure () -> String) -> T {
//    if let x = wrapped { return x }
//    assert(false, failureText())
//}
