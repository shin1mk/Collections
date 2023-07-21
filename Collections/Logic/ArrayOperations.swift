//
//  ArrayOperations.swift
//  Collections
//
//  Created by SHIN MIKHAIL on 21.07.2023.
//

import Foundation
import UIKit

//MARK: generateIntArray
func generateIntArray() -> String {
    var array = [Int]()
    let start = CACurrentMediaTime()
    for i in 0..<10_000_000 {
        array.append(i)
    }
    let end = CACurrentMediaTime()
    let executionTime = end - start
    let executionTimeFormatted = String(format: "%.2f", executionTime)
    return executionTimeFormatted
}
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
