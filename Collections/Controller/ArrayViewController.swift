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
        titleLabel.text = "Array: 5696"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .customBorderColor
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CollectionCell")
        return collectionView
    }()
    private var isTaskRunning = false
    private var numberOfSections = 0
    private let titles = [
        "1 Insert 1000 elements at the beginning of the array one-by-one",
        "2 Execution time: 0.09",
        "3 Insert 1000 elements in the middle of the array one-by-one",
        "4 Insert 1000 elements in the middle of the array all at once",
        "5 Insert 1000 elements in the end of the array one-by-one",
        "6 Insert 1000 elements in the end of the array all at once",
        "7 Remove 1000 elements at the beginning of the array one-by-one",
        "8 Remove 1000 elements at the beginning of the array",
        "9 Remove 1000 elements in the middle of the array one-by-one",
        "10 Remove 1000 elements in the middle of the array",
        "11 Remove 1000 elements at the end of the array end by-one-one",
        "12 Remove 1000 elements at the end of the array",
    ] // Заголовки для каждой ячейки
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        setupTableView()
    }
    //MARK: TableView
    private func setupTableView() {
        setupTableViewDelegate()
        setupTableViewConstraints()
    }
    
    private func setupTableViewDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setupTableViewConstraints() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
        view.addSubview(collectionView)
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
        cell.backgroundColor = .backgroundColor
        cell.textLabel?.text = "Create Int array with 10_000_000 elements"
        cell.textLabel?.textColor = .systemBlue
        cell.textLabel?.textAlignment = .center
        return cell
    }
    //MARK: - UITableViewDelegate methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard !isTaskRunning else {
               return // Если выполняется, игнорируем
           }
           
           isTaskRunning = true
        
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
    //MARK: - CollectionView
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numberOfSections // rows
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        return 6
        return titles.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath)
        cell.backgroundColor = .backgroundColor
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.customBorderColor.cgColor
        
        let functions = [
            function1,
            function2,
            function3,
            function4,
            function5,
            function6,
            function7,
            function8,
            function9,
            function10,
            function11,
            function12,
        ] // Функции для каждой ячейки
        
        let textLabel = UILabel(frame: cell.bounds)
        textLabel.text = titles[indexPath.item]
        textLabel.textColor = .systemBlue
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 0
        cell.contentView.addSubview(textLabel)
        
        // Вызов функции для каждой ячейки
        let function = functions[indexPath.item]
        function()
        
        return cell
    }
    
    // Пример функций для каждой ячейки
    func function1() {
        // Логика для ячейки 1
    }
    
    func function2() {
        // Логика для ячейки 2
    }
    
    func function3() {
        // Логика для ячейки 3
    }
    
    func function4() {
        // Логика для ячейки 4
    }
    
    func function5() {
        // Логика для ячейки 5
    }
    
    func function6() {
        // Логика для ячейки 6
    }
    
    func function7() {
        // Логика для ячейки 7
    }
    
    func function8() {
        // Логика для ячейки 8
    }
    
    func function9() {
        // Логика для ячейки 9
    }
    
    func function10() {
        // Логика для ячейки 10
    }
    
    func function11() {
        // Логика для ячейки 11
    }
    
    func function12() {
        // Логика для ячейки 12
    }
    
    //MARK: - UICollectionViewDelegateLayout methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.bounds.width - 0) / 2 // отступ
        let cellHeight = collectionView.bounds.height / 6
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
        
        numberOfSections = 1
        DispatchQueue.main.async {
            self.collectionView.reloadData() // Reload collection view
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
//MARK: - UIColor
extension UIColor {
    static let backgroundColor = UIColor(red: 218/255, green: 218/255, blue: 222/255, alpha: 1.0)
    static let customBorderColor = UIColor(red: 206/255, green: 206/255, blue: 209/255, alpha: 1.0)
}
