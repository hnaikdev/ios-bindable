//
//  ConcurrentLockBindable.swift
//  ios-bindable
//
//  Created by Hiral Naik on 1/5/26.
//

import Foundation

public final class ConcurrentLockBindable<Value> {
    
    public typealias Listener = (Value?) -> Void
    
    private var localValue: Value?
    private var listeners: [Listener?] = []
    private let lock: NSLock = NSLock()
    
    public init(_ value: Value?) {
        self.localValue = value
    }
    
    public var value: Value? {
        get {
            lock.lock()
            defer {
                lock.unlock()
            }
            return localValue
        } set {
            let myListeners: [Listener?]
            let myValue: Value?
            lock.lock()
            localValue = newValue
            myListeners = listeners
            myValue = localValue
            lock.unlock()
            myListeners.forEach { $0?(myValue) }
        }
    }
    
    public func bind(_ listener: Listener?) {
        lock.lock()
        listeners.append(listener)
        lock.unlock()
    }
    
    public func bindAndFire(_ listener: Listener?) {
        let myValue: Value?
        lock.lock()
        listeners.append(listener)
        myValue = localValue
        lock.unlock()
        listener?(myValue)
    }
    
    public func clearListeners() {
        lock.lock()
        listeners.removeAll()
        lock.unlock()
    }
}
