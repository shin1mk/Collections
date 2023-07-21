//
//  ArrayViewController.swift
//  Collections
//
//  Created by SHIN MIKHAIL on 07.07.2023.

import UIKit
import SnapKit

final class ArrayViewController: UIViewController {
    //MARK: Properties
    private var firstCellArray = ["Create Int array with 10_000_000 elements"]
    private var secondCellsArray = [
        "Insert 1000 elements at the beginning of the array one-by-one",
        "Insert 1000 elements at the beginning of the array at once",
        "Insert 1000 elements in the middle of the array one-by-one",
        "Insert 1000 elements in the middle of the array all at once",
        "Insert 1000 elements in the end of the array one-by-one",
        "Insert 1000 elements in the end of the array all at once",
        "Remove 1000 elements at the beginning of the array one-by-one",
        "Remove 1000 elements at the beginning of the array",
        "Remove 1000 elements in the middle of the array one-by-one",
        "Remove 1000 elements in the middle of the array",
        "Remove 1000 elements at the end of of the array by-one-one",
        "Remove 1000 elements at the end the array",
    ]
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
    private var collectionView: UICollectionView!
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupCollectionView()
        setupConstraint()
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
    // MARK: Collection View
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ArrayCollectionViewCell.self, forCellWithReuseIdentifier: "ArrayCollectionViewCell")

    }
    
    private func setupConstraint() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    //MARK: generateIntArrayWithSize в отдельный метод
    func generateIntArray() -> String {
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
} // end of class ArrayViewController {
// MARK: - Data Source
extension ArrayViewController: UICollectionViewDataSource {
    //MARK: Number of items
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return firstCellArray.count
    }
    //MARK: CellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArrayCollectionViewCell", for: indexPath) as! ArrayCollectionViewCell
        cell.textToShow = firstCellArray[indexPath.row]

        return cell
    }
}
// MARK: - DidSelect
extension ArrayViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ArrayCollectionViewCell else {
            return
        }
        switch indexPath.item {
        case 0:
            print("it’s 0")
            cell.textToShow = "State 0"
        case 1:
            print("it’s 1")
            cell.textToShow = "State 1"
        case 2:
            print("it’s 2")
            cell.textToShow = "State 2"
        case 3:
            print("it’s 3")
            cell.textToShow = "State 3"
        case 4:
            print("it’s 4")
            cell.textToShow = "State 4"
        case 5:
            print("it’s 5")
            cell.textToShow = "State 5"
        case 6:
            print("it’s 6")
            cell.textToShow = "State 6"
        case 7:
            print("it’s 7")
            cell.textToShow = "State 7"
        case 8:
            print("it’s 8")
            cell.textToShow = "State 8"
        case 9:
            print("it’s 9")
            cell.textToShow = "State 9"
        case 10:
            print("it’s 10")
            cell.textToShow = "State 10"
        case 11:
            print("it’s 11")
            cell.textToShow = "State 11"
        case 12:
            print("it’s 12")
            cell.textToShow = "State 12"
        default:
            print("oups")
        }
        // 1 раз добавим second в first
        if firstCellArray.count <= 1 {
            firstCellArray.append(contentsOf: secondCellsArray)
            collectionView.reloadData()
        }
    }
}

//MARK: FlowLayout настраиваем размер и отступы
extension ArrayViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: collectionView.bounds.width, height: 100)
        } else {
            return CGSize(width: collectionView.bounds.width / 2, height: 100)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.5
    }
}
//MARK: Colors
extension UIColor {
    static let backgroundColor = UIColor(red: 218/255, green: 218/255, blue: 222/255, alpha: 1.0)
    static let customBorderColor = UIColor(red: 206/255, green: 206/255, blue: 209/255, alpha: 1.0)
}
