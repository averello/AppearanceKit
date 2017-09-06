//
//  Weak.swift
//  Ents
//
//  Created by Georges Boumis on 30/09/2016.
//  Copyright © 2016-2017 Georges Boumis.
//  Licensed under MIT (https://github.com/averello/Ents/blob/master/LICENSE)
//

import Foundation

public final class Weak<Reference: AnyObject> {
    
    public weak var value: Reference?
    
    public init(_ value: Reference) {
        self.value = value
    }
}
