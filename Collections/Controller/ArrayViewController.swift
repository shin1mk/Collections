//
//  ArrayViewController.swift
//  Collections
//
//  Created by SHIN MIKHAIL on 07.07.2023.
import SnapKit
import UIKit

enum State {
    case start
    case loading
    case complete
}

final class ArrayViewController: UIViewController {
    //MARK: - Properties
    private let cellIdentifier = "CollectionViewCell"
    private let combinedCellIdentifier = "CombinedCollectionViewCell"
    private var combinedCells: [UICollectionViewCell] = []
    private var cellStates: [IndexPath: (state: State, result: String)] = [:]

    private let cellTitles = [
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
        "Remove 1000 elements at the end of the array"
    ]
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
    private let navigationBarLabel: UILabel = {
        let navBarTitle = UILabel()
        navBarTitle.text = "Array: 5696"
        navBarTitle.font = UIFont.boldSystemFont(ofSize: 18)
        navBarTitle.textColor = .black
        navBarTitle.textAlignment = .center
        return navBarTitle
    }()
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textColor = .systemBlue
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        return collectionView
    }()
    private var state: State = .start {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupCollectionView()
    }
    
    private func setupNavigationBar() {
        setupBackButtonTarget()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.titleView = navigationBarLabel
    }
    
    private func setupBackButtonTarget() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupCollectionView() {
        setupCollectionViewDataSourceAndDelegate()
        registerCollectionViewCells()
        setupCollectionViewConstraints()
    }
    
    private func setupCollectionViewDataSourceAndDelegate() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func registerCollectionViewCells() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: combinedCellIdentifier)
    }
    
    private func setupCollectionViewConstraints() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
} // ArrayViewController
//MARK: - extension arrayViewController
extension ArrayViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          if section == 0 {
              return 1 // Always show the first cell (generateIntArray cell)
          } else {
              return state == .complete ? cellTitles.count / 2 : 0 // Show other cells only if state is .complete
          }
      }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 && indexPath.item == 0 {
            return configureCombinedCell(collectionView: collectionView, indexPath: indexPath)
        } else {
            return configureRegularCell(collectionView: collectionView, indexPath: indexPath)
        }
    }
    // первая ячейка
    private func configureCombinedCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: combinedCellIdentifier, for: indexPath)
        cell.backgroundColor = .backgroundColor
        cell.layer.borderColor = UIColor.customBorderColor.cgColor
        cell.layer.borderWidth = 1.0
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: collectionView.bounds.width, height: cell.bounds.height))
        
        if combinedCells.isEmpty {
            // Create and add cells to combinedCells
            for _ in 0..<2 {
                let subCell = UICollectionViewCell()
                combinedCells.append(subCell)
            }
        }
        
        switch state {
        case .start:
            titleLabel.text = "Create Int array with 10_000_000 elements"
            titleLabel.frame = containerView.bounds
            containerView.addSubview(titleLabel)
        case .loading:
            titleLabel.text = ""
            let activityIndicator = addActivityIndicator(to: cell)
            activityIndicator.startAnimating()
        case .complete:
            let resultLabel = UILabel()
            resultLabel.text = "Execution time: \(generateIntArray()) seconds"
            resultLabel.font = UIFont.systemFont(ofSize: 18)
            resultLabel.textColor = .systemBlue
            resultLabel.textAlignment = .center
            resultLabel.frame = containerView.bounds
            containerView.addSubview(resultLabel)
        }
        
        cell.contentView.addSubview(containerView)
        return cell
    }
    // остальные ячейки
    private func configureRegularCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        cell.backgroundColor = .backgroundColor
        cell.layer.borderColor = UIColor.customBorderColor.cgColor
        cell.layer.borderWidth = 1.0

        let titlesPerSection = 2 // Each section has 2 items
        let titlesIndex = (indexPath.section - 1) * titlesPerSection + indexPath.item
        
        if titlesIndex >= 0 && titlesIndex < cellTitles.count {
            let title = cellTitles[titlesIndex]
            addTitleLabel(to: cell, withTitle: title)
        }
        
        if let (state, result) = cellStates[indexPath] {
            switch state {
            case .start:
                // Show the cell content as it was before
                cell.contentView.isHidden = false
                cell.contentView.subviews.forEach { subview in
                    if subview is UIActivityIndicatorView || subview is UILabel {
                        subview.removeFromSuperview()
                    }
                }
            case .loading:
                // Show the activity indicator
                let activityIndicator = addActivityIndicator(to: cell)
                activityIndicator.startAnimating()
            case .complete:
                // Show the result
                let resultLabel = UILabel(frame: cell.bounds)
                resultLabel.font = UIFont.systemFont(ofSize: 14)
                resultLabel.textColor = .systemBlue
                resultLabel.textAlignment = .center
                resultLabel.text = result
                resultLabel.numberOfLines = 0
                cell.contentView.subviews.forEach { subview in
                    if subview is UIActivityIndicatorView || subview is UILabel {
                        subview.removeFromSuperview()
                    }
                }
                cell.contentView.addSubview(resultLabel)
            }
        }
        
        return cell
    }

    
    
    private func addTitleLabel(to cell: UICollectionViewCell, withTitle title: String) {
        cell.contentView.subviews.forEach { subview in
            if subview is UILabel {
                subview.removeFromSuperview()
            }
        }
        let titleLabel = UILabel(frame: cell.bounds)
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textColor = .systemBlue
        titleLabel.textAlignment = .center
        titleLabel.text = title
        titleLabel.numberOfLines = 0
        cell.contentView.addSubview(titleLabel)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = collectionView.bounds.width
        let itemWidth: CGFloat
        let itemHeight: CGFloat = 105
        if indexPath.section == 0 && indexPath.item == 0 {
            itemWidth = availableWidth
        } else {
            itemWidth = availableWidth / 2
        }
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.item == 0 && state != .complete {
            state = .loading
            DispatchQueue.global().async {
                let executionTimeFormatted = self.generateIntArray()
                print("Execution time: \(executionTimeFormatted) seconds")
                DispatchQueue.main.async {
                    self.cellStates[indexPath] = (.complete, "Execution time: \(executionTimeFormatted) seconds")
                    self.state = .complete
                }
            }
        } else if indexPath.section == 1 && indexPath.item == 0 {
            state = .loading
            
            DispatchQueue.global().async {
                let executionTimeFormatted = self.insertElementsToStartOfArray()
                print("Execution time: \(executionTimeFormatted) seconds")

                DispatchQueue.main.async {
                    self.cellStates[indexPath] = (.complete, "Execution time: \(executionTimeFormatted) seconds")
                    self.state = .complete
                }
            }
        }
    }


    
    private func insertElementsToStartOfArray() -> String {
        var array = [Int]()
        let start = CACurrentMediaTime()

        // Генерируем массив с 10_000_000 элементов, как в вашей функции generateIntArray()
        for i in 0..<10_000_000 {
            array.append(i)
        }

        // Вставляем 1000 элементов в начало массива по одному
        for i in (0..<1000).reversed() {
            array.insert(i, at: 0)
        }

        let end = CACurrentMediaTime()
        let executionTime = end - start
        let executionTimeFormatted = String(format: "%.2f", executionTime)
        return executionTimeFormatted
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    private func generateIntArray() -> String {
        var array = [Int]()
        let start = CACurrentMediaTime()
        for i in 0..<10_000_000 {
            array.append(i)
        }
        let end = CACurrentMediaTime()
        let executionTime = end - start
        let executionTimeFormatted = String(format: "%.2f", executionTime)
        return executionTimeFormatted
    }
    
    private func addActivityIndicator(to cell: UICollectionViewCell) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .darkGray
        activityIndicator.startAnimating()
        cell.contentView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: cell.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: cell.centerYAnchor)
        ])
        return activityIndicator
    }
} // extension
//MARK: - Colors
extension UIColor {
    static let backgroundColor = UIColor(red: 218/255, green: 218/255, blue: 222/255, alpha: 1.0)
    static let customBorderColor = UIColor(red: 206/255, green: 206/255, blue: 209/255, alpha: 1.0)
}
