//
//  Chronometer.swift
//  Ents
//
//  Created by Georges Boumis on 26/08/2016.
//  Copyright © 2016-2017 Georges Boumis.
//  Licensed under MIT (https://github.com/averello/Ents/blob/master/LICENSE)
//

import Foundation
import CoreFoundation

public struct Chronometer {
    private let start: CFAbsoluteTime

    public init() {
        self.start = CFAbsoluteTimeGetCurrent()
    }

    public var difference: CFTimeInterval {
        let end = CFAbsoluteTimeGetCurrent()
        return (end-start)
    }
}

extension Chronometer: CustomStringConvertible {
    public var description: String {
        let difference = self.difference
        return String(describing: type(of: self)) + "(\(difference)s)"
    }
}
