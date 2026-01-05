//
//  ConcurrentQueueBindable.swift
//  ios-bindable
//
//  Created by Hiral Naik on 1/5/26.
//

import Foundation

public final class ConcurrentQueueBindable<Value: Sendable>: @unchecked Sendable {
    
    public typealias Listener = @Sendable (Value?) -> Void
    
    private var localValue: Value?
    private var listeners: [Listener?] = []
    private let queue = DispatchQueue(label: "ConcurrentQueueBindable.queue", attributes: .concurrent)
    
    public init(_ value: Value?) {
        self.localValue = value
    }
    
    public var value: Value? {
        get {
            queue.sync {
                localValue
            }
        } set {
            var myListeners: [Listener?] = []
            queue.sync(flags: .barrier) {
                localValue = newValue
                myListeners = listeners
            }
            myListeners.forEach { $0?(newValue) }
        }
    }
    
    public func bind(_ listener: Listener?) {
        queue.async(flags: .barrier) {
            self.listeners.append(listener)
        }
    }
    
    public func bindAndFire(_ listener: Listener?) {
        var myValue: Value?
        queue.sync(flags: .barrier) {
            self.listeners.append(listener)
            myValue = self.localValue
        }

        listener?(myValue)
    }
    
    public func clearListeners() {
        queue.async(flags: .barrier) {
            self.listeners.removeAll()
        }
    }
}
