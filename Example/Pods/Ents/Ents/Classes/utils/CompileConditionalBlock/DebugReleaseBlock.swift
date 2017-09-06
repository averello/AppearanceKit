//
//  DebugReleaseBlock.swift
//  Ents
//
//  Created by Georges Boumis on 26/08/2016.
//  Copyright © 2016-2017 Georges Boumis.
//  Licensed under MIT (https://github.com/averello/Ents/blob/master/LICENSE)
//

import Foundation

//public protocol CompileCondition {}
//
//public protocol Debug: CompileCondition {}
//public protocol Release: CompileCondition {}
//
//public func CompileConditionalBlock<T: CompileCondition>(_ block: () throws -> T, alternative: (() throws -> T)? = nil) rethrows {
//    if T is Debug {
//        return try block()
//    }
//    else {
//        return try alternative.unwrap(defaultValue: {return T})
//    }
//}

public func DebugBlock(_ block: () throws -> Void) rethrows {
    #if DEBUG
        try block()
    #endif
}

public func ReleaseBlock(_ block: () throws -> Void) rethrows {
    #if DEBUG
    #else
        try block()
    #endif
}

public func DebugReleaseBlock(debug: () throws -> Void, release: () throws -> Void) rethrows {
    #if DEBUG
        try debug()
    #else
        try release()
    #endif
}
