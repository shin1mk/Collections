//
//  ArrayCollectionViewCell.swift
//  Collections
//
//  Created by SHIN MIKHAIL on 17.07.2023.

import UIKit
import SnapKit

final class ArrayCollectionViewCell: UICollectionViewCell {
    //MARK: UI elements
    var appState: AppState = .start {
        didSet {
            updateUI(appState)
        }
    }
    var textToShow: String = "" {
        didSet {
            labelCell.text = textToShow
        }
    }
    private let labelCell: UILabel = {
        let labelCell = UILabel()
        labelCell.font = UIFont.systemFont(ofSize: 16)
        labelCell.textColor = .systemBlue
        labelCell.textAlignment = .center
        labelCell.numberOfLines = 0
        return labelCell
    }()
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = .gray
        return activityIndicator
    }()
    //MARK: lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        return nil
    }
    //MARK: Methods
    private func setupConstraints() {
        backgroundColor = .backgroundColor
        addSubview(labelCell)
        labelCell.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    private func updateUI(_ appState: AppState) {
        switch appState {
        case .start:
            break
        case .loading:
            labelCell.isHidden = true
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
        case .complete(let result):
            labelCell.isHidden = false
            labelCell.text = "Execution time: \(result) sec"
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
        }
    }
}
//MARK: State
extension ArrayCollectionViewCell {
    enum AppState {
        case start
        case loading
        case complete(result: Double)
    }
}
