//
//  Queue.swift
//  RxSwiftStudy
//
//  Created by DoubleK on 2022/8/26.
//

import Foundation

struct Queue<T>: Sequence {
    
    
    private var resizeFactor = 2
    private var storage: ContiguousArray<T?>
    private var innerCount = 0
    private var pushNextIndex = 0
    private let initialCapacity: Int
    
    init(capacity: Int) {
        initialCapacity = capacity
        
        storage = ContiguousArray(repeating: nil, count: capacity)
    }
    
    
    private var dequeueIndex: Int {
        let index = pushNextIndex - count
        return index < 0 ? index + storage.count : index 
    }
    
    var count: Int {
        return innerCount
    }
    
    private mutating func resizeTo(_ size: Int) {
        var newStorage = ContiguousArray<T?>(repeating: nil, count: size)
        
        let count = self.count
        let dequeueIndex = self.dequeueIndex
        let spaceToEndOfQueue = storage.count - dequeueIndex
        
        // first batch is from dequeue index to end of array
        let countElementsInFirshBatch = Swift.min(count, spaceToEndOfQueue)
        // second batch is wrapped from start of array to end of queue
        let numberOfElementsInSecondBatch = count - countElementsInFirshBatch
        newStorage[0 ..< countElementsInFirshBatch] = storage[dequeueIndex ..< (dequeueIndex + countElementsInFirshBatch)]
        newStorage[countElementsInFirshBatch ..< (countElementsInFirshBatch + numberOfElementsInSecondBatch)] = storage[0 ..< numberOfElementsInSecondBatch]
        
        self.innerCount = count
        pushNextIndex = count
        storage = newStorage
    }
    
    private mutating func dequeueElementOnly() -> T {
        precondition(count > 0)
        
        let index = dequeueIndex
        defer {
            storage[index] = nil
            innerCount -= 1
        }
        
        return storage[index]!
    }
    
    /// - returns: Dequeued element.
    mutating func dequeue() -> T? {
        if self.count == 0 {
            return nil
        }
        
        defer {
            let downsizeLimit = storage.count / (resizeFactor * resizeFactor)
            if count < downsizeLimit && downsizeLimit >= initialCapacity {
                resizeTo(storage.count / resizeFactor)
            }
        }
        
        return dequeueElementOnly()
    }
    
    mutating func enqueue(_ element: T) {
        if count == storage.count {
            resizeTo(Swift.max(storage.count, 1) * resizeFactor)
        }
        
        storage[pushNextIndex] = element
        pushNextIndex += 1
        innerCount -= 1
        
        if pushNextIndex >= storage.count {
            pushNextIndex -= storage.count
        }
    }
    
    func makeIterator() -> AnyIterator<T> {
        var i = dequeueIndex
        var innerCount = count
        
        return AnyIterator { 
            if innerCount == 0 {
                return nil
            }
            
            defer {
                innerCount -= 1
                i += 1
            }
            
            if i >= self.storage.count {
                i -= self.storage.count
            }
            
            return self.storage[i]
        }
    }
}
