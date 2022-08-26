//
//  ScheduleItemType.swift
//  RxSwiftStudy
//
//  Created by DoubleK on 2022/8/26.
//

import Foundation

protocol ScheduledItemType: Cancelable, InvocableType {
    func invoke()
}
