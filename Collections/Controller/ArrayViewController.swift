//
//  ArrayViewController.swift
//  Collections
//
//  Created by SHIN MIKHAIL on 07.07.2023.
import SnapKit
import UIKit

class ArrayViewController: UIViewController {
    private let cellIdentifier = "CollectionViewCell"
    private let combinedCellIdentifier = "CombinedCollectionViewCell"
    private var combinedCells: [UICollectionViewCell] = []
    
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
        navBarTitle.text = "Array: 2412"
        navBarTitle.font = UIFont.boldSystemFont(ofSize: 16)
        navBarTitle.textColor = .black
        navBarTitle.textAlignment = .center
        return navBarTitle
    }()
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Create Int array with 10_000_000 elements"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textColor = .black
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
    
    enum State {
        case start
        case loading
        case complete
    }
    
    private var state: State = .start {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        setupCollectionView()
    }
    
    private func setupNavigationBar() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.titleView = navigationBarLabel
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: combinedCellIdentifier)
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}

extension ArrayViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? 1 : 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 && indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: combinedCellIdentifier, for: indexPath)
            cell.backgroundColor = .backgroundColor
            cell.layer.borderColor = UIColor.customBorderColor.cgColor
            cell.layer.borderWidth = 1.0
            
            let containerView = UIView(frame: CGRect(x: 0, y: 0, width: collectionView.bounds.width, height: cell.bounds.height))
            
            combinedCells.forEach { combinedCell in
                combinedCell.frame.origin = .zero
                containerView.addSubview(combinedCell)
            }
            
            switch state {
            case .start:
                
                titleLabel.frame = containerView.bounds
                containerView.addSubview(titleLabel)
            case .loading:
                titleLabel.text = ""
                let activityIndicator = addActivityIndicator(to: cell)
                activityIndicator.startAnimating()
            case .complete:
                let resultLabel = UILabel()
                resultLabel.text = "Execution time: \(generateIntArray()) seconds"
                resultLabel.font = UIFont.systemFont(ofSize: 16)
                resultLabel.textColor = .black
                resultLabel.textAlignment = .center
                resultLabel.frame = containerView.bounds
                containerView.addSubview(resultLabel)
            }
            
            cell.contentView.addSubview(containerView)
            
            return cell
            
        } else if indexPath.section == 0 && indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
            cell.backgroundColor = .backgroundColor
            cell.layer.borderColor = UIColor.customBorderColor.cgColor
            cell.layer.borderWidth = 1.0
            
            switch state {
            case .start:
                cell.contentView.subviews.forEach { $0.removeFromSuperview() } // Remove existing subviews
                let startLabel = UILabel()
                startLabel.text = "Start"
                startLabel.font = UIFont.systemFont(ofSize: 16)
                startLabel.textColor = .black
                startLabel.textAlignment = .center
                startLabel.frame = cell.contentView.bounds
                cell.contentView.addSubview(startLabel)
            case .loading:
                cell.contentView.subviews.forEach { $0.removeFromSuperview() } // Remove existing subviews
                let activityIndicator = addActivityIndicator(to: cell.contentView as! UICollectionViewCell)
                activityIndicator.startAnimating()
            case .complete:
                cell.contentView.subviews.forEach { $0.removeFromSuperview() } // Remove existing subviews
                let completeLabel = UILabel()
                completeLabel.text = "Complete"
                completeLabel.font = UIFont.systemFont(ofSize: 16)
                completeLabel.textColor = .black
                completeLabel.textAlignment = .center
                completeLabel.frame = cell.contentView.bounds
                cell.contentView.addSubview(completeLabel)
            }
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
            cell.backgroundColor = .backgroundColor
            cell.layer.borderColor = UIColor.customBorderColor.cgColor
            cell.layer.borderWidth = 1.0
            return cell
        }
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
        if indexPath.section == 0 && indexPath.item == 0 {
            state = .loading
            
            DispatchQueue.global().async {
                let executionTimeFormatted = self.generateIntArray()
                print("Execution time: \(executionTimeFormatted) seconds")
                
                DispatchQueue.main.async {
                    self.state = .complete
                }
            }
        }
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
    
}

extension UIColor {
    static let backgroundColor = UIColor(red: 218/255, green: 218/255, blue: 222/255, alpha: 1.0)
    static let customBorderColor = UIColor(red: 206/255, green: 206/255, blue: 209/255, alpha: 1.0)
}
