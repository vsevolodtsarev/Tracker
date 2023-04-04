//
//  TrackersViewController.swift
//  Tracker
//
//  Created by Всеволод Царев on 03.04.2023.
//

import Foundation
import UIKit

final class TrackersViewController: UIViewController {
    
    var currentDate: Date?
    
    private var newTrackerButton: UIButton = {
        let newTrackerButtonImage = UIImage(named: "newTrackerButton")
        let newTrackerButton = UIButton.systemButton(
            with: newTrackerButtonImage!,
            target: nil,
            action: #selector(didTapNewTrackerButton))
        newTrackerButton.tintColor = .black
        return newTrackerButton
    }()
    
    private var trackersLabel: UILabel = {
        let trackersLabel = UILabel()
        trackersLabel.text = "Трекеры"
        trackersLabel.font = UIFont(name: "YandexSansDisplay-Bold", size: 34)
        return trackersLabel
    }()
    
    private var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        return datePicker
    }()
    
    private var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Поиск"
        searchBar.searchBarStyle = .minimal
        return searchBar
    }()
    
    private var imagePlaceholder: UIImageView = {
        let image = UIImage(named: "trackersPlaceholder")
        let imagePlaceholder = UIImageView(image: image)
        return imagePlaceholder
    }()
    
    private var textPlaceholder: UILabel = {
        let textPlaceholder = UILabel()
        textPlaceholder.text = "Что будем отслеживать?"
        textPlaceholder.font = UIFont(name: "YandexSansText-Medium", size: 12)
        return textPlaceholder
    }()
    
    //MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUI()
    }
    
    //MARK: private func
    
    private func setUI() {
        view.addSubview(newTrackerButton)
        view.addSubview(trackersLabel)
        view.addSubview(datePicker)
        view.addSubview(searchBar)
        view.addSubview(imagePlaceholder)
        view.addSubview(textPlaceholder)
        
        newTrackerButton.translatesAutoresizingMaskIntoConstraints = false
        trackersLabel.translatesAutoresizingMaskIntoConstraints = false
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        imagePlaceholder.translatesAutoresizingMaskIntoConstraints = false
        textPlaceholder.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            newTrackerButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            newTrackerButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 18),
            
            trackersLabel.topAnchor.constraint(equalTo: newTrackerButton.bottomAnchor, constant: 13),
            trackersLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            datePicker.widthAnchor.constraint(equalToConstant: 77),
            datePicker.topAnchor.constraint(equalTo: newTrackerButton.bottomAnchor, constant: 16),
            datePicker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            searchBar.topAnchor.constraint(equalTo: datePicker.bottomAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            imagePlaceholder.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imagePlaceholder.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 230),
            
            textPlaceholder.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textPlaceholder.topAnchor.constraint(equalTo: imagePlaceholder.bottomAnchor, constant: 8)
        ])
    }
    
    @objc private func didTapNewTrackerButton() {
        let newTrackerViewController = NewTrackersViewController()
        present(newTrackerViewController, animated: true)
    }
}
