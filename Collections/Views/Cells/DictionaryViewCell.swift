//
//  DictionaryViewCell.swift
//  Collections
//
//  Created by SHIN MIKHAIL on 25.07.2023.
//

import UIKit
import SnapKit

class DictionaryViewCell: UICollectionViewCell {
    //MARK: UI elements
    var appState: AppState = .start {
        didSet {
            updateUI(appState)
        }
    }
    var textToShow: String = "" {
        didSet {
            label.text = textToShow
        }
    }
    private let label: UILabel = {
        let labelCell = UILabel()
        labelCell.font = .systemFont(ofSize: 16)
        labelCell.textColor = .systemBlue
        labelCell.textAlignment = .center
        labelCell.numberOfLines = 0
        return labelCell
    }()
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        return activityIndicator
    }()
    //MARK: lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        return nil
    }
    //MARK: methods
    private func setupConstraints() {
        contentView.addSubview(label)
        label.snp.makeConstraints{ make in
            make.leading.top.trailing.bottom.equalToSuperview().inset(2)
        }
        contentView.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints{ make in
            make.center.equalToSuperview()
        }
    }

    private func updateUI(_ appState: AppState) {
        switch appState {
        case .start:
            return
        case .loading:
            activityIndicator.startAnimating()
            label.isHidden = true
        case .complete(let result, let elementFound as Int?):
            activityIndicator.stopAnimating()
            label.isHidden = false
            
            if let foundElement = elementFound {
                label.text = "Search time: \(result) sec\nNon-existing element: \(foundElement)"
            } else {
                label.text = "Search time: \(result) sec\nNon-existing element: found"
            }
        }
    }
}
//MARK: extensions
extension DictionaryViewCell {
    enum AppState {
        case start
        case loading
        case complete(result: Double, positionOfElement: Int)
    }
}
