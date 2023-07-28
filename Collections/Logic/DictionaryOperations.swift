//
//  DictionaryOperations.swift
//  Collections
//
//  Created by SHIN MIKHAIL on 25.07.2023.
//

import Foundation

class DictionaryOperations {
    private let queue = DispatchQueue(label: "Dictionary_manager_queue_working", qos: .userInitiated)
    private struct Contact {
        var name = String()
        var phoneNumber = String()
    }
    private var contactArray: [Contact] = []
    private var contactDictionary: [String: String] = [:]
    //MARK: Generate array
    func generateContactsArray() {
        for i in 0..<10_000_000 {
            let name = "name\(i)"
            let randomNumber = Int.random(in: 1111111...9999999)
            let phoneNumber = String(randomNumber)
            let contact = Contact(name: name, phoneNumber: phoneNumber)
            contactArray.append(contact)
        }
    }
    
    func generateDictionaryArray() {
        for i in 0..<10_000_000 {
            let name = "dictionaryName\(i)"
            let randomNumber = Int.random(in: 1111111...9999999)
            let phoneNumber = String(randomNumber)
            contactDictionary[name] = phoneNumber
        }
    }
    //MARK: Operations with array
    //Array 1
    func findFirstElenemtInArray(completion: ((Double, Int) -> Void)?) {
        queue.async { [weak self] in
            guard let self else { return }
            let start = CFAbsoluteTimeGetCurrent()
            let elementFromArray = self.contactArray.startIndex
            let element = Int(elementFromArray)
            let result = ((CFAbsoluteTimeGetCurrent() - start)*100).rounded() / 100
            DispatchQueue.main.async {
                completion?(result, element)
            }
        }
    }
    //Array 2
    func findLastElenemtInArray(completion: ((Double, Int) -> Void)?) {
        queue.async { [weak self] in
            guard let self else { return }
            let start = CFAbsoluteTimeGetCurrent()
            let elementFromArray = (self.contactArray.count)-1
            let result = ((CFAbsoluteTimeGetCurrent() - start)*100).rounded() / 100
            DispatchQueue.main.async {
                completion?(result, elementFromArray)
            }
        }
    }
    //Array 3
    func findNotExistingElenemtInArray(completion: ((Double, Int) -> Void)?) {
        queue.async { [weak self] in
            guard let self else { return }
            let start = CFAbsoluteTimeGetCurrent()
            var flag: Int = 0
            let nonExistingItem = "name9999999999" //"name\(nonExistingNumber)"
            let nonExistingElement = self.contactArray.contains { $0.name == nonExistingItem }
            
            if nonExistingElement == true {
                flag += 1
            } else {
                flag = 0
            }
            
            let result = ((CFAbsoluteTimeGetCurrent() - start)*100).rounded() / 100
            DispatchQueue.main.async {
                completion?(result, flag )
            }
        }
    }
    //Dictionary 1
    func findFirstElenemtInDictionary(completion: ((Double, Int) -> Void)?) {
        queue.async { [weak self] in
            guard let self else { return }
            let start = CFAbsoluteTimeGetCurrent()
            guard let elementFromDictionary = self.contactDictionary["dictionaryName0"] else { return }
            let element = Int(elementFromDictionary)
            let result = ((CFAbsoluteTimeGetCurrent() - start)*100).rounded() / 100
            DispatchQueue.main.async {
                completion?(result, element ?? 0)
            }
        }
    }
    //Dictionary 2
    func findLastElenemtInDictionary(completion: ((Double, Int) -> Void)?) {
        queue.async { [weak self] in
            guard let self else { return }
            let start = CFAbsoluteTimeGetCurrent()
            
            guard let elementFromDictionary = self.contactDictionary["dictionaryName999999"] else { return }
            let element = Int(elementFromDictionary)
            
            let result = ((CFAbsoluteTimeGetCurrent() - start)*100).rounded() / 100
            DispatchQueue.main.async {
                completion?(result, element ?? 0)
            }
        }
    }
    //Dictionary 3
    func findNotExistingElenemtInDictionary(completion: ((Double, Int) -> Void)?) {
        queue.async { [weak self] in
            guard let self else { return }
            let start = CFAbsoluteTimeGetCurrent()
            var flag: Int = 0
            let key = "dictionaryName999999999999"
            
            if self.contactDictionary.keys.contains(key) {
                flag = flag + 1
            } else {
                flag = 0
            }
            
            let result = ((CFAbsoluteTimeGetCurrent() - start)*100).rounded() / 100
            DispatchQueue.main.async {
                completion?(result, flag)
            }
        }
    }
}
