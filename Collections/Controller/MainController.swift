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
    private var tableView: CustomTableView!
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
        tableView = CustomTableView()
        tableView.setPresentingViewController(self)
    }
    //MARK: Constraints
    private func setupConstraints() {
        view.backgroundColor = .white
        //title label
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(90)
            make.leading.equalTo(view).offset(20)
            make.trailing.lessThanOrEqualTo(view)
        }
        //table view
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
}
//MARK: UITableViewDelegate
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
