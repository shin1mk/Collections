//
//  MainController.swift
//  Collections
//
//  Created by SHIN MIKHAIL on 06.07.2023.
//

import UIKit
import SnapKit

final class MainController: UIViewController {
    //MARK: Properties
    private let tableView = UITableView()
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupConstraints()
        setupTableViewDelegate()
        self.title = "Collections"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    //MARK: Methods
    private func setupTableViewDelegate() {
        tableView.delegate = self
    }

    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MainTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    //MARK: Constraints
    private func setupConstraints() {
        view.backgroundColor = .white
        //table view
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.snp.horizontalEdges)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
}
// MARK: extension
extension MainController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell") else { return UITableViewCell() }
        switch indexPath.item {
        case 0:
            cell.textLabel?.text = "Array"
        case 1:
            cell.textLabel?.text = "Set"
        case 2:
            cell.textLabel?.text = "Dictionary"
        default:
            break
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            self.navigationController?.pushViewController(ArrayViewController(), animated: true)
        case 1:
            self.navigationController?.pushViewController(SetViewController(), animated: true)
        case 2:
            self.navigationController?.pushViewController(DictionaryViewController(), animated: true)
        default:
            break
        }
    }
}

extension MainController {
    enum Constraints {
        static let titleLabelTop = 80
        static let titleLabelLeading = 20
        static let tableViewTop = 30
    }
}
