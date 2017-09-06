//
//  Alarm.swift
//  Ents
//
//  Created by Georges Boumis on 10/08/2016.
//  Copyright © 2016-2017 Georges Boumis.
//  Licensed under MIT (https://github.com/averello/Ents/blob/master/LICENSE)
//

import Foundation

public final class Alarm {
    final fileprivate let notifyBlock: (() -> Void)!
    final fileprivate var lazyTimer: Lazy<Timer>!
    final let queue: DispatchQueue
    final let interval: TimeInterval
    final let tolerance: TimeInterval
    final let repeats: Bool
    final let userInfo: AnyObject?
    final let name: String
    
    fileprivate enum State {
        case scheduled
        case idle
    }
    final fileprivate var state: Alarm.State = Alarm.State.idle
    
    /// An Alarm that fires after a specified interval of time
    public init(interval: TimeInterval = 1,
                tolerance: TimeInterval = 0,
                repeats: Bool = false,
                name: String = "",
                userInfo: AnyObject? = nil,
                queue: DispatchQueue = DispatchQueue.main,
                _ notifyBlock: @escaping () -> Void) {
        self.notifyBlock = notifyBlock
        self.interval    = interval
        self.repeats     = repeats
        self.tolerance   = tolerance
        self.queue       = queue
        self.userInfo    = userInfo
        self.name        = name
        
        assert(not(self.name.isEmpty),
               "Ents.Alarm: please name your alarms.")
        
        self.lazyTimer = Lazy<Timer>(initialize: { [unowned self] in
            // should use [unowned self] but it leaks
            return Timer(timeInterval: self.interval,
                         target: self,
                         selector: #selector(self._timerFired),
                         userInfo: self.userInfo,
                         repeats: self.repeats)
            }, invalidate: { (timer) in
                timer.invalidate()
        })
    }

    
    /// An Alarm that fires on a specific date
    /// - Parameter date: a date in the future, otherwise the initializer fails
    public convenience init?(date: Date,
                             tolerance: TimeInterval = 0,
                             name: String = "",
                             userInfo: AnyObject? = nil,
                             queue: DispatchQueue = DispatchQueue.main,
                             _ notifyBlock: @escaping () -> Void) {
        let interval = date.timeIntervalSinceNow
        guard interval > 0 else { return nil }
        self.init(interval: interval,
                  tolerance: tolerance,
                  repeats: false,
                  name: name,
                  userInfo: userInfo,
                  queue: queue,
                  notifyBlock)
    }

    deinit {
        self._cancel()
    }

    public final func schedule() {
        self._perform {
            self._schedule()
        }
    }

    public final func cancel() {
        self._perform {
            self._cancel()
        }
    }
}

// Swift 3
fileprivate extension DispatchQueue {
    
    fileprivate class var _currentLabel: String {
        return String(validatingUTF8: __dispatch_queue_get_label(nil))!
    }
}

extension Alarm {

    @objc final fileprivate func _timerFired(_ timer: Timer) {
        guard timer.isValid else {
            self.state = Alarm.State.idle
            return
        }
        self.notifyBlock()
        if self.repeats == false { self.state = Alarm.State.idle }
    }

    final fileprivate func _perform(_ block: @escaping () -> Void) {
        if (self.queue.label == DispatchQueue._currentLabel) {
            block()
        }
        else {
            self.queue.sync { [weak self] in
                guard let _ = self else { return }
                block()
            }
        }
    }

    final fileprivate func _schedule() {
        guard self.state == Alarm.State.idle else { return }
        RunLoop.current.add(self.lazyTimer.property,
                            forMode: RunLoopMode.commonModes)
        self.state = Alarm.State.scheduled
    }

    final fileprivate func _cancel() {
        self.lazyTimer.invalidate()
        self.state = Alarm.State.idle
    }
}
