//
//  Bindable.swift
//  ios-bindable
//
//  Created by Hiral Naik on 1/5/26.
//

import Foundation

public final class Bindable<Value> {
    
    public typealias Listener = (Value?) -> Void
    
    fileprivate var listeners = [Listener?]()
    
    public init(value: Value?) {
        self.value = value
    }
    
    public var value: Value? {
        didSet {
            fire()
        }
    }
    
    public func bind(_ listener: Listener?) {
        listeners.append(listener)
    }
    
    public func bindAndFire(_ listener: Listener?) {
        bind(listener)
        listener?(value)
    }
    
    public func fire() {
        listeners.forEach { listener in
            listener?(value)
        }
    }
    
    public func clearListeners() {
        listeners.removeAll()
    }
}
