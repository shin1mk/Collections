//
//  ArrayViewController.swift
//  Collections
//
//  Created by SHIN MIKHAIL on 07.07.2023.

import UIKit
import SnapKit

final class ArrayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
        titleLabel.text = "Array:"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    private let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    private var numberOfSections = 0
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        setupTableView()
        setupCollectionView()
    }
    
    //MARK: TableView
    private func setupTableView() {
        tableView.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        setupTableViewDelegate()
        setupTableViewConstraints()
    }
    
    private func setupTableViewDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupTableViewConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
    }
    
    //MARK: CollectionView
    private func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CollectionCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        setupCollectionViewConstraints()
    }
    
    private func setupCollectionViewConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    //MARK: - UITableViewDataSource methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "Create Int array with 10_000_000 elements"
        cell.backgroundColor = .backgroundColor
        cell.textLabel?.textColor = .systemBlue
        cell.textLabel?.textAlignment = .center
        return cell
    }
    
    //MARK: - UITableViewDelegate methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.textLabel?.text = ""
            
            let activityIndicator = UIActivityIndicatorView(style: .medium)
            activityIndicator.color = .darkGray
            activityIndicator.startAnimating()
            cell.contentView.addSubview(activityIndicator)
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                activityIndicator.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
                activityIndicator.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor)
            ])
            
            DispatchQueue.global().async {
                let executionTime = self.generateIntArray()
                DispatchQueue.main.async {
                    activityIndicator.removeFromSuperview()
                    cell.textLabel?.text = "Array generation time: \(executionTime)"
                }
            }
        }
    }
    
    //MARK: - UICollectionViewDataSource methods
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numberOfSections // Количество рядов
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6 // Количество ячеек в каждом ряду
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath)
        cell.backgroundColor = .backgroundColor
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.customBorderColor.cgColor
        
        let texts = ["гывпролфвып"]
        let textLabel = UILabel(frame: cell.bounds)
        textLabel.text = texts.first
        textLabel.textColor = .systemBlue
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 0
        cell.contentView.addSubview(textLabel)
        
        return cell
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout methods
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.bounds.width - 0) / 2 // Добавляем отступ между ячейками
        let cellHeight = collectionView.bounds.height / 6 // Делим высоту на количество рядов
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    //MARK: - Private methods
    
    private func generateIntArray() -> Double {
        var array = [Int]()
        let start = CACurrentMediaTime()
        for i in 0..<10_000_000 {
            array.append(i)
        }
        let end = CACurrentMediaTime()
        let executionTime = end - start
        let roundedTime = (executionTime * 100).rounded() / 100
        
        numberOfSections = 2
        DispatchQueue.main.async {
            self.collectionView.reloadData() // Reload collection view data on the main thread
        }
        return roundedTime
    }
    
    //MARK: Navigation bar
    private func setupNavigationBar() {
        setupBackButtonTarget()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.titleView = titleLabel
    }
    
    private func setupBackButtonTarget() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}




extension UIColor {
    static let backgroundColor = UIColor(red: 218/255, green: 218/255, blue: 222/255, alpha: 1.0)
    static let customBorderColor = UIColor(red: 206/255, green: 206/255, blue: 209/255, alpha: 1.0)
}
