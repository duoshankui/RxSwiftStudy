//
//  ObservableType+Extenstions.swift
//  RxSwiftStudy
//
//  Created by DoubleK on 2022/8/19.
//

import Foundation

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
        
        let disposable: Disposable
        if let disposed = onDisposed {
            disposable = Disposables.create(with: disposed)
        } else {
            disposable = Disposables.create()
        }
        
        let callStack = [String]()
        let observer = AnonymousObserver<T> { event in
            switch event {
            case .next(let value):
                onNext?(value)
            case .error(let error):
                if let onError = onError {
                    onError(error)
                } else {
                    Hooks.defaultErrorHandler(callStack, error)
                }
            case .completed:
                onCompleted?()
                disposable.dispose()
            }
        }
        
        let disposable1 = self.asObservable().subscribe(observer)
        return Disposables.create(disposable1, disposable)
    }
    
}


extension Hooks {
    typealias DefaultErrorHandler = (_ subscriptionCallStack: [String], _ error: Error) -> Void
    
    private static let lock = RecursiveLock()
    
    private static var _defaultErrorHander: DefaultErrorHandler = { subscriptionCallStack, error in
        
    }
    
    static var defaultErrorHandler: DefaultErrorHandler {
        get {
            lock.performLocked { 
                return _defaultErrorHander
            }
        }
        set {
            lock.performLocked { 
                _defaultErrorHander = newValue
            }
        }
    }
}
