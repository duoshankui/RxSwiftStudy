//
//  AnonymousObserver.swift
//  RxSwiftStudy
//
//  Created by DoubleK on 2022/8/18.
//

import Foundation

final class AnonymousObserver<T>: ObserverBase<T> {
    
    typealias EventHandler = (Event<Element>) -> Void
    
    private let eventHandler: EventHandler
    init(_ eventHandler: @escaping EventHandler) {
        self.eventHandler = eventHandler
    }
    
    override func onCore(_ event: Event<T>) {
        self.eventHandler(event)
    }
}
