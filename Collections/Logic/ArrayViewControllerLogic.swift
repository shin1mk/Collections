//
//  ArrayViewController+Logic.swift
//  Collections
//
//  Created by SHIN MIKHAIL on 08.07.2023.
//

import UIKit

extension ArrayViewController: UITableViewDelegate, UITableViewDataSource {
    // Количество строк в таблице
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // Установите желаемую высоту строки
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    // содержимое строки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "Create Int array with 10_000_000 elements"
        cell.textLabel?.textColor = .black
        cell.textLabel?.textAlignment = .center
        cell.backgroundColor = .lightGray
        cell.selectionStyle = .default // Разрешить выбор ячейки
        // Remove left and right margins
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let cell = tableView.cellForRow(at: indexPath) {
            if cell.textLabel?.text == "Create Int array with 10_000_000 elements" {
                // Убрать текст ячейки
                cell.textLabel?.text = nil
                
                // Создать и настроить индикатор загрузки
                let activityIndicator = UIActivityIndicatorView(style: .medium)
                activityIndicator.startAnimating()
                
                // Добавить индикатор загрузки в ячейку
                cell.contentView.addSubview(activityIndicator)
                
                // Активировать автолейаут для индикатора загрузки
                activityIndicator.translatesAutoresizingMaskIntoConstraints = false
                
                // Центрирование индикатора загрузки в ячейке
                NSLayoutConstraint.activate([
                    activityIndicator.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
                    activityIndicator.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor)
                ])
                
                // Выполнить генерацию массива в фоновом потоке
                DispatchQueue.global().async {
                    let executionTime = self.generateIntArray()
                    
                    // Обновить ячейку в основном потоке
                    DispatchQueue.main.async {
                        // Удалить индикатор загрузки
                        activityIndicator.removeFromSuperview()
                        
                        // Заменить индикатор загрузки на текст с временем выполнения
                        cell.textLabel?.text = "Array generation time: \(executionTime)"
                    }
                }
            }
        }
    }
    
    
    private func generateIntArray() -> Double {
        var array = [Int]()
        
        let start = CACurrentMediaTime()
        
        for i in 0..<10_000_000 {
            array.append(i)
        }
        
        let end = CACurrentMediaTime()
        let executionTime = end - start
        
        let roundedTime = (executionTime * 100).rounded() / 100 // Round to two decimal places
        return roundedTime
    }
    
}
