//
//  BoolExtensions.swift
//  Ents
//
//  Created by Georges Boumis on 09/08/2016.
//  Copyright © 2016-2017 Georges Boumis.
//  Licensed under MIT (https://github.com/averello/Ents/blob/master/LICENSE)
//

import Foundation

/// Free function that negates the boolean passed as argument.
/// May help readability of bool expressions.
///
///     if not(self.enabled) { // do something }
///
/// - parameter b: the boolean.
/// - returns: the passed argument but negated.
public func not(_ b: Bool) -> Bool {
    return b.not
}


/// Free function that returns `true` when the boolean passed as argument is 
/// `true`.
/// May help readability of bool expressions.
///
///     if does(self.concersEverything) { // do nothing }
///
/// - parameter b: the boolean.
/// - returns: `true` if the argument passed in is also `true`.
public func does(_ b: Bool) -> Bool {
    return (b == true)
}

/// Free function that returns `true` when the boolean passed as argument is
/// `false`.
/// May help readability of bool expressions.
///
///     if doesNot(self.createsConfusion) { // relax }
///
/// - parameter b: the boolean.
/// - returns: `true` if the argument passed in is `false`.
public func doesNot(_ b: Bool) -> Bool {
    return (b.not == true)
}

public extension Bool {
    
    /// Creating Bool from Integers.
    /// - parameter i: the integer. `0` means `false`. Any other value means `true`
    public init(_ i: Int) {
        if i == 0 {
            self = false
        }
        else {
            self = true
        }
    }

    /// Creating Bool from Integers.
    /// - parameter i: the integer. `0` means `false`. Any other value means `true`
    public init<I>(_ i: I) where I: BinaryInteger {
        self.init(numericCast(i) as Int)
    }
}

public extension Bool {
    
    /// Provides a more natural language interface to AND (`&&`).
    ///
    ///     true.and(false) // false
    ///
    /// - parameter other: another boolean to do an `&&`
    /// - returns: the result of AND-ing self and other
    public func and(_ other: @autoclosure () -> Bool) -> Bool {
        guard self else { return false }
        return other()
    }

    /// Provides a more natural language interface to OR (`||`).
    ///
    ///     true.or(false) // true
    ///
    /// - parameter other: another boolean to do an `||`
    /// - returns: the result of OR-ing self and other
    public func or(_ other: Bool) -> Bool {
        return self || other
    }

    /// Provides a more natural language interface to `!=`.
    ///
    ///     true.different(false) // true
    ///
    /// - parameter other: another boolean to do a differnet than `!=` comparison.
    /// - returns: `true` if the booleans are different, otherwise `false`.
    public func different(than other: Bool) -> Bool {
        return self != other
    }

    /// Provides a more natural language interface to NOT (`!`).
    ///
    ///     true.not // false
    ///
    /// - returns: the NOT-ed boolean as in '!'.
    public var not: Bool {
        return !self
    }
}

public extension Bool {

    /// Provides a more natural language interface to NOT (`!`).
    ///
    ///     true.negated // false
    ///
    /// - returns: the NOT-ed boolean as in '!'.
    public var negated: Bool {
        return self.not
    }

    /// Negate (NOT) the Boolean.
    ///
    ///     var b = true
    ///     b.negate()
    ///     b // false
    ///
    public mutating func negate() {
        self = self.not
    }
}

public extension Bool {
    
    /// OR the receiver with another Bool.
    ///
    ///     var b = false
    ///     b.orWith(true)
    ///     b // true
    ///
    public mutating func orWith(_ other: Bool) {
        self = self.or(other)
    }
    
    /// AND the receiver with another Bool.
    ///
    ///     var b = false
    ///     b.andWith(true)
    ///     b // false
    ///
    public mutating func andWith(_ other: Bool) {
        self = self.and(other)
    }
}

public extension Bool {
    
    /// Evaluates the given closure when this `Bool` instance is `true`.
    /// It's like `map(:)` of Optional<Wrapped>.
    ///
    ///     var b = true
    ///     b.ifTrue { // do work }
    ///
    public func ifTrue(_ block: () -> Void) {
        if self {
            block()
        }
    }

    /// Evaluates the given closure when this `Bool` instance is `true`.
    /// It's like `map(:)` of Optional<Wrapped>.
    ///
    ///     var condition = true
    ///     condition.isTrue { // do work }
    ///
    public func isTrue(_ block: () -> Void) {
        self.ifTrue(block)
    }

    /// Evaluates `iblock` when this `Bool` instance is `true`, and evaluates
    /// `eblock` when this `Bool` instance is `false`.
    ///
    ///     var condition = /* some boolean value *.
    ///     confition.ifTrue({
    ///         // true
    ///     }, else: {
    ///         // false
    ///     })
    ///
    public func ifTrue(_ iblock: () -> Void, else eblock: () -> Void) {
        if self {
            iblock()
        } else {
            eblock()
        }
    }

    /// Evaluates the given closure when this `Bool` instance is `false`.
    ///
    ///     var condition = true
    ///     condition.ifFalse { // do work }
    ///
    public func ifFalse(_ block: () -> Void) {
        if self.not {
            block()
        }
    }

    /// Evaluates the given closure when this `Bool` instance is `false`.
    ///
    ///     var condition = true
    ///     condition.isFalse { // do work }
    ///
    public func isFalse(_ block: () -> Void) {
        self.ifFalse(block)
    }

    /// Evaluates `iblock` when this `Bool` instance is `false`, and evaluates
    /// `eblock` when this `Bool` instance is `true`.
    ///
    ///     var condition = /* some boolean value *.
    ///     confition.ifFalse({
    ///         // true
    ///     }, else: {
    ///         // false
    ///     })
    ///
    public func ifFalse(_ iblock: () -> Void, else eblock: () -> Void) {
        if self.not {
            iblock()
        }
        else {
            eblock()
        }
    }
}

public extension Bool {
    
    /// Evaluates the given closure when this `Bool` instance is `true`.
    ///
    ///     var condition = true
    ///     let res = confition.map {
    ///         return "true"
    ///     }
    ///     res // Optional("true")
    ///
    ///     var condition = false
    ///     let res = confition.map {
    ///         return "true"
    ///     }
    ///     res // nil
    ///
    @discardableResult
    public func map<U>(_ transform: () throws -> U) rethrows -> U? {
        if self {
            return try transform()
        }
        return nil
    }
}
