//
//  ImmediateSchedulerType.swift
//  RxSwiftStudy
//
//  Created by DoubleK on 2022/8/19.
//

import Foundation

protocol ImmediateSchedulerType {
    func schedule<StateType>(_ state: StateType, action: @escaping (StateType) -> Disposable) -> Disposable
}
