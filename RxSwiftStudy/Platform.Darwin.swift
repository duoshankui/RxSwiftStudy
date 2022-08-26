//
//  Platform.Darwin.swift
//  RxSwiftStudy
//
//  Created by DoubleK on 2022/8/26.
//

import Foundation

extension Thread {
    static func setThreadLocalStorageValue<T: AnyObject>(_ value: T?, forKey key: NSCopying) {
        let currentThread = Thread.current
        let threadDictionary = currentThread.threadDictionary
        if let value = value {
            threadDictionary[key] = value
        } else {
            threadDictionary[key] = nil
        }
    }
    
    static func getThreadLocalStorageValueForKey<T>(_ key: NSCopying) -> T? {
        let currentThread = Thread.current
        let threadDictionary = currentThread.threadDictionary
        
        return threadDictionary[key] as? T
    }
}
