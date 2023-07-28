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
    private var tableView: CollectionViewTable!
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
        tableView = CollectionViewTable()
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
extension MainController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedRow = indexPath.row
        var newViewController: UIViewController?
        
        switch selectedRow {
        case 0:
            newViewController = ArrayViewController()
        case 1:
            newViewController = SetViewController()
        case 2:
            newViewController = DictionaryViewController()
        default:
            break
        }
        
        if let viewController = newViewController {
            self.navigationController?.pushViewController(viewController, animated: true)
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
