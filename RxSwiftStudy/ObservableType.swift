//
//  ObservableType.swift
//  RxSwiftDemo
//
//  Created by DoubleK on 2022/8/17.
//

import Foundation

protocol ObservableType: ObservableConvertibleType {
    
    func subscribe<Observer: ObserverType>(_ observer: Observer) -> Disposable where Observer.Element == T
}

extension ObservableType {
    func asObservable() -> Observable<T> {
        Observable.create { o in self.subscribe(o)  }
    }
}

extension ObservableType {
    static func create(_ subscribe: @escaping (AnyObserver<T>) -> Disposable) -> Observable<T> {
        return AnonymousObservable(subscribe)
    }
}


final private class AnonymousObservable<T>: Producer<T> {
    
    typealias SubscribeHandler = (AnyObserver<T>) -> Disposable
    
    let subscribe: SubscribeHandler
    init(_ subscribe: @escaping SubscribeHandler) {
        self.subscribe = subscribe
    }
}
