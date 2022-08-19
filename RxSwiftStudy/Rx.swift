//
//  Rx.swift
//  RxSwiftStudy
//
//  Created by DoubleK on 2022/8/19.
//

import Foundation


func rxAbstractMethod(file: StaticString = #file, line: UInt = #line) -> Swift.Never {
    rxFatalError("Abstract method", file: file, line: line)
}

func rxFatalError(_ lastMessage: @autoclosure () -> String, file: StaticString = #file, line: UInt = #line) -> Swift.Never {
    fatalError(lastMessage(), file: file, line: line)
}

enum Hooks {
    
}
