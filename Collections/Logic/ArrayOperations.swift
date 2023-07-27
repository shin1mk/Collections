//
//  ArrayOperations.swift
//  Collections
//
//  Created by SHIN MIKHAIL on 21.07.2023.
//

import Foundation
import UIKit

final class ArrayOperations {
    private let queue = DispatchQueue(label: "ArrayOperations_queue_working", qos: .userInitiated)
    private var array = [Int]()
    private let array2 = [Int](0..<1_000)
    //MARK: generateIntArray
    func generateIntArray(completion: ((Double) -> Void)?) {
        queue.async { [weak self] in
            guard let self else { return }
            let start = CACurrentMediaTime()
            let array = [Int](0..<9_999_999)
            let result = ((CACurrentMediaTime() - start)*100).rounded() / 100
            self.array = array
            DispatchQueue.main.async {
                completion?(result)
            }
        }
    }
    //MARK: all methods
    // row 1.1
    func insertElementsBeginningOneByOne(completion: ((Double) -> Void)?) {
        queue.async { [weak self] in
            guard let self else { return }
            let start = CACurrentMediaTime()
            for i in (0..<1_000).reversed() {
                self.array.insert(i, at: 0)
            }
            let result = ((CACurrentMediaTime() - start)*100).rounded() / 100
            DispatchQueue.main.async {
                completion?(result)
            }
        }
    }
    // row 1.2
    func insertElementsBeginningAtOnce(completion: ((Double) -> Void)?) {
        queue.async { [weak self] in
            guard let self else { return }
            let start = CACurrentMediaTime()
            self.array.insert(contentsOf: self.array2, at: 0)
            let result = ((CACurrentMediaTime() - start)*1000).rounded() / 1000
            DispatchQueue.main.async {
                completion?(result)
            }
        }
    }
    // row 2.1
    func insertElementsMiddleOnebyOne(completion: ((Double) -> Void)?) {
        queue.async { [weak self] in
            guard let self else { return }
            let start = CACurrentMediaTime()
            for i in (0...1_000).reversed() {
                self.array.insert(i, at: (self.array.count/2))
            }
            let result = ((CACurrentMediaTime() - start)*100).rounded() / 100
            DispatchQueue.main.async {
                completion?(result)
            }
        }
    }
    // row 2.2
    func insertElementsMiddleAtOnce(completion: ((Double) -> Void)?) {
        queue.async { [weak self] in
            guard let self else { return }
            let start = CACurrentMediaTime()
            self.array.insert(contentsOf: self.array2, at: self.array.count/2)
            let result = ((CACurrentMediaTime() - start)*1000).rounded() / 1000
            DispatchQueue.main.async {
                completion?(result)
            }
        }
    }
    // row 3.1
    func insertElementsEndOnebyOne(completion: ((Double) -> Void)?) {
        queue.async { [weak self] in
            guard let self else { return }
            let start = CACurrentMediaTime()
            for var i in 0..<1_000 {
                self.array.append(i)
                i += 1
            }
            let result = ((CACurrentMediaTime() - start)*1000).rounded() / 1000
            DispatchQueue.main.async {
                completion?(result)
            }
        }
    }
    // row 3.2
    func insertElementsEndAtOnce(completion: ((Double) -> Void)?) {
        queue.async { [weak self] in
            guard let self else { return }
            let start = CACurrentMediaTime()
            self.array.append(contentsOf: self.array2)
            let result = ((CACurrentMediaTime() - start)*10000).rounded() / 10000
            DispatchQueue.main.async {
                completion?(result)
            }
        }
    }
    // row 4.1
    func removeElementsBeginningOnebyOne(completion: ((Double) -> Void)?) {
        queue.async { [weak self] in
            guard let self else { return }
            let start = CACurrentMediaTime()
            for var i in 0..<1_000 {
                self.array.remove(at: 0)
                i += i+1
            }
            let result = ((CACurrentMediaTime() - start)*100).rounded() / 100
            DispatchQueue.main.async {
                completion?(result)
            }
        }
    }
    // row 4.2
    func removeElementsBeginningAtOnce(completion: ((Double) -> Void)?) {
        queue.async { [weak self] in
            guard let self else { return }
            let start = CACurrentMediaTime()
            self.array.removeFirst(1_000)
            let result = ((CACurrentMediaTime() - start)*1000).rounded() / 1000
            DispatchQueue.main.async {
                completion?(result)
            }
        }
    }
    // row 5.1
    func removeElementsMiddleOnebyOne(completion: ((Double) -> Void)?) {
        queue.async { [weak self] in
            guard let self else { return }
            let start = CACurrentMediaTime()
            for var i in 0..<1_000 {
                self.array.remove(at: self.array.count/2)
                i += i+1
            }
            let result = ((CACurrentMediaTime() - start)*100).rounded() / 100
            DispatchQueue.main.async {
                completion?(result)
            }
        }
    }
    // row 5.2
    func removeElementsMiddleAtOnce(completion: ((Double) -> Void)?) {
        queue.async { [weak self] in
            guard let self else { return }
            let start = CACurrentMediaTime()
            self.array.removeSubrange(self.array.count/2 ..< ((self.array.count/2) + self.array2.count))
            let result = ((CACurrentMediaTime() - start)*10000).rounded() / 10000
            DispatchQueue.main.async {
                completion?(result)
            }
        }
    }
    // row 6.1
    func removeElementsEndOnebyOne(completion: ((Double) -> Void)?) {
        queue.async { [weak self] in
            guard let self else { return }
            let start = CACurrentMediaTime()
            for var i in 0..<1_000 {
                self.array.removeLast()
                i += 1
            }
            let result = ((CACurrentMediaTime() - start)*10000).rounded() / 10000
            DispatchQueue.main.async {
                completion?(result)
            }
        }
    }
    // row 6.2
    func removeElementsEndAtOnce(completion: ((Double) -> Void)?) {
        queue.async { [weak self] in
            guard let self else { return }
            let start = CACurrentMediaTime()
            self.array.removeLast(1_000)
            let result = ((CACurrentMediaTime() - start)*10000).rounded() / 10000
            DispatchQueue.main.async {
                completion?(result)
            }
        }
    }
}
