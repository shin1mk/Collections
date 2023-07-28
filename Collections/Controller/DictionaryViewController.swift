//
//  DictionaryViewController.swift
//  Collections
//
//  Created by SHIN MIKHAIL on 07.07.2023.
//

import UIKit
import SnapKit

final class DictionaryViewController: UIViewController {
    //MARK: UI elements
    let dictionaryOperations = DictionaryOperations()
    let labelsArray: [String] = [
        "Array",
        "Dictionary",
        "Find the first contact",
        "Find the first contact",
        "Find the last contact",
        "Find the last contact",
        "Find the non-existing element",
        "Find the non-existing element"
    ]
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(DictionaryViewCell.self, forCellWithReuseIdentifier: "DictionaryViewCell")
        return collectionView
    }()
    var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        return activityIndicator
    }()
    //MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupContraints()
        generateDataAndReloadCollectionView()
    }
    //MARK: Navigation bar
    private func setupNavigationBar() {
        self.navigationItem.title = "Dictionary"
    }
    
    private func setupContraints() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints{ make in
            make.center.equalToSuperview()
        }
    }
    
    private func generateDataAndReloadCollectionView() {
        self.activityIndicator.startAnimating()
        DispatchQueue.global(qos: .userInitiated).async {
            self.dictionaryOperations.generateContactsArray()
            self.dictionaryOperations.generateDictionaryArray()
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.collectionView.reloadData()
                self.collectionView.delegate = self
                self.collectionView.dataSource = self
            }
        }
    }
}
// MARK: extensions - delegate
extension DictionaryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return labelsArray.count
    }    
    // CellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DictionaryViewCell", for: indexPath) as? DictionaryViewCell else
        { return UICollectionViewCell() }
        
        let item = labelsArray[indexPath.row]
        cell.textToShow = item
        if indexPath.row <= 1 {
            cell.backgroundColor = .white
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.lightGray.cgColor
        } else {
            cell.backgroundColor = .backgroundColor
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.lightGray.cgColor
        }
        cell.appState = .start
        return cell
    }
}
//DidSelectItemAt
extension DictionaryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? DictionaryViewCell else { return }
        switch indexPath.item {
        case 0:
            cell.isUserInteractionEnabled = false
        case 1:
            cell.isUserInteractionEnabled = false
        case 2:
            cell.appState = .loading
            self.dictionaryOperations.findFirstElenemtInArray { time, indexPath in
                cell.appState = .complete(result: time, positionOfElement: indexPath)
                cell.isUserInteractionEnabled = false
            }
        case 3:
            cell.appState = .loading
            self.dictionaryOperations.findFirstElenemtInArray { time, element in
                cell.appState = .complete(result: time, positionOfElement: element)
                cell.isUserInteractionEnabled = false
            }
        case 4:
            cell.appState = .loading
            self.dictionaryOperations.findLastElenemtInArray { time, indexPath in
                cell.appState = .complete(result: time, positionOfElement: indexPath)
                cell.isUserInteractionEnabled = false
            }
        case 5:
            cell.appState = .loading
            self.dictionaryOperations.findLastElenemtInDictionary { time, element in cell.appState = .complete(result: time, positionOfElement: element)
                cell.isUserInteractionEnabled = false
            }
        case 6:
            cell.appState = .loading
            self.dictionaryOperations.findNotExistingElenemtInArray { time, flag in
                cell.appState = .complete(result: time, positionOfElement: flag)
                cell.isUserInteractionEnabled = false
            }
        case 7:
            cell.appState = .loading
            self.dictionaryOperations.findNotExistingElenemtInDictionary { time, flag in
                cell.appState = .complete(result: time, positionOfElement: flag)
                cell.isUserInteractionEnabled = false
            }
        default:
            break
        }
    }
}
//MARK: sizeForItemAt
extension DictionaryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row <= 1 {
            return CGSize(width: collectionView.bounds.width/2, height: 100)
        } else {
            return CGSize(width: (collectionView.bounds.width / 2), height: 100)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.5
    }
    
}
// MARK: extensions constants
extension DictionaryViewController {
    enum Constants {
        enum Borders {
            static let layerBorderColorFirst = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1).cgColor
            static let layerBorderColorSecond = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1)
        }
    }
}
