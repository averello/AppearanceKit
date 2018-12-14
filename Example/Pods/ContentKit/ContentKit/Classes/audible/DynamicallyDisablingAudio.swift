//
//  DynamicallyDisablingAudio.swift
//  ContentKit
//
//  Created by Georges Boumis on 02/08/2017.
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

/// An audio that can be dynamically be enabled or disabled.
///
/// A disabled audio results to a `noop` when `play()` or `stop()` is invoked.
///
/// There is a known gray behaviour area: When a started audio gets dynamically
/// disabled then the `stop(fadeOut:)` has no effect. You should re-enable the
/// receiver in order to effectively stop it.
final public class DynamicallyDisablingAudio: ContentKit.Audio {
    final private let audio: ContentKit.Audio

    /// A Boolean value indicating whether the audio is enabled.
    final public var enabled: Bool

    /// - parameter audio: The audio to decorate with dynamic behaviour.
    /// - parameter enabled: A Boolean indiacating the initial state of the
    /// receiver.
    public init(audio: ContentKit.Audio, enabled: Bool = true) {
        self.audio = audio
        self.enabled = enabled
    }
    
    final public var duration: TimeInterval {
        return self.audio.duration
    }

    /// Begins playback of the receiver if enabled otherwise nothing happens.
    final public func play() {
        guard self.enabled else { return }
        self.audio.play()
    }

    /// Begins playback of the receiver if enabled otherwise nothing happens.
    final public func stop(fadeOut: Bool) {
        guard self.enabled else { return }
        self.audio.stop(fadeOut: fadeOut)
    }
}
