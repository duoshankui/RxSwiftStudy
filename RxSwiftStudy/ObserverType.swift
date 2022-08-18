//
//  ObserverType.swift
//  RxSwiftDemo
//
//  Created by DoubleK on 2022/8/17.
//

import Foundation

protocol ObserverType {
    associatedtype Element
    
    func on(_ event: Event<Element>)
}


extension ObserverType {
    func onNext(_ element: Element) {
        self.on(.next(element))
    }
    
    func obCompleted() {
        self.on(.completed)
    }
    
    func onError(_ error: Swift.Error) {
        self.on(.error(error))
    }
}
