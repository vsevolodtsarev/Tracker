//
//  NewHabitViewController.swift
//  Tracker
//
//  Created by Всеволод Царев on 04.04.2023.
//

import Foundation
import UIKit

protocol SetNewTrackerViewControllerDelegate: AnyObject {
    func didAcceptButton(tracker: Tracker, category: String)
}

final class SetNewTrackerViewController: UIViewController {
    
    private var category: String = "Тестовая категория" //Mock category
    private var schedule: [String] = []
    private var emoji: [String] = ["🦊", "❤️", "🤡", "🐹", "🤪"] //Mock emoji
    private var color: [UIColor] = [UIColor(named: "Color selection 11")!, UIColor(named: "Color selection 12")!, UIColor(named: "Color selection 1")!, UIColor(named: "Color selection 2")!] //Mock color
    var typeOfTracker: TypeOfTracker?
    weak var delegate: SetNewTrackerViewControllerDelegate?
    
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
        createTrackerButton.isEnabled = false
        createTrackerButton.addTarget(self, action: #selector(didTapCreateButton), for: .touchUpInside)
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
        cancelCreateTrackerButton.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
        return cancelCreateTrackerButton
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
        view.addSubview(trackerNameTextField)
        view.addSubview(cancelCreateTrackerButton)
        view.addSubview(createTrackerButton)
        view.addSubview(tableView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        trackerNameTextField.translatesAutoresizingMaskIntoConstraints = false
        cancelCreateTrackerButton.translatesAutoresizingMaskIntoConstraints = false
        createTrackerButton.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            trackerNameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 38),
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
        let uuid = UUID().uuidString
        guard let trackerName = trackerNameTextField.text else { return }
        guard let emoji = emoji.randomElement() else { return }
        guard let color = color.randomElement() else { return }
        let tracker = Tracker(id: uuid, name: trackerName, emoji: emoji, color: color, schedule: schedule)
        delegate?.didAcceptButton(tracker: tracker, category: category)
    }
}

//MARK: - Extensions

extension SetNewTrackerViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return self.textLimit(existingText: textField.text, newText: string, limit: 38)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return trackerNameTextField.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if !(textField.text?.isEmpty ?? false) {
            createTrackerButton.isEnabled = true
            createTrackerButton.backgroundColor = .black
        } else {
            createTrackerButton.isEnabled = false
            createTrackerButton.backgroundColor = UIColor(named: "ypGrey")
        }
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
            categoryViewController.delegate = self
            present(categoryViewController, animated: true)
        case 1:
            let scheduleViewController = ScheduleViewController()
            scheduleViewController.delegate = self
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
            cell.detailTextLabel?.text = category
        case 1: cell.textLabel?.text = "Расписание"
            if schedule.isEmpty {
                cell.detailTextLabel?.text = ""
            } else if schedule.count == 7 {
                cell.detailTextLabel?.text = "Каждый день"
            } else {
                let sortedSchedule = schedule.sorted { (s1, s2) -> Bool in
                    let weekdayOrder = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"]
                    guard let index1 = weekdayOrder.firstIndex(of: s1),
                          let index2 = weekdayOrder.firstIndex(of: s2) else {
                        return false
                    }
                    return index1 < index2
                }
                let orderedDays = sortedSchedule.joined(separator: ", ")
                cell.detailTextLabel?.text = orderedDays
            }
        default: break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}

extension SetNewTrackerViewController: ScheduleViewControllerDelegate {
    func routeSchedule(selectedSchedule: [String]) {
        schedule = selectedSchedule
        tableView.reloadData()
    }
}

extension SetNewTrackerViewController: CategoryViewControllerDelegate {
    func routeCategory(newCategory: String) {
        category = newCategory
        tableView.reloadData()
    }
}
