//
//  BinaryDisposable.swift
//  RxSwiftStudy
//
//  Created by DoubleK on 2022/8/18.
//

import Foundation

private final class BinaryDisposable: DisposeBase, Cancelable {
    var isDisposed: Bool {
        return false
    }
    
    private let disposable1: Disposable
    private let disposable2: Disposable
    
    init(_ disposable1: Disposable, _ disposable2: Disposable) {
        self.disposable1 = disposable1
        self.disposable2 = disposable2
        super.init()
    }
    
    func dispose() {
        
    }
}

extension Disposables {
    static func create(_ disposable1: Disposable, _ disposable2: Disposable) -> Cancelable {
        BinaryDisposable(disposable1, disposable2)
    }
}
