//
//  Producer.swift
//  RxSwiftDemo
//
//  Created by DoubleK on 2022/8/17.
//

import Foundation

class Producer<T>: Observable<T> {
    override init() {
        super.init()
    }
    
    override func subscribe<Observer: ObserverType>(_ observer: Observer) -> Disposable where Observer.Element == T {
        if !CurrentThreadScheduler.isScheduleRequired {
            let disposer = SinkDisposer()
            let sinkAndSubscription = self.run(observer, cancle: disposer)
            disposer.setSinkAndSubscription(sink: sinkAndSubscription.sink, subscription: sinkAndSubscription.subscription)
            return disposer
        } else {
            return CurrentThreadScheduler.instance.schedule(()) { _ in
                let disposer = SinkDisposer()
                let sinkAndSubscription = self.run(observer, cancle: disposer)
                disposer.setSinkAndSubscription(sink: sinkAndSubscription.sink, subscription: sinkAndSubscription.subscription)
                return disposer
            }
        }
    }
    
    
    func run<Observer: ObserverType>(_ observer: Observer, cancle: Cancelable) -> (sink: Disposable, subscription: Disposable) where Observer.Element == T {
        rxAbstractMethod()
    }
    
}


private final class SinkDisposer: Cancelable {
    private enum DisposeState: Int32 {
        case disposed = 1
        case sinkAndSubscriptionSet = 2
    }
    
    private let state = AtomicInt(0)
    private var sink: Disposable?
    private var subscription: Disposable?
    
    var isDisposed: Bool {
        return isFlagSet(state, DisposeState.disposed.rawValue)
    }
    
    func setSinkAndSubscription(sink: Disposable, subscription: Disposable) {
        self.sink = sink
        self.subscription = subscription
        
        let previousState = fetchOr(state, DisposeState.sinkAndSubscriptionSet.rawValue)
        if (previousState & DisposeState.sinkAndSubscriptionSet.rawValue) != 0 {
            rxFatalError("Sink and subscription were already set")
        }
        
        if (previousState & DisposeState.disposed.rawValue) != 0 {
            sink.dispose()
            subscription.dispose()
            self.sink = nil
            self.subscription = nil
        }
        
    }
    
    func dispose() {
        
    }
}
