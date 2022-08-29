//
//  AtomicInt.swift
//  RxSwiftStudy
//
//  Created by DoubleK on 2022/8/26.
//

import Foundation

final class AtomicInt: NSLock {
    fileprivate var value: Int32
    init(_ value: Int32 = 0) {
        self.value = value
    }
}

@discardableResult
func fetchOr(_ this: AtomicInt, _ make: Int32) -> Int32 {
    this.lock()
    let oldValue = this.value
    this.value |= make
    this.unlock()
    return oldValue
}

func load(_ this: AtomicInt) -> Int32 {
    this.lock()
    let oldValue = this.value
    this.unlock()
    return oldValue
}

func isFlagSet(_ this: AtomicInt, _ make: Int32) -> Bool {
    (load(this) & make) != 0
}
