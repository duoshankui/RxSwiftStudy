//
//  AnyObserver.swift
//  RxSwiftDemo
//
//  Created by DoubleK on 2022/8/17.
//

import Foundation

struct AnyObserver<Element>: ObserverType {
    
    typealias EventHandler = (Event<Element>) -> Void
    
    let observer: EventHandler
    
    
    init<Observer: ObserverType>(_ observer: Observer) where Observer.Element == Element {
        self.observer = observer.on(_:)
    }
    
    func on(_ event: Event<Element>) {
        self.observer(event)
        print(event)
    }
}
