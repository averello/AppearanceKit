//
//  DisplayLinkBlock.swift
//  Ents
//
//  Created by Georges Boumis on 05/09/2016.
//  Copyright © 2016-2017 Georges Boumis.
//  Licensed under MIT (https://github.com/averello/Ents/blob/master/LICENSE)
//

import Foundation
import QuartzCore

public final class DisplayLinkBlock {
	public typealias DisplayLinkLoopBlock = (TimeInterval) -> Void
	public init(preferredFramesPerSecond: Int = 60, loop: @escaping DisplayLinkLoopBlock) {
		self.block = loop
		self.link  = CADisplayLink(target: self, selector: #selector(self._loop))
        self.preferredFramesPerSecond = preferredFramesPerSecond

		self._registerForNotifications()
		self._setupDisplayLink()
		self._start()
	}

	deinit {
		self._invalidate()
		NotificationCenter.default.removeObserver(self)
	}

	public final func pause() {
		self._pause()
	}

    public final func resume() {
        self._resume()
    }

	// alias of pause
	public final func stop() {
		self._invalidate()
	}

	final fileprivate var block: DisplayLinkLoopBlock
    final fileprivate var link: CADisplayLink!
    final public private(set) var preferredFramesPerSecond: Int {
		get {
			if #available(iOS 10.0, *) {
				return self.link.preferredFramesPerSecond
			} else {
                return 60.divided(by: self.link.frameInterval)
			}
		}
		set {
			if #available(iOS 10.0, *) {
				self.link.preferredFramesPerSecond = newValue
			} else {
                self.link.frameInterval = 60.divided(by: newValue)
			}
		}
    }
}

extension DisplayLinkBlock {
    final fileprivate func _pause() {
        self.link?.isPaused = true
    }

    final fileprivate func _resume() {
        self.link?.isPaused = false
    }

    // alias of resume
    final fileprivate func _start() {
        self._resume()
    }

    final fileprivate func _invalidate() {
        self.pause()
        self.link?.invalidate()
        self.link = nil
    }
}

extension DisplayLinkBlock {
    @objc final private func _willEnterForeground(_ notification: Notification) {
        self._resume()
    }

    @objc final private func _didEnterBackground(_ notification: Notification) {
        self._pause()
    }

    @objc final fileprivate func _loop(_ displayLink: CADisplayLink) {
        let timestamp = TimeInterval(displayLink.timestamp)
        self.block(timestamp)
    }

    final fileprivate func _setupDisplayLink() {
        self.pause()
        self.link.add(to: RunLoop.current, forMode: RunLoopMode.defaultRunLoopMode)
    }

    final fileprivate func _registerForNotifications() {
        let nc = NotificationCenter.default
        nc.addObserver(self,
                       selector: #selector(self._willEnterForeground),
                       name: NSNotification.Name.UIApplicationWillEnterForeground,
                       object: nil)
        nc.addObserver(self,
                       selector: #selector(self._didEnterBackground),
                       name: NSNotification.Name.UIApplicationDidEnterBackground,
                       object: nil)
    }
}
