//
//  ObserverBase.swift
//  RxSwiftStudy
//
//  Created by DoubleK on 2022/8/18.
//

import Foundation

class ObserverBase<Element>: Disposable, ObserverType {
    func dispose() {
        
    }
    
    func on(_ event: Event<Element>) {
        
    }
    
    
}
