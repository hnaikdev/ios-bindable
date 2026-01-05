//
//  ConcurrentActorBindable.swift
//  ios-bindable
//
//  Created by Hiral Naik on 1/5/26.
//

import Foundation

public actor ConcurrentActorBindable<Value> {
    
    public typealias Listener = (Value?) -> Void
    
    private var localValue: Value?
    private var listeners: [Listener?] = []
    
    public init(_ value: Value?) {
        self.localValue = value
    }
    
    public var value: Value? {
        get {
            localValue
        } set {
            localValue = newValue
            let myListeners = listeners
            for listener in myListeners {
                listener?(newValue)
            }
        }
    }
    
    public func bind(_ listener: Listener?) {
        listeners.append(listener)
    }
    
    public func bindAndFire(_ listener: Listener?) {
        listeners.append(listener)
        listener?(localValue)
    }

    public func clearListeners() {
        listeners.removeAll()
    }
}
