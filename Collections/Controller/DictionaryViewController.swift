//
//  DictionaryViewController.swift
//  Collections
//
//  Created by SHIN MIKHAIL on 07.07.2023.
//

import UIKit
import SnapKit

final class DictionaryViewController: UIViewController {
    //MARK: Properties
    private let backButton: UIButton = {
        let button = UIButton()
        let arrowImage = UIImage(systemName: "chevron.left")?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
        button.setImage(arrowImage, for: .normal)
        button.setTitle("Collections", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        button.contentHorizontalAlignment = .left
        return button
    }()
    private let titleLabel: UILabel = {
          let titleLabel = UILabel()
          titleLabel.text = "Dictionary:"
          titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
          titleLabel.textColor = .black
          titleLabel.textAlignment = .center
          return titleLabel
      }()
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
    }
    //MARK: Navigation bar
    private func setupNavigationBar() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.titleView = titleLabel
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
