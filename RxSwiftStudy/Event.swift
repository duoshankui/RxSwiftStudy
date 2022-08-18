//
//  Event.swift
//  RxSwiftDemo
//
//  Created by DoubleK on 2022/8/17.
//

import Foundation

@frozen enum Event<Element> {
    case next(Element)
    case error(Swift.Error)
    case completed
}

protocol EventCompatible {
    associatedtype Element
    var event: Event<Element> { get }
}

extension Event: EventCompatible {
    var event: Event<Element> {
        return self
    }
}
