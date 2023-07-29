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
    private let setOperators = SetOperations()
    private let firstTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 6
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.customBorderColor.cgColor
        textField.textColor = .black
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 1))
        textField.leftView = leftPaddingView
        textField.leftViewMode = .always
        textField.accessibilityIdentifier = "firstTextField"
        return textField
    }()
    private let secondTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 6
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.customBorderColor.cgColor
        textField.textColor = .black
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 1))
        textField.leftView = leftPaddingView
        textField.leftViewMode = .always
        textField.accessibilityIdentifier = "secondTextField"
        return textField
    }()
    private let showMatchingCharactersButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("All matching letters", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.accessibilityIdentifier = "showMatchingCharactersButton"
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
    private let showNonMatchingCharactersButton: UIButton = {
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
    private let showUniqueCharactersButton: UIButton = {
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
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupConstraints() {
        // textFields
        view.addSubview(firstTextField)
        firstTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constraints.textFieldFull)
            make.horizontalEdges.equalToSuperview().inset(Constraints.horizontalEdges)
            make.height.equalTo(Constraints.heightTextField)
        }
        view.addSubview(secondTextField)
        secondTextField.snp.makeConstraints { make in
            make.top.equalTo(firstTextField.snp.bottom).offset(Constraints.textFieldCharacters)
            make.horizontalEdges.equalToSuperview().inset(Constraints.horizontalEdges)
            make.height.equalTo(Constraints.heightTextField)
        }
        // ShowMatchingCharacters
        view.addSubview(showMatchingCharactersButton)
        showMatchingCharactersButton.snp.makeConstraints { make in
            make.top.equalTo(secondTextField.snp.bottom).offset(Constraints.textFieldCharacters)
            make.horizontalEdges.equalToSuperview().inset(Constraints.horizontalEdges)
            make.height.equalTo(Constraints.heightButton)
        }
        view.addSubview(matchingResultLabel)
        matchingResultLabel.snp.makeConstraints { make in
            make.top.equalTo(showMatchingCharactersButton.snp.bottom).offset(Constraints.topOffset)
            make.horizontalEdges.equalToSuperview().inset(Constraints.horizontalEdges)
            make.height.equalTo(Constraints.heightResultLabel)
        }
        // NonMatchingCharacters
        view.addSubview(showNonMatchingCharactersButton)
        showNonMatchingCharactersButton.snp.makeConstraints { make in
            make.top.equalTo(matchingResultLabel.snp.bottom).offset(Constraints.topOffset)
            make.horizontalEdges.equalToSuperview().inset(Constraints.horizontalEdges)
            make.height.equalTo(Constraints.heightButton)
        }
        view.addSubview(nonMatchResultLabel)
        nonMatchResultLabel.snp.makeConstraints { make in
            make.top.equalTo(showNonMatchingCharactersButton.snp.bottom).offset(Constraints.topOffset)
            make.horizontalEdges.equalToSuperview().inset(Constraints.horizontalEdges)
            make.height.equalTo(Constraints.heightResultLabel)
        }
        // uniqueResultLabel
        view.addSubview(showUniqueCharactersButton)
        showUniqueCharactersButton.snp.makeConstraints { make in
            make.top.equalTo(nonMatchResultLabel.snp.bottom).offset(Constraints.topOffset)
            make.horizontalEdges.equalToSuperview().inset(Constraints.horizontalEdges)
            make.height.equalTo(Constraints.heightButton)
        }
        view.addSubview(uniqueResultLabel)
        uniqueResultLabel.snp.makeConstraints { make in
            make.top.equalTo(showUniqueCharactersButton.snp.bottom).offset(Constraints.topOffset)
            make.horizontalEdges.equalToSuperview().inset(Constraints.horizontalEdges)
            make.height.equalTo(Constraints.heightResultLabel)
        }
    }
    
    private func setupTarget() {
        showMatchingCharactersButton.addTarget(self, action: #selector(showMatchingCharacters), for: .touchUpInside)
        showNonMatchingCharactersButton.addTarget(self, action: #selector(showNonMatchingCharacters), for: .touchUpInside)
        showUniqueCharactersButton.addTarget(self, action: #selector(showUniqueCharacters), for: .touchUpInside)
    }
    //MARK: Navigation bar
    private func setupNavigationBar() {
        self.navigationItem.title = "Set"
    }
    //MARK: - Button Actions
    @objc private func showMatchingCharacters() {
        guard let textFull = firstTextField.text, let textCharacters = secondTextField.text else {
            return
        }
        let matchingCharactersString = setOperators.findMatchingCharacters(textFull: textFull, textCharacters: textCharacters)
        matchingResultLabel.text = matchingCharactersString
    }
    
    @objc private func showNonMatchingCharacters() {
        guard let textFull = firstTextField.text, let textCharacters = secondTextField.text else {
            return
        }
        let nonMatchingCharactersString = setOperators.findNonMatchingCharacters(textFull: textFull, textCharacters: textCharacters)
        nonMatchResultLabel.text = nonMatchingCharactersString
    }
    
    @objc private func showUniqueCharacters() {
        guard let textFull = firstTextField.text, let textCharacters = secondTextField.text else {
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
        static let textFieldFull = 100
        static let textFieldCharacters = 20
    }
}
