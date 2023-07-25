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
    private let titleLabel: UILabel = {
        let title = UILabel()
        title.text = "Collections"
        title.font = UIFont.boldSystemFont(ofSize: 34)
        title.textColor = .black
        return title
    }()
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupConstraints()
        setupTableViewDelegate()
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
        //title label
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(Constraints.titleLabelTop)
            make.leading.equalTo(view).offset(Constraints.titleLabelLeading)
            make.trailing.lessThanOrEqualTo(view)
        }
        //table view
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constraints.tableViewTop)
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
