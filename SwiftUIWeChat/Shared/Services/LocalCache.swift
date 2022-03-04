//
//  LocalCache.swift
//  SwiftUIWeChat
//
//  Created by peak on 2022/3/4.
//

import SwiftUI

@propertyWrapper
struct LocalCache<Value> {
    private let key: String
    private let defaultValue: Value
    var storage: UserDefaults
    
    init(_ key: String, wrappedValue defaultValue: Value, storage: UserDefaults = .standard) {
        self.defaultValue = defaultValue
        self.key = key
        self.storage = storage
    }
    
    var wrappedValue: Value {
        get {
            let value = storage.value(forKey:key) as? Value
            return value ?? defaultValue
        }
        set {
            storage.setValue(newValue, forKey: key)
        }
    }
    
}
