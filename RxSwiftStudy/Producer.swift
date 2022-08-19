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
            
        } else {
            return CurrentThreadScheduler.instance.schedule(()) { _ in
                
            }
        }
    }
}
