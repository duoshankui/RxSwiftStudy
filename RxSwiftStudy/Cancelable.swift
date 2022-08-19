//
//  Cancelable.swift
//  RxSwiftStudy
//
//  Created by DoubleK on 2022/8/18.
//

import Foundation

protocol Cancelable: Disposable {
    var isDisposed: Bool { get }
}
