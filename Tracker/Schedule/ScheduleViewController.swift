//
//  ScheduleViewController.swift
//  Tracker
//
//  Created by Всеволод Царев on 06.04.2023.
//

import Foundation
import UIKit

final class ScheduleViewController: UIViewController {
    
    let weekday = WeekDay.allCases
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Расписание"
        titleLabel.font = UIFont(name: "YandexSansText-Medium", size: 16)
        return titleLabel
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.layer.cornerRadius = 16
        tableView.isScrollEnabled = false
        tableView.backgroundColor = UIColor(named: "ypLightBackgroundGrey")
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return tableView
    }()
    
    private lazy var acceptButton: UIButton = {
        let acceptButton = UIButton()
        acceptButton.titleLabel?.font = UIFont(name: "YandexSansText-Medium", size: 16)
        acceptButton.setTitle("Готово", for: .normal)
        acceptButton.setTitleColor(.white, for: .normal)
        acceptButton.backgroundColor = UIColor(named: "ypGrey")
        acceptButton.layer.cornerRadius = 16
        acceptButton.addTarget(nil, action: #selector(didTapAcceptButton), for: .touchUpInside)
        acceptButton.isEnabled = false
        return acceptButton
    }()
    
    //MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUI()
    }
    
    //MARK: - private func
    
    private func setUI() {
        view.addSubview(titleLabel)
        view.addSubview(acceptButton)
        view.addSubview(tableView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        acceptButton.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            acceptButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            acceptButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            acceptButton.heightAnchor.constraint(equalToConstant: 60),
            acceptButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: acceptButton.topAnchor, constant: -39),
            tableView.heightAnchor.constraint(equalToConstant: 524)
        ])
    }
    
    @objc private func didTapAcceptButton() {
        dismiss(animated: true)
    }
}

//MARK: - extensions

extension ScheduleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weekday.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let switcher = UISwitch()
        switcher.onTintColor = UIColor(named: "ypBlue")
        switcher.addTarget(nil, action: #selector(didSwitchIsOn), for: .valueChanged)
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.accessoryView = switcher
        cell.textLabel?.font = UIFont(name: "YandexSansDisplay-Regular", size: 17)
        cell.textLabel?.text = weekday[indexPath.row].rawValue
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    @objc private func didSwitchIsOn(_ sender: UISwitch) {
        if sender.isOn {
            acceptButton.backgroundColor = .black
            acceptButton.isEnabled = true
        } else {
            acceptButton.backgroundColor = UIColor(named: "ypGrey")
            acceptButton.isEnabled = false
        }
    }
}

extension ScheduleViewController: UITableViewDelegate {
    
}

