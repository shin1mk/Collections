//
//  SetViewController.swift
//  Collections
//
//  Created by SHIN MIKHAIL on 07.07.2023.
//

import UIKit
import SnapKit

final class SetViewController: UIViewController {
    //MARK: Properties
    let setOperators = SetOperations()
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
        titleLabel.text = "Set: 8317"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    private let textFieldFull: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 6
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.customBorderColor.cgColor
        textField.textColor = .black
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 1))
        textField.leftView = leftPaddingView
        textField.leftViewMode = .always
        return textField
    }()
    private let textFieldCharacters: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 6
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.customBorderColor.cgColor
        textField.textColor = .black
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 1))
        textField.leftView = leftPaddingView
        textField.leftViewMode = .always
        return textField
    }()
    private let buttonShowMatchingCharacters: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("All matching letters", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    private let matchingResultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    private let buttonShowNonMatchingCharacters: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("All characters that do not match", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    private let nonMatchResultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    private let buttonShowUniqueCharacters: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("All unique characters from the first text field that do not match in text fields", for: .normal)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    private let uniqueResultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        setupConstraints()
        setupTarget()
    }
    
    private func setupConstraints() {
        // textFields
        view.addSubview(textFieldFull)
        textFieldFull.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constraints.textFieldFull)
            make.horizontalEdges.equalToSuperview().inset(Constraints.horizontalEdges)
            make.height.equalTo(Constraints.heightTextField)
        }
        view.addSubview(textFieldCharacters)
        textFieldCharacters.snp.makeConstraints { make in
            make.top.equalTo(textFieldFull.snp.bottom).offset(Constraints.textFieldCharacters)
            make.horizontalEdges.equalToSuperview().inset(Constraints.horizontalEdges)
            make.height.equalTo(Constraints.heightTextField)
        }
        // ShowMatchingCharacters
        view.addSubview(buttonShowMatchingCharacters)
        buttonShowMatchingCharacters.snp.makeConstraints { make in
            make.top.equalTo(textFieldCharacters.snp.bottom).offset(Constraints.textFieldCharacters)
            make.horizontalEdges.equalToSuperview().inset(Constraints.horizontalEdges)
            make.height.equalTo(Constraints.heightButton)
        }
        view.addSubview(matchingResultLabel)
        matchingResultLabel.snp.makeConstraints { make in
            make.top.equalTo(buttonShowMatchingCharacters.snp.bottom).offset(Constraints.topOffset)
            make.horizontalEdges.equalToSuperview().inset(Constraints.horizontalEdges)
            make.height.equalTo(Constraints.heightResultLabel)
        }
        // NonMatchingCharacters
        view.addSubview(buttonShowNonMatchingCharacters)
        buttonShowNonMatchingCharacters.snp.makeConstraints { make in
            make.top.equalTo(matchingResultLabel.snp.bottom).offset(Constraints.topOffset)
            make.horizontalEdges.equalToSuperview().inset(Constraints.horizontalEdges)
            make.height.equalTo(Constraints.heightButton)
        }
        view.addSubview(nonMatchResultLabel)
        nonMatchResultLabel.snp.makeConstraints { make in
            make.top.equalTo(buttonShowNonMatchingCharacters.snp.bottom).offset(Constraints.topOffset)
            make.horizontalEdges.equalToSuperview().inset(Constraints.horizontalEdges)
            make.height.equalTo(Constraints.heightResultLabel)
        }
        // uniqueResultLabel
        view.addSubview(buttonShowUniqueCharacters)
        buttonShowUniqueCharacters.snp.makeConstraints { make in
            make.top.equalTo(nonMatchResultLabel.snp.bottom).offset(Constraints.topOffset)
            make.horizontalEdges.equalToSuperview().inset(Constraints.horizontalEdges)
            make.height.equalTo(Constraints.heightButton)
        }
        view.addSubview(uniqueResultLabel)
        uniqueResultLabel.snp.makeConstraints { make in
            make.top.equalTo(buttonShowUniqueCharacters.snp.bottom).offset(Constraints.topOffset)
            make.horizontalEdges.equalToSuperview().inset(Constraints.horizontalEdges)
            make.height.equalTo(Constraints.heightResultLabel)
        }
    }
    
    private func setupTarget() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        buttonShowMatchingCharacters.addTarget(self, action: #selector(showMatchingCharacters), for: .touchUpInside)
        buttonShowNonMatchingCharacters.addTarget(self, action: #selector(showNonMatchingCharacters), for: .touchUpInside)
        buttonShowUniqueCharacters.addTarget(self, action: #selector(showUniqueCharacters), for: .touchUpInside)
    }
    //MARK: Navigation bar
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.titleView = titleLabel
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    //MARK: - Button Actions
    @objc private func showMatchingCharacters() {
        guard let textFull = textFieldFull.text, let textCharacters = textFieldCharacters.text else {
            return
        }
        let matchingCharactersString = setOperators.findMatchingCharacters(textFull: textFull, textCharacters: textCharacters)
        matchingResultLabel.text = matchingCharactersString
    }
    
    @objc private func showNonMatchingCharacters() {
        guard let textFull = textFieldFull.text, let textCharacters = textFieldCharacters.text else {
            return
        }
        let nonMatchingCharactersString = setOperators.findNonMatchingCharacters(textFull: textFull, textCharacters: textCharacters)
        nonMatchResultLabel.text = nonMatchingCharactersString
    }
    
    @objc private func showUniqueCharacters() {
        guard let textFull = textFieldFull.text, let textCharacters = textFieldCharacters.text else {
            return
        }
        let uniqueCharactersString = setOperators.findUniqueCharacters(textFull: textFull, textCharacters: textCharacters)
        uniqueResultLabel.text = uniqueCharactersString
    }
}
//MARK: Extension
extension SetViewController {
    enum Constraints {
        static let heightResultLabel = 20
        static let heightButton = 40
        static let heightTextField = 40
        static let horizontalEdges = 15
        static let topOffset = 10
        static let textFieldFull = 130
        static let textFieldCharacters = 20
    }
}
