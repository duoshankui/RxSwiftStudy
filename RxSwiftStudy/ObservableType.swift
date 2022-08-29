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

final private class AnonymousObservableSink<Observer: ObserverType>: Sink<Observer>, ObserverType {
    typealias Element = Observer.Element
    
    private let isStopped = AtomicInt(0)
    
    override init(observer: Observer, cancel: Cancelable) {
        super.init(observer: observer, cancel: cancel)
    }
    
    func on(_ event: Event<Observer.Element>) {
        print("event:  -- \(event)")
        
        switch event {
        case .next:
            if load(self.isStopped) == 1 {
                return
            }
            self.forwardOn(event)
            
        case .error, .completed:
            if fetchOr(self.isStopped, 1) == 0 {
                self.forwardOn(event)
                self.dispose()
            }
        }
    }
    
    func run(_ parent: AnonymousObservable<Element>) -> Disposable {
        parent.subscribehandler(AnyObserver(self))
    }
}


final private class AnonymousObservable<T>: Producer<T> {
    
    typealias SubscribeHandler = (AnyObserver<T>) -> Disposable
    
    let subscribehandler: SubscribeHandler
    init(_ subscribehandler: @escaping SubscribeHandler) {
        self.subscribehandler = subscribehandler
    }
    
    override func run<Observer: ObserverType>(_ observer: Observer, cancle: Cancelable) -> (sink: Disposable, subscription: Disposable) where T == Observer.Element {
        let sink = AnonymousObservableSink(observer: observer, cancel: cancle)
        let subscription = sink.run(self)
        return (sink: sink, subscription: subscription)
    }
    
}
