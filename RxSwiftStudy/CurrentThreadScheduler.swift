//
//  CurrentThreadScheduler.swift
//  RxSwiftStudy
//
//  Created by DoubleK on 2022/8/19.
//

import Foundation

class CurrentThreadScheduler: ImmediateSchedulerType {
    
    
    static let instance = CurrentThreadScheduler()
    
    private static var isScheduleRequiredKey: pthread_key_t = { () -> pthread_key_t in
        let key = UnsafeMutablePointer<pthread_key_t>.allocate(capacity: 1)
        defer {
            key.deallocate()
        }
        guard pthread_key_create(key, nil) == 0 else {
            rxFatalError("isScheduleRequired key creation failed")
        }
        return key.pointee
    }()
    
    private static var scheduleInProgressSentinel: UnsafeRawPointer = { () -> UnsafeRawPointer in
        return UnsafeRawPointer(UnsafeMutablePointer<Int>.allocate(capacity: 1))
    }()
    
    static private(set) var isScheduleRequired: Bool {
        get {
            return pthread_getspecific(CurrentThreadScheduler.isScheduleRequiredKey) == nil
        }
        set(isScheduleRequired) {
            if pthread_setspecific(CurrentThreadScheduler.isScheduleRequiredKey, isScheduleRequired ? nil : scheduleInProgressSentinel) != 0 {
                rxFatalError("pthread_setspecific failed")
            }
        }
    }
    
    
    func schedule<StateType>(_ state: StateType, action: @escaping (StateType) -> Disposable) -> Disposable {
        if CurrentThreadScheduler.isScheduleRequired {
            CurrentThreadScheduler.isScheduleRequired = false
            
            let disposable = action(state)
            
            defer {
                CurrentThreadScheduler.isScheduleRequired = true
            }
            
            return disposable
        }
    }
}
