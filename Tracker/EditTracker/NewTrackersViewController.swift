//
//  NewTrackersViewController.swift
//  Tracker
//
//  Created by Всеволод Царев on 04.04.2023.
//

import Foundation
import UIKit

protocol NewTrackersViewControllerDelegate: AnyObject {
    func didAcceptButton(tracker: Tracker, category: String)
}

final class NewTrackersViewController: UIViewController {
    
    
    weak var delegate:  NewTrackersViewControllerDelegate?

    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Cоздание трекера"
        titleLabel.font = UIFont(name: "YandexSansText-Medium", size: 16)
        return titleLabel
    }()
    
    private lazy var habitButton: UIButton = {
        let habitButton = UIButton()
        habitButton.titleLabel?.font = UIFont(name: "YandexSansText-Medium", size: 16)
        habitButton.setTitle("Привычка", for: .normal)
        habitButton.setTitleColor(.white, for: .normal)
        habitButton.backgroundColor = .black
        habitButton.layer.cornerRadius = 16
        habitButton.addTarget(self, action: #selector(didTapHabitButton), for: .touchUpInside)
        return habitButton
    }()
    
    private lazy var nonRegularEventButton: UIButton = {
        let nonRegularEventButton = UIButton()
        nonRegularEventButton.titleLabel?.font = UIFont(name: "YandexSansText-Medium", size: 16)
        nonRegularEventButton.setTitle("Нерегулярные события", for: .normal)
        nonRegularEventButton.setTitleColor(.white, for: .normal)
        nonRegularEventButton.backgroundColor = .black
        nonRegularEventButton.layer.cornerRadius = 16
        nonRegularEventButton.addTarget(self, action: #selector(didTapNonRegularEventButton), for: .touchUpInside)
        return nonRegularEventButton
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
        view.addSubview(habitButton)
        view.addSubview(nonRegularEventButton)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        habitButton.translatesAutoresizingMaskIntoConstraints = false
        nonRegularEventButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            habitButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 295),
            habitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            habitButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            habitButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            habitButton.heightAnchor.constraint(equalToConstant: 60),
            
            nonRegularEventButton.topAnchor.constraint(equalTo: habitButton.bottomAnchor, constant: 16),
            nonRegularEventButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nonRegularEventButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            nonRegularEventButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            nonRegularEventButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc private func didTapHabitButton() {
        let setNewTrackerViewController = SetNewTrackerViewController()
        setNewTrackerViewController.typeOfTracker = .habit
        setNewTrackerViewController.delegate = self
        present(setNewTrackerViewController, animated: true)
    }
    
    @objc private func didTapNonRegularEventButton() {
        let setNewTrackerViewController = SetNewTrackerViewController()
        setNewTrackerViewController.typeOfTracker = .nonRegularEvent
        setNewTrackerViewController.delegate = self
        present(setNewTrackerViewController, animated: true)
    }
}

extension NewTrackersViewController: SetNewTrackerViewControllerDelegate {
    func didAcceptButton(tracker: Tracker, category: String) {
        dismiss(animated: true)
        let tracker = tracker
        let category = category
        delegate?.didAcceptButton(tracker: tracker, category: category)
    }
}
