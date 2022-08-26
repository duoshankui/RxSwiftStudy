//
//  ScheduledItem.swift
//  RxSwiftStudy
//
//  Created by DoubleK on 2022/8/26.
//

import Foundation

struct ScheduledItem<T>: ScheduledItemType, InvocableType {
    
    typealias Action = (T) -> Disposable
    
    private let action: Action
    private let state: T
    
    var isDisposed: Bool {
        return true
    }
    
    init(action: @escaping Action, state: T) {
        self.action = action
        self.state = state
    }
    
    
    func dispose() {
        
    }
    
    func invoke() {
        
    }
}
