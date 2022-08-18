//
//  Disposables.swift
//  RxSwiftDemo
//
//  Created by DoubleK on 2022/8/17.
//

import Foundation

struct Disposables {
    
}


extension Disposables {
    static func create() -> Disposable {
        return NopDisposable.nop
    }
}

struct NopDisposable: Disposable {
    
    fileprivate static let nop = NopDisposable()
    
    func dispose() {
        //do noting
        print("do noting")
    }
}
