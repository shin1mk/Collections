//
//  CustomTableView.swift
//  Collections
//
//  Created by SHIN MIKHAIL on 06.07.2023.
//

import UIKit

class CustomTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    var presentingViewController: UIViewController?

    init() {
        super.init(frame: .zero, style: .plain)
        configureTableView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    //MARK: Configure Table View
    func configureTableView() {
        delegate = self
        dataSource = self
        backgroundColor = .white
        separatorColor = .lightGray
        register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        separatorInset = .zero
    }
    
    func setPresentingViewController(_ viewController: UIViewController) {
        self.presentingViewController = viewController
    }
    //MARK: UITable View Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Array"
        case 1:
            cell.textLabel?.text = "Set"
        case 2:
            cell.textLabel?.text = "Dictionary"
        default:
            break
        }
        
        cell.textLabel?.font = UIFont.systemFont(ofSize: 17)
        cell.textLabel?.textAlignment = .left
        cell.textLabel?.textColor = .black
        cell.backgroundColor = .white
        // arrow
        let disclosureIndicatorImage = UIImage(systemName: "chevron.right")
        let disclosureIndicatorImageView = UIImageView(image: disclosureIndicatorImage)
        disclosureIndicatorImageView.tintColor = .lightGray
        cell.accessoryView = disclosureIndicatorImageView
        
        return cell
    }
}
