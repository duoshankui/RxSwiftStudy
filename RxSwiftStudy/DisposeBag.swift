//
//  DisposeBag.swift
//  RxSwiftDemo
//
//  Created by DoubleK on 2022/8/17.
//

import Foundation

extension Disposable {
    /// Add `self` to `bag`
    func disposed(by bag: DisposeBag) {
        bag.insert(self)
    }
}

final class DisposeBag: DisposeBase {
    
    private var lock = SpinLock()
    
    private var disposables = [Disposable]()
    private var isDisposed = false
    
    override init() {
        super.init()
    }
    
    func insert(_ disposable: Disposable) {
        self._insert(disposable)?.dispose()
    }
    
    private func _insert(_ disposable: Disposable) -> Disposable? {
        self.lock.performLocked { 
            if self.isDisposed {
                return disposable
            }
            self.disposables.append(disposable)
            return nil
        }
    }
    
    
    private func dispose() {
        let oldDisposables = self._dispose()
        
        for disposable in oldDisposables {
            disposable.dispose()
        }
    }
    
    
    private func _dispose() -> [Disposable] {
        self.lock.performLocked { 
            let disposables = self.disposables
            self.disposables.removeAll(keepingCapacity: false)
            self.isDisposed = true
            return disposables
        }
    }
    
    deinit {
        self.dispose()
    }
    
}
