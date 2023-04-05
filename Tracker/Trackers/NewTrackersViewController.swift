//
//  NewTrackersViewController.swift
//  Tracker
//
//  Created by Всеволод Царев on 04.04.2023.
//

import Foundation
import UIKit

final class NewTrackersViewController: UIViewController {
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Cоздание трекера"
        titleLabel.font = UIFont(name: "YandexSansText-Medium", size: 16)
        return titleLabel
    }()
    
    private lazy var habitButton: UIButton = {
        let habitButton = UIButton()
        habitButton.setTitle("Привычка", for: .normal)
        habitButton.setTitleColor(.white, for: .normal)
        habitButton.backgroundColor = .black
        habitButton.layer.cornerRadius = 16
        habitButton.addTarget(nil, action: #selector(didTapHabitButton), for: .touchUpInside)
        return habitButton
    }()
    
    private lazy var nonRegularEventButton: UIButton = {
        let nonRegularEventButton = UIButton()
        nonRegularEventButton.setTitle("Нерегулярные события", for: .normal)
        nonRegularEventButton.setTitleColor(.white, for: .normal)
        nonRegularEventButton.backgroundColor = .black
        nonRegularEventButton.layer.cornerRadius = 16
        nonRegularEventButton.addTarget(nil, action: #selector(didTapNonRegularEventButton), for: .touchUpInside)
        return nonRegularEventButton
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
        present(setNewTrackerViewController, animated: true)
    }
    
    @objc private func didTapNonRegularEventButton() {
        let setNewTrackerViewController = SetNewTrackerViewController()
        setNewTrackerViewController.typeOfTracker = .nonRegularEvent
        present(setNewTrackerViewController, animated: true)
    }
}
