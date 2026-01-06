//
//  ViewModel.swift
//  BindableExample
//
//  Created by Hiral Naik on 1/6/26.
//

import ios_bindable

final class ViewModel {

    let title: Bindable<String> = Bindable(value: "Counter")
    let count: Bindable<Int> = Bindable(value: 0)
    
    func update(isIncrement: Bool) {
        increment(isIncrement: isIncrement)
        randomString(length: count.value ?? 0)
    }
    
    private func increment(isIncrement: Bool) {
        switch isIncrement {
        case true:
            count.value = (count.value ?? 0) + 1
        case false:
            if let value = count.value, value < 1 {
                count.value = 0
            } else {
                count.value = (count.value ?? 0) - 1
            }
        }
        
    }
    
    private func randomString(length: Int) {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        title.value = String((0..<length).map{ _ in letters.randomElement()! })
    }
}
