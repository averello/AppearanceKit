//
//  OnceAudio.swift
//  ContentKit
//
//  Created by Georges Boumis on 30/05/2017.
//
//  Licensed to the Apache Software Foundation (ASF) under one
//  or more contributor license agreements.  See the NOTICE file
//  distributed with this work for additional information
//  regarding copyright ownership.  The ASF licenses this file
//  to you under the Apache License, Version 2.0 (the
//  "License"); you may not use this file except in compliance
//  with the License.  You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing,
//  software distributed under the License is distributed on an
//  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
//  KIND, either express or implied.  See the License for the
//  specific language governing permissions and limitations
//  under the License.
//

import Foundation

final public class OnceAudio: ContentKit.Audio {
    final fileprivate let audio: ContentKit.Audio
    final fileprivate var notPlayed = true
    
    public init(audio: ContentKit.Audio) {
        self.audio = audio
    }
    
    final public var duration: TimeInterval {
        return self.audio.duration
    }
    
    final public func play() {
        guard self.notPlayed else { return }
        self.audio.play()
        self.notPlayed = false
    }
    
    final public func stop(fadeOut: Bool) {
        self.audio.stop(fadeOut: fadeOut)
    }
}

extension OnceAudio: CustomStringConvertible {
    public var description: String {
        return "<"
            + String(describing: type(of: self))
            + ": \(Unmanaged.passUnretained(self));"
            + " played = \(!self.notPlayed);"
            + " audio = \(self.audio);"
            + ">"
    }
}
