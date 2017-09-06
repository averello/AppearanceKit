//
//  ReadabilityUtilities.swift
//  Ents
//
//  Created by Georges Boumis on 17/08/2016.
//  Copyright © 2016-2017 Georges Boumis.
//  Licensed under MIT (https://github.com/averello/Ents/blob/master/LICENSE)
//

import Foundation

public func by<Element>(_ element: Element) -> Element {
    return element
}

public func with<Element>(_ o: Element, _ block: (inout Element) -> Void) -> Element {
    var e = o
    block(&e)
    return e
}
