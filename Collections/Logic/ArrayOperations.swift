//
//  ArrayOperations.swift
//  Collections
//
//  Created by SHIN MIKHAIL on 21.07.2023.
//

import Foundation
import UIKit

//MARK: generateIntArray
final class ArrayOperations {
    private let queue = DispatchQueue(label: "ArrayOperations_queue_working", qos: .userInitiated)
    private var array = [Int]()
    private let array2 = [Int](0..<1_000)
// новый вариант функции generateIntArray
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
    //MARK: row 1
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
    //MARK: row2
    
    func insertElementsMiddle1by1(completion: ((Double) -> Void)?) {
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
    //MARK: row 3

    func insertElementsEnd1by1(completion: ((Double) -> Void)?) {
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
    //MARK: row 4
    func removeElementsBeginning1by1(completion: ((Double) -> Void)?) {
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
    //MARK: row 5

    func removeElementsMiddle1by1(completion: ((Double) -> Void)?) {
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
    //MARK: row 6

    func removeElementsEnd1by1(completion: ((Double) -> Void)?) {
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
    
    
    
    
    
    
    
    
    //старый вариант generateIntArray
//    func generateIntArray(completion: ((Double) -> Void)?) {
//        queue.async {
//            let start = CACurrentMediaTime()
//            for i in 0..<9_999_999 {
//                self.array.append(i)
//            }
//            let end = CACurrentMediaTime()
//            let executionTime = end - start
//            let executionTimeFormatted = Double(executionTime, format: "%.2f")
//            DispatchQueue.main.async {
//                completion?(executionTimeFormatted)
//            }
//        }
//    }
    //MARK: - row 1
    //Вставка в начало массива 1000 элементов (например, от 0 до 999) по одному
    func insertElementsAtBeginningOneByOne() -> String {
        var array = [Int]()
        for i in 0..<10_000_000 {
            array.append(i)
        }
        
        let start = CACurrentMediaTime()
        for i in 0..<1000 {
            array.insert(i, at: 0)
        }
        let end = CACurrentMediaTime()
        let executionTime = end - start
        let executionTimeFormatted = String(format: "%.2f", executionTime)
        return executionTimeFormatted
    }
    //Вставка в начало массива 1000 элементов (например, от 0 до 999) по сразу
    func insertElementsAtBeginningAllAtOnce() -> String {
        var array = [Int]()
        for i in 0..<10_000_000 {
            array.append(i)
        }
        
        let start = CACurrentMediaTime()
        let elementsToInsert = Array(0..<1000)
        array.insert(contentsOf: elementsToInsert, at: 0)
        let end = CACurrentMediaTime()
        
        let executionTime = end - start
        let executionTimeFormatted = String(format: "%.2f", executionTime)
        return executionTimeFormatted
    }
    //MARK: - row2
    // Вставка в середину массива 1000 элементов по одному
    func insertElementsInMiddleOneByOne() -> String {
        var array = [Int]()
        for i in 0..<10_000_000 {
            array.append(i)
        }
        
        let start = CACurrentMediaTime()
        for i in 0..<1000 {
            array.insert(i, at: array.count / 2)
        }
        let end = CACurrentMediaTime()
        let executionTime = end - start
        let executionTimeFormatted = String(format: "%.2f", executionTime)
        return executionTimeFormatted
    }
    
    // Вставка в середину массива 1000 элементов по сразу
    func insertElementsInMiddleAllAtOnce() -> String {
        var array = [Int]()
        for i in 0..<10_000_000 {
            array.append(i)
        }
        
        let start = CACurrentMediaTime()
        let elementsToInsert = Array(0..<1000)
        array.insert(contentsOf: elementsToInsert, at: array.count / 2)
        let end = CACurrentMediaTime()
        
        let executionTime = end - start
        let executionTimeFormatted = String(format: "%.2f", executionTime)
        return executionTimeFormatted
    }
    //MARK: - row3
    // Добавление в конец массива 1000 элементов по одному
    func appendElementsOneByOne() -> String {
        var array = [Int]()
        for i in 0..<10_000_000 {
            array.append(i)
        }
        
        let start = CACurrentMediaTime()
        for i in 0..<1000 {
            array.append(i)
        }
        let end = CACurrentMediaTime()
        let executionTime = end - start
        let executionTimeFormatted = String(format: "%.2f", executionTime)
        return executionTimeFormatted
    }
    
    // Добавление в конец массива 1000 элементов по сразу
    func appendElementsAllAtOnce() -> String {
        var array = [Int]()
        for i in 0..<10_000_000 {
            array.append(i)
        }
        
        let start = CACurrentMediaTime()
        let elementsToInsert = Array(0..<1000)
        array.append(contentsOf: elementsToInsert)
        let end = CACurrentMediaTime()
        
        let executionTime = end - start
        let executionTimeFormatted = String(format: "%.2f", executionTime)
        return executionTimeFormatted
    }
    //MARK: - row4
    // Удаление из начала массива 1000 элементов по одному
    func removeElementsFromBeginningOneByOne() -> String {
        var array = [Int]()
        for i in 0..<10_000_000 {
            array.append(i)
        }
        
        let start = CACurrentMediaTime()
        for _ in 0..<1000 {
            array.removeFirst()
        }
        let end = CACurrentMediaTime()
        let executionTime = end - start
        let executionTimeFormatted = String(format: "%.2f", executionTime)
        return executionTimeFormatted
    }
    
    // Удаление из начала массива 1000 элементов по сразу
    func removeElementsFromBeginningAllAtOnce() -> String {
        var array = [Int]()
        for i in 0..<10_000_000 {
            array.append(i)
        }
        
        let start = CACurrentMediaTime()
        array.removeFirst(1000)
        let end = CACurrentMediaTime()
        
        let executionTime = end - start
        let executionTimeFormatted = String(format: "%.2f", executionTime)
        return executionTimeFormatted
    }
    //MARK: - row5
    // Удаление из середины массива 1000 элементов по одному
    func removeElementsFromMiddleOneByOne() -> String {
        var array = [Int]()
        for i in 0..<10_000_000 {
            array.append(i)
        }
        
        let start = CACurrentMediaTime()
        let middleIndex = array.count / 2
        for _ in 0..<1000 {
            array.remove(at: middleIndex)
        }
        let end = CACurrentMediaTime()
        let executionTime = end - start
        let executionTimeFormatted = String(format: "%.2f", executionTime)
        return executionTimeFormatted
    }
    
    // Удаление из середины массива 1000 элементов по сразу
    func removeElementsFromMiddleAllAtOnce() -> String {
        var array = [Int]()
        for i in 0..<10_000_000 {
            array.append(i)
        }
        
        let start = CACurrentMediaTime()
        let middleIndex = array.count / 2
        array.removeSubrange(middleIndex..<middleIndex + 1000)
        let end = CACurrentMediaTime()
        
        let executionTime = end - start
        let executionTimeFormatted = String(format: "%.2f", executionTime)
        return executionTimeFormatted
    }
    //MARK: - row6
    // Удаление из конца массива 1000 элементов по одному
    func removeElementsFromEndOneByOne() -> String {
        var array = [Int]()
        for i in 0..<10_000_000 {
            array.append(i)
        }
        
        let start = CACurrentMediaTime()
        for _ in 0..<1000 {
            array.removeLast()
        }
        let end = CACurrentMediaTime()
        let executionTime = end - start
        let executionTimeFormatted = String(format: "%.2f", executionTime)
        return executionTimeFormatted
    }
    
    // Удаление из конца массива 1000 элементов по сразу
    func removeElementsFromEndAllAtOnce() -> String {
        var array = [Int]()
        for i in 0..<10_000_000 {
            array.append(i)
        }
        
        let start = CACurrentMediaTime()
        array.removeLast(1000)
        let end = CACurrentMediaTime()
        
        let executionTime = end - start
        let executionTimeFormatted = String(format: "%.2f", executionTime)
        return executionTimeFormatted
    }
}
