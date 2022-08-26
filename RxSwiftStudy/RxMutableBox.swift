//
//  RxMutableBox.swift
//  RxSwiftStudy
//
//  Created by DoubleK on 2022/8/26.
//

import Foundation

final class RxMutableBox<T>: CustomDebugStringConvertible {
    var value: T
    init(_ value: T) {
        self.value = value
    }
    
}

extension RxMutableBox {
    var debugDescription: String {
        "MutatingBox(\(self.value))"
    }
}
