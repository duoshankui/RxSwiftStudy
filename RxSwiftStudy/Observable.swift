//
//  Observable.swift
//  RxSwiftDemo
//
//  Created by DoubleK on 2022/8/17.
//

import Foundation

class Observable<T>: ObservableType {
    init() {
        
    }
    
    func subscribe<Observer: ObserverType>(_ observer: Observer) -> Disposable where Observer.Element == T {
        rxAbstractMethod()
    }
    
    func asObservable() -> Observable<T> {
        return self
    }
}
