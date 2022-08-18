//
//  Lock.swift
//  RxSwiftDemo
//
//  Created by DoubleK on 2022/8/17.
//

import Foundation

typealias RecursiveLock = NSRecursiveLock

/// 自旋锁
typealias SpinLock = RecursiveLock

extension RecursiveLock {
    func performLocked<T>(_ action: () -> T) -> T {
        self.lock()
        defer {
            self.unlock()
        }
        return action()
    }
}
