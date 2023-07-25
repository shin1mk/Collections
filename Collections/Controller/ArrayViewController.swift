//
//  ArrayViewController.swift
//  Collections
//
//  Created by SHIN MIKHAIL on 07.07.2023.

import UIKit
import SnapKit

final class ArrayViewController: UIViewController {
    private let arrayOperations = ArrayOperations()
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
//        collectionView.backgroundColor = .mainBackgroundColor
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
}
// MARK: - Data Source
extension ArrayViewController: UICollectionViewDataSource {
    // Number of items
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return firstCellArray.count
    }
    // CellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArrayCollectionViewCell", for: indexPath) as! ArrayCollectionViewCell
        cell.textToShow = firstCellArray[indexPath.row]
        return cell
    }
}

extension ArrayViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ArrayCollectionViewCell else { return }
        switch indexPath.item {
        case 0:
            cell.appState = .loading
            self.arrayOperations.generateIntArray { time in
                self.firstCellArray[0] = "Array generation time: \(time)"
                self.firstCellArray.append(contentsOf: self.secondCellsArray)
                collectionView.reloadData()
                cell.appState = .complete(result: time)
                cell.isUserInteractionEnabled = false
            }
        case 1:
            cell.appState = .loading
            self.arrayOperations.insertElementsBeginningOneByOne { time in
                cell.appState = .complete(result: time)
                cell.isUserInteractionEnabled = false
            }
        case 2:
            cell.appState = .loading
            self.arrayOperations.insertElementsBeginningAtOnce { time in
                cell.appState = .complete(result: time)
                cell.isUserInteractionEnabled = false
            }
        case 3:
            cell.appState = .loading
            self.arrayOperations.insertElementsMiddleOnebyOne { time in
                cell.appState = .complete(result: time)
                cell.isUserInteractionEnabled = false
            }
        case 4:
            cell.appState = .loading
            self.arrayOperations.insertElementsMiddleAtOnce { time in
                cell.appState = .complete(result: time)
                cell.isUserInteractionEnabled = false
            }
        case 5:
            cell.appState = .loading
            self.arrayOperations.insertElementsEndOnebyOne { time in
                cell.appState = .complete(result: time)
                cell.isUserInteractionEnabled = false
            }
        case 6:
            cell.appState = .loading
            self.arrayOperations.insertElementsEndAtOnce { time in
                cell.appState = .complete(result: time)
                cell.isUserInteractionEnabled = false
            }
        case 7:
            cell.appState = .loading
            self.arrayOperations.removeElementsBeginningOnebyOne { time in
                cell.appState = .complete(result: time)
                cell.isUserInteractionEnabled = false
            }
        case 8:
            cell.appState = .loading
            self.arrayOperations.removeElementsBeginningAtOnce { time in
                cell.appState = .complete(result: time)
                cell.isUserInteractionEnabled = false
            }
        case 9:
            cell.appState = .loading
            self.arrayOperations.removeElementsMiddleOnebyOne { time in
                cell.appState = .complete(result: time)
                cell.isUserInteractionEnabled = false
            }
        case 10:
            cell.appState = .loading
            self.arrayOperations.removeElementsMiddleAtOnce { time in
                cell.appState = .complete(result: time)
                cell.isUserInteractionEnabled = false
            }
        case 11:
            cell.appState = .loading
            self.arrayOperations.removeElementsEndOnebyOne { time in
                cell.appState = .complete(result: time)
                cell.isUserInteractionEnabled = false
            }
        case 12:
            cell.appState = .loading
            self.arrayOperations.removeElementsEndAtOnce { time in
                cell.appState = .complete(result: time)
                cell.isUserInteractionEnabled = false
            }
        default:
            break
        }
    }
}
//MARK: sizeForItemAt размер и отступы
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
