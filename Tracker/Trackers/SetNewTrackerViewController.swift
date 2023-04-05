//
//  NewHabitViewController.swift
//  Tracker
//
//  Created by Всеволод Царев on 04.04.2023.
//

import Foundation
import UIKit

final class SetNewTrackerViewController: UIViewController {
    
    var typeOfTracker: TypeOfTracker?
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont(name: "YandexSansText-Medium", size: 16)
        switch typeOfTracker {
        case .habit: titleLabel.text = "Новая привычка"
        case .nonRegularEvent: titleLabel.text = "Новое нерегулярное событие"
        case .none: break
        }
        return titleLabel
    }()
    
    private lazy var trackerNameTextField: UITextField = {
        let trackerNameTextField = UITextField()
        trackerNameTextField.placeholder = "Введите название трекера"
        trackerNameTextField.clearButtonMode = .whileEditing
        trackerNameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        trackerNameTextField.leftViewMode = .always
        trackerNameTextField.backgroundColor = UIColor(named: "ypLightBackgroundGrey")
        trackerNameTextField.layer.cornerRadius = 16
        trackerNameTextField.delegate = self
        return trackerNameTextField
    }()
    
    private lazy var textFieldCharLimitLabel: UILabel = {
        let textFieldCharLimitLabel = UILabel()
        return textFieldCharLimitLabel
    }()
    
    private lazy var createTrackerButton: UIButton = {
        let createTrackerButton = UIButton()
        createTrackerButton.titleLabel?.font = UIFont(name: "YandexSansDisplay-Regular", size: 16)
        createTrackerButton.setTitle("Cоздать", for: .normal)
        createTrackerButton.setTitleColor(.white, for: .normal)
        createTrackerButton.backgroundColor = UIColor(named: "ypGrey")
        createTrackerButton.layer.cornerRadius = 16
        createTrackerButton.addTarget(nil, action: #selector(didTapCreateButton), for: .touchUpInside)
        return createTrackerButton
    }()
    
    private lazy var cancelCreateTrackerButton: UIButton = {
        let cancelCreateTrackerButton = UIButton()
        cancelCreateTrackerButton.titleLabel?.font = UIFont(name: "YandexSansDisplay-Regular", size: 16)
        cancelCreateTrackerButton.setTitle("Отменить", for: .normal)
        cancelCreateTrackerButton.setTitleColor(.red, for: .normal)
        cancelCreateTrackerButton.layer.borderWidth = 1
        cancelCreateTrackerButton.layer.borderColor = UIColor(named: "ypRed")?.cgColor
        cancelCreateTrackerButton.layer.cornerRadius = 16
        cancelCreateTrackerButton.addTarget(nil, action: #selector(didTapCancelButton), for: .touchUpInside)
        return cancelCreateTrackerButton
    }()
    
    //MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUI()
    }
    
    //MARK: private func
    
    private func setUI() {
        view.addSubview(titleLabel)
        view.addSubview(trackerNameTextField)
        view.addSubview(cancelCreateTrackerButton)
        view.addSubview(createTrackerButton)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        trackerNameTextField.translatesAutoresizingMaskIntoConstraints = false
        cancelCreateTrackerButton.translatesAutoresizingMaskIntoConstraints = false
        createTrackerButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            trackerNameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 38),
            trackerNameTextField.heightAnchor.constraint(equalToConstant: 75),
            trackerNameTextField.widthAnchor.constraint(equalToConstant: 150),
            trackerNameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            trackerNameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            cancelCreateTrackerButton.heightAnchor.constraint(equalToConstant: 60),
            cancelCreateTrackerButton.widthAnchor.constraint(equalToConstant: 166),
            cancelCreateTrackerButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            cancelCreateTrackerButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            createTrackerButton.heightAnchor.constraint(equalToConstant: 60),
            createTrackerButton.leadingAnchor.constraint(equalTo: cancelCreateTrackerButton.trailingAnchor, constant: 8),
            createTrackerButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            createTrackerButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
        ])
    }
    
    @objc private func didTapCancelButton() {
        dismiss(animated: true)
    }
    
    @objc private func didTapCreateButton() {
        UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true)
    }
}

extension SetNewTrackerViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return self.textLimit(existingText: textField.text, newText: string, limit: 10)
    }
    
    private func textLimit(
        existingText: String?,
        newText: String,
        limit: Int) -> Bool {
            let text = existingText ?? ""
            let isAtLimit = text.count + newText.count <= limit
            return isAtLimit
        }
}
