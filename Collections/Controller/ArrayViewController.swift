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
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
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
    private var titles = [
        "Insert 1000 elements at the beginning of the array one-by-one",
        "Insert 1000 elements at the beginning of the array all at once",
        "Insert 1000 elements in the middle of the array one-by-one",
        "Insert 1000 elements in the middle of the array all at once",
        "Insert 1000 elements in the end of the array one-by-one",
        "Insert 1000 elements in the end of the array all at once",
        "Remove 1000 elements at the beginning of the array one-by-one",
        "Remove 1000 elements at the beginning of the array",
        "Remove 1000 elements in the middle of the array one-by-one",
        "Remove 1000 elements in the middle of the array",
        "Remove 1000 elements at the end of the array end by-one-one",
        "Remove 1000 elements at the end of the array",
    ]
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        setupView()
    }
    
    private func setupView() {
        setupViewDelegate()
        setupViewConstraints()
    }
    
    private func setupViewDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupViewConstraints() {
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
    //MARK: - Navigation bar
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
    //MARK: - UI Table View methods
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
    
    func addActivityIndicator(to cell: UITableViewCell) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .darkGray
        activityIndicator.startAnimating()
        cell.contentView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor)
        ])
        return activityIndicator
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard !isTaskRunning else {
            return
        }
        isTaskRunning = true
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.textLabel?.text = ""
            let activityIndicator = addActivityIndicator(to: cell)
            DispatchQueue.global().async {
                let executionTime = self.generateIntArray()
                DispatchQueue.main.async {
                    activityIndicator.removeFromSuperview()
                    cell.textLabel?.text = "Array generation time: \(executionTime)"
                }
            }
        }
    }
    //MARK: - Private methods
    private func generateIntArray() -> String {
        var array = [Int]()
        let start = CACurrentMediaTime()
        for i in 0..<10_000_000 {
            array.append(i)
        }
        let end = CACurrentMediaTime()
        let executionTime = end - start
        let executionTimeFormatted = String(format: "%.2f", executionTime)
        numberOfSections = 1
        DispatchQueue.main.async {
            self.collectionView.reloadData() // Reload collection view
        }
        return executionTimeFormatted
    }
    
    //MARK: - UI Collection View methods
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numberOfSections // rows
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.bounds.width - 0) / 2 // отступ
        let cellHeight = collectionView.bounds.height / 6
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath)
        cell.backgroundColor = .backgroundColor
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.customBorderColor.cgColor
        
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        
        let textLabel = UILabel(frame: cell.bounds)
        textLabel.text = titles[indexPath.item]
        textLabel.textColor = .systemBlue
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 0
        cell.contentView.addSubview(textLabel)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let array = generateIntArray().components(separatedBy: ", ").compactMap { Int($0) }
        
        switch indexPath.item {
        case 0:
            insertElementsOneByOne(array: array)
        case 1:
            insertElementsAllAtOnce(array: array)
        case 2:
            insertElementsIndividually(array: array)
        case 3:
            insertElementsAtOnce(array: array)
        case 4:
            appendElementsIndividually(array: array)
        case 5:
            appendElementsAtOnce(array: array)
        case 6:
            removeElementsIndividually(array: array)
        case 7:
            removeElementsAtOnce(array: array)
        case 8:
            removeElementsOneByOneFromMiddle(array: array)
        case 9:
            removeElementsAtOnceFromMiddle(array: array)
        case 10:
            removeElementsOneByOneFromEnd(array: array)
        case 11:
            removeElementsAtOnceFromEnd(array: array)
        default:
            break
        }
    }
    //MARK: - row 1
    func insertElementsOneByOne(array: [Int]) {
        var array = array
        let start = CACurrentMediaTime()
        for i in (0..<1000).reversed() {
            array.insert(i, at: 0)
        }
        let end = CACurrentMediaTime()
        let executionTime = end - start
        let indexPath = IndexPath(item: 0, section: 0)
        titles[indexPath.item] = String(format: "Execution time: %.5f seconds", executionTime)
        if let cell = collectionView.cellForItem(at: indexPath) {
            if let textLabel = cell.contentView.subviews.first as? UILabel {
                textLabel.text = titles[indexPath.item]
            }
        }
    }
    
    func insertElementsAllAtOnce(array: [Int]) {
        var array = array
        let start = CACurrentMediaTime()
        let newElements = Array(0..<1000)
        array.insert(contentsOf: newElements, at: 0)
        let end = CACurrentMediaTime()
        let executionTime = end - start
        let indexPath = IndexPath(item: 1, section: 0)
        titles[indexPath.item] = String(format: "Execution time: %.5f seconds", executionTime)
        if let cell = collectionView.cellForItem(at: indexPath) {
            if let textLabel = cell.contentView.subviews.first as? UILabel {
                textLabel.text = titles[indexPath.item]
            }
        }
    }
    //MARK: - row2
    func insertElementsIndividually(array: [Int]) {
        var array = array
        let start = CACurrentMediaTime()
        let numberOfElements = 1000
        for i in 0..<numberOfElements {
            let element = i + 1
            let middleIndex = array.count / 2
            array.insert(element, at: middleIndex)
        }
        let end = CACurrentMediaTime()
        let executionTime = end - start
        let indexPath = IndexPath(item: 2, section: 0)
        titles[indexPath.item] = String(format: "Execution time: %.5f seconds", executionTime)
        if let cell = collectionView.cellForItem(at: indexPath) {
            if let textLabel = cell.contentView.subviews.first as?
                UILabel {
                textLabel.text = titles[indexPath.item]
            }
        }
    }
    
    func insertElementsAtOnce(array: [Int]) {
        var array = array
        let start = CACurrentMediaTime()
        let numberOfElements = 1000
        var elementsToInsert = [Int]()
        for i in 0..<numberOfElements {
            let element = i + 1
            elementsToInsert.append(element)
        }
        let middleIndex = array.count / 2
        array.insert(contentsOf: elementsToInsert, at: middleIndex)
        let end = CACurrentMediaTime()
        let executionTime = end - start
        let indexPath = IndexPath(item: 3, section: 0)
        titles[indexPath.item] = String(format: "Execution time: %.5f seconds", executionTime)
        if let cell = collectionView.cellForItem(at: indexPath) {
            if let textLabel = cell.contentView.subviews.first as?
                UILabel {
                textLabel.text = titles[indexPath.item]
            }
        }
    }
    //MARK: - row3
    func appendElementsIndividually(array: [Int]) {
        var array = array
        let numberOfElements = 1000
        let start = CACurrentMediaTime()
        for i in 0..<numberOfElements {
            let element = i + 1
            array.append(element)
        }
        let end = CACurrentMediaTime()
        let executionTime = end - start
        let indexPath = IndexPath(item: 4, section: 0)
        titles[indexPath.item] = String(format: "Execution time: %.5f seconds", executionTime)
        if let cell = collectionView.cellForItem(at: indexPath) {
            if let textLabel = cell.contentView.subviews.first as? UILabel {
                textLabel.text = titles[indexPath.item]
            }
        }
    }
    
    func appendElementsAtOnce(array: [Int]) {
        var array = array
        let numberOfElements = 1000
        let start = CACurrentMediaTime()
        var elementsToAdd = [Int]()
        for i in 0..<numberOfElements {
            let element = i + 1
            elementsToAdd.append(element)
        }
        array.append(contentsOf: elementsToAdd)
        let end = CACurrentMediaTime()
        let executionTime = end - start
        let indexPath = IndexPath(item: 5, section: 0)
        titles[indexPath.item] = String(format: "Execution time: %.5f seconds", executionTime)
        if let cell = collectionView.cellForItem(at: indexPath) {
            if let textLabel = cell.contentView.subviews.first as? UILabel {
                textLabel.text = titles[indexPath.item]
            }
        }
    }
    
    //MARK: - row4
    func removeElementsIndividually(array: [Int]) {
        var array = array
        let start = CACurrentMediaTime()
        
        let numberOfElementsToRemove = min(1000, array.count)
        for _ in 0..<numberOfElementsToRemove {
            array.removeFirst()
        }
        let end = CACurrentMediaTime()
        let executionTime = end - start
        let indexPath = IndexPath(item: 6, section: 0)
        titles[indexPath.item] = String(format: "Execution time: %.5f seconds", executionTime)
        if let cell = collectionView.cellForItem(at: indexPath) {
            if let textLabel = cell.contentView.subviews.first as? UILabel {
                textLabel.text = titles[indexPath.item]
            }
        }
    }
    
    func removeElementsAtOnce(array: [Int]) {
        var array = array
        let start = CACurrentMediaTime()
        
        let numberOfElementsToRemove = min(1000, array.count)
        if numberOfElementsToRemove > 0 {
            array.removeFirst(numberOfElementsToRemove)
        }
        let end = CACurrentMediaTime()
        let executionTime = end - start
        let indexPath = IndexPath(item: 7, section: 0)
        titles[indexPath.item] = String(format: "Execution time: %.5f seconds", executionTime)
        if let cell = collectionView.cellForItem(at: indexPath) {
            if let textLabel = cell.contentView.subviews.first as? UILabel {
                textLabel.text = titles[indexPath.item]
            }
        }
    }
    //MARK: - row5
    func removeElementsOneByOneFromMiddle(array: [Int]) {
        var array = array
        let start = CACurrentMediaTime()
        
        let startIndex = array.count / 2 - 500
        let endIndex = startIndex + 999
        if startIndex >= 0 && endIndex < array.count {
            for i in stride(from: endIndex, through: startIndex, by: -1) {
                array.remove(at: i)
            }
        }
        let end = CACurrentMediaTime()
        let executionTime = end - start
        let indexPath = IndexPath(item: 8, section: 0)
        titles[indexPath.item] = String(format: "Execution time: %.5f seconds", executionTime)
        if let cell = collectionView.cellForItem(at: indexPath) {
            if let textLabel = cell.contentView.subviews.first as? UILabel {
                textLabel.text = titles[indexPath.item]
            }
        }
    }
    
    func removeElementsAtOnceFromMiddle(array: [Int]) {
        var array = array
        let start = CACurrentMediaTime()
        
        let startIndex = array.count / 2 - 500
        let endIndex = startIndex + 999
        
        if startIndex >= 0 && endIndex < array.count {
            array.removeSubrange(startIndex...endIndex)
        }
        let end = CACurrentMediaTime()
        let executionTime = end - start
        let indexPath = IndexPath(item: 9, section: 0)
        titles[indexPath.item] = String(format: "Execution time: %.5f seconds", executionTime)
        if let cell = collectionView.cellForItem(at: indexPath) {
            if let textLabel = cell.contentView.subviews.first as? UILabel {
                textLabel.text = titles[indexPath.item]
            }
        }
    }
    //MARK: - row6
    func removeElementsOneByOneFromEnd(array: [Int]) {
        var mutableArray = array
        let start = CACurrentMediaTime()
        let numberOfElementsToRemove = min(1000, mutableArray.count)
        for _ in 0..<numberOfElementsToRemove {
            mutableArray.removeLast()
        }
        let end = CACurrentMediaTime()
        let executionTime = end - start
        DispatchQueue.main.async { [weak self] in
            let indexPath = IndexPath(item: 10, section: 0)
            self?.titles[indexPath.item] = String(format: "Execution time: %.5f seconds", executionTime)
            if let cell = self?.collectionView.cellForItem(at: indexPath) {
                if let textLabel = cell.contentView.subviews.first as? UILabel {
                    textLabel.text = self?.titles[indexPath.item]
                }
            }
        }
    }
    
    func removeElementsAtOnceFromEnd(array: [Int]) {
        var mutableArray = array
        let start = CACurrentMediaTime()
        let numberOfElementsToRemove = min(1000, mutableArray.count)
        if numberOfElementsToRemove > 0 {
            let range = (mutableArray.count - numberOfElementsToRemove)..<mutableArray.count
            mutableArray.removeSubrange(range)
        }
        let end = CACurrentMediaTime()
        let executionTime = end - start
        DispatchQueue.main.async { [weak self] in
            let indexPath = IndexPath(item: 11, section: 0)
            self?.titles[indexPath.item] = String(format: "Execution time: %.5f seconds", executionTime)
            if let cell = self?.collectionView.cellForItem(at: indexPath) {
                if let textLabel = cell.contentView.subviews.first as? UILabel {
                    textLabel.text = self?.titles[indexPath.item]
                }
            }
        }
    }
} // class
//MARK: - UIColor
extension UIColor {
    static let backgroundColor = UIColor(red: 218/255, green: 218/255, blue: 222/255, alpha: 1.0)
    static let customBorderColor = UIColor(red: 206/255, green: 206/255, blue: 209/255, alpha: 1.0)
}
