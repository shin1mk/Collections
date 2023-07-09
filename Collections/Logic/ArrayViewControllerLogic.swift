////
////  ArrayViewControllerLogic.swift
////  Collections
////
////  Created by SHIN MIKHAIL on 08.07.2023.
////
//
//import UIKit
//
//extension ArrayViewController: UITableViewDelegate, UITableViewDataSource {
//    //MARK: TableView
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//        cell.textLabel?.text = "Create Int array with 10_000_000 elements"
//        cell.textLabel?.textColor = .systemBlue
//        cell.textLabel?.textAlignment = .center
//        cell.backgroundColor = .lightGray
//        cell.selectionStyle = .default
//
//        cell.separatorInset = UIEdgeInsets.zero
//        cell.layoutMargins = UIEdgeInsets.zero
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//
//        if let cell = tableView.cellForRow(at: indexPath) {
//            if cell.textLabel?.text == "Create Int array with 10_000_000 elements" {
//                cell.textLabel?.text = nil
//                // indicator
//                let activityIndicator = UIActivityIndicatorView(style: .medium)
//                activityIndicator.startAnimating()
//                cell.contentView.addSubview(activityIndicator)
//                activityIndicator.translatesAutoresizingMaskIntoConstraints = false
//                NSLayoutConstraint.activate([
//                    activityIndicator.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
//                    activityIndicator.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor)
//                ])
//                DispatchQueue.global().async {
//                    let executionTime = self.generateIntArray()
//                    DispatchQueue.main.async {
//                        activityIndicator.removeFromSuperview()
//                        cell.textLabel?.text = "Array generation time: \(executionTime)"
//                    }
//                }
//            }
//        }
//    }
//
//    private func generateIntArray() -> Double {
//        var array = [Int]()
//        let start = CACurrentMediaTime()
//        for i in 0..<10_000_000 {
//            array.append(i)
//        }
//        let end = CACurrentMediaTime()
//        let executionTime = end - start
//        let roundedTime = (executionTime * 100).rounded() / 100
//        return roundedTime
//    }
//}
