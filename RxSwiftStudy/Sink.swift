//
//  Sink.swift
//  RxSwiftStudy
//
//  Created by DoubleK on 2022/8/29.
//

import Foundation

class Sink<Observer: ObserverType>: Disposable {
    
    fileprivate let observer: Observer
    fileprivate let cancel: Cancelable
    private let disposed = AtomicInt(0)
    
    init(observer: Observer, cancel: Cancelable) {
        self.observer = observer
        self.cancel = cancel
    }
    
    func forwardOn(_ event: Event<Observer.Element>) {
        if isFlagSet(self.disposed, 1) {
            return
        }
        self.observer.on(event)
    }
    
    func dispose() {
        fetchOr(self.disposed, 1)
        self.cancel.dispose()
    }
}
