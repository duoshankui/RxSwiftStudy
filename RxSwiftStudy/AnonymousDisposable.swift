//
//  AnonymousDisposable.swift
//  RxSwiftStudy
//
//  Created by DoubleK on 2022/8/19.
//

import Foundation

private final class AnonymousDisposable: DisposeBase, Cancelable {
    var isDisposed: Bool {
        return false
    }
    
    typealias DisposeAction = () -> Void
    
    let disposeAction: DisposeAction
    
    fileprivate init(disposeAction: @escaping DisposeAction) {
        self.disposeAction = disposeAction
        super.init()
    }
    
    
    func dispose() {
        
    }
}

extension Disposables {
    static func create(with dispose: @escaping () -> Void) -> Cancelable {
        AnonymousDisposable(disposeAction: dispose)
    }
}
