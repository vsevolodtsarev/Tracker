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
        createTrackerButton.titleLabel?.font = UIFont(name: "YandexSansText-Medium", size: 16)
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
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = view.bounds
        return scrollView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.cornerRadius = 16
        tableView.isScrollEnabled = false
        tableView.backgroundColor = UIColor(named: "ypLightBackgroundGrey")
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return tableView
    }()
    
    //MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUI()
    }
    
    //MARK: - private func
    
    private func tableViewHeightSize() -> CGFloat {
        let tableViewHeight: CGFloat
        switch typeOfTracker {
        case .habit: tableViewHeight = 149
        case .nonRegularEvent: tableViewHeight = 74
        case .none: tableViewHeight = 0
        }
        return tableViewHeight
    }
    
    private func setUI() {
        view.addSubview(titleLabel)
        view.addSubview(scrollView)
        scrollView.addSubview(trackerNameTextField)
        scrollView.addSubview(cancelCreateTrackerButton)
        scrollView.addSubview(createTrackerButton)
        scrollView.addSubview(tableView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        trackerNameTextField.translatesAutoresizingMaskIntoConstraints = false
        cancelCreateTrackerButton.translatesAutoresizingMaskIntoConstraints = false
        createTrackerButton.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 38),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            trackerNameTextField.topAnchor.constraint(equalTo: scrollView.topAnchor),
            trackerNameTextField.heightAnchor.constraint(equalToConstant: 75),
            trackerNameTextField.widthAnchor.constraint(equalToConstant: 150),
            trackerNameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            trackerNameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            tableView.topAnchor.constraint(equalTo: trackerNameTextField.bottomAnchor, constant: 24),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableView.heightAnchor.constraint(equalToConstant: tableViewHeightSize()),
            
            cancelCreateTrackerButton.heightAnchor.constraint(equalToConstant: 60),
            cancelCreateTrackerButton.widthAnchor.constraint(equalToConstant: 166),
            cancelCreateTrackerButton.bottomAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            cancelCreateTrackerButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            createTrackerButton.heightAnchor.constraint(equalToConstant: 60),
            createTrackerButton.leadingAnchor.constraint(equalTo: cancelCreateTrackerButton.trailingAnchor, constant: 8),
            createTrackerButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            createTrackerButton.bottomAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
        ])
    }
    
    @objc private func didTapCancelButton() {
        dismiss(animated: true)
    }
    
    @objc private func didTapCreateButton() {
        UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true)
    }
}

//MARK: - extensions

extension SetNewTrackerViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return self.textLimit(existingText: textField.text, newText: string, limit: 10)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return trackerNameTextField.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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

extension SetNewTrackerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let categoryViewController = CategoryViewController()
            present(categoryViewController, animated: true)
        case 1:
            let scheduleViewController = ScheduleViewController()
            present(scheduleViewController, animated: true)
        default: break
        }
    }
}

extension SetNewTrackerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch typeOfTracker {
        case .habit: return 2
        case .nonRegularEvent: return 1
        case .none: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.font = UIFont(name: "YandexSansDisplay-Regular", size: 17)
        cell.detailTextLabel?.font = UIFont(name: "YandexSansDisplay-Regular", size: 17)
        cell.detailTextLabel?.textColor = UIColor(named: "ypGrey")
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        
        switch indexPath.row {
        case 0: cell.textLabel?.text = "Категория"
            cell.detailTextLabel?.text = "Selected category"
        case 1: cell.textLabel?.text = "Расписание"
        default: break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}
