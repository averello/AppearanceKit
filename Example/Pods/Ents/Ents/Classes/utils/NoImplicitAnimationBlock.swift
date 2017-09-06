//
//  NoImplicitAnimationBlock.swift
//  Ents
//
//  Created by Georges Boumis on 06/09/2016.
//  Copyright © 2016-2017 Georges Boumis.
//  Licensed under MIT (https://github.com/averello/Ents/blob/master/LICENSE)
//

import Foundation

public func NoImplicitAnimation(_ block: () throws -> Void) rethrows {
    CATransaction.begin(); defer { CATransaction.commit() }
    CATransaction.setDisableActions(true)
    try block()
}

public func ImplicitAnimation(withDuration duration: CFTimeInterval, _ block: () throws -> Void) rethrows {
    CATransaction.begin(); defer { CATransaction.commit() }
    CATransaction.setAnimationDuration(duration)
    try block()
}
