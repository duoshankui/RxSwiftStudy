//
//  ObservableType.swift
//  RxSwiftDemo
//
//  Created by DoubleK on 2022/8/17.
//

import Foundation

protocol ObservableType: ObservableConvertibleType {
    
    
    
}

extension ObservableType {
    static func create(_ subscribe: @escaping (AnyObserver<T>) -> Disposable) -> Observable<T> {
        return AnonymousObservable(subscribe)
    }
}


extension ObservableType {
    func subscribe<Object: AnyObject>(
        with object: Object,
        onNext: ((Object, T) -> Void)? = nil, 
        onError: ((Object, Swift.Error) -> Void)? = nil,
        onCompleted: ((Object) -> Void)? = nil,
        onDisposed: ((Object) -> Void)? = nil
    ) -> Disposable {
        return Disposables.create()
    }
    
    
    func subscribe(
        onNext: ((T) -> Void)? = nil, 
        onError: ((Swift.Error) -> Void)? = nil,
        onCompleted: (() -> Void)? = nil,
        onDisposed: (() -> Void)? = nil
    ) -> Disposable {
        return Disposables.create()
    }
    
}


final private class AnonymousObservable<T>: Producer<T> {
    
    typealias SubscribeHandler = (AnyObserver<T>) -> Disposable
    
    let subscribe: SubscribeHandler
    init(_ subscribe: @escaping SubscribeHandler) {
        self.subscribe = subscribe
    }
}
