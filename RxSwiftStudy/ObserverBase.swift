//
//  ObserverBase.swift
//  RxSwiftStudy
//
//  Created by DoubleK on 2022/8/18.
//

import Foundation

class ObserverBase<Element>: Disposable, ObserverType {
    private let isStopped = AtomicInt(0)

    
    func dispose() {
        
    }
    
    func on(_ event: Event<Element>) {
        switch event {
        case .next:
            if load(self.isStopped) == 0 {
                self.onCore(event)
            }
        case .completed, .error:
            if fetchOr(self.isStopped, 1) == 0 {
                self.onCore(event)
            }
        }
    }
    
    
    func onCore(_ event: Event<Element>) {
        rxAbstractMethod()
    }
    
    
}
