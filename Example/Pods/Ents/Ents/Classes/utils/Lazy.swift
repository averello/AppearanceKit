//
//  Lazy.swift
//  Ents
//
//  Created by Georges Boumis on 11/08/2016.
//  Copyright © 2016-2017 Georges Boumis.
//  Licensed under MIT (https://github.com/averello/Ents/blob/master/LICENSE)
//

import Foundation

public final class Lazy<T> {
    final private var _thing: T? = nil

    public typealias InitializeBlock = () -> T
	public typealias PropertyBlock = (T) -> Void

    final private let initializeBlock: InitializeBlock
    final private let invalidateBlock: PropertyBlock

    public final var initialized: Bool {
        return self._thing.nonOptional
    }
    
    public init(initialize: @escaping InitializeBlock, invalidate: @escaping PropertyBlock) {
        self.initializeBlock = initialize
        self.invalidateBlock = invalidate
    }
    
    public final var property: T {
        if self._thing.optional {
            self._thing = self.initializeBlock()
        }
        return self._thing!
    }

    public final func invalidate() {
        guard self._thing.nonOptional else { return }
        self.invalidateBlock(self.property)
        self._thing = nil        
    }
}
