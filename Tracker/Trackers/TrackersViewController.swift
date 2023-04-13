//
//  TrackersViewController.swift
//  Tracker
//
//  Created by Всеволод Царев on 03.04.2023.
//

import Foundation
import UIKit

final class TrackersViewController: UIViewController {
    
    private var currentDate: Date?
    private var categories: [TrackerCategory] = []
    private var visibleCategories: [TrackerCategory] = []
    private var completedTrackers: Set<TrackerRecord> = []
    private var newTracker: Tracker?
    
    private lazy var newTrackerButton: UIButton = {
        let newTrackerButtonImage = UIImage(named: "newTrackerButton")
        let newTrackerButton = UIButton.systemButton(
            with: newTrackerButtonImage!,
            target: self,
            action: #selector(didTapNewTrackerButton))
        newTrackerButton.tintColor = .black
        return newTrackerButton
    }()
    
    private lazy var trackersLabel: UILabel = {
        let trackersLabel = UILabel()
        trackersLabel.text = "Трекеры"
        trackersLabel.font = UIFont(name: "YandexSansDisplay-Bold", size: 34)
        return trackersLabel
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        datePicker.locale = Locale(identifier: "ru_RU")
        return datePicker
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Поиск"
        searchBar.searchBarStyle = .minimal
        return searchBar
    }()
    
    private lazy var imagePlaceholder: UIImageView = {
        let image = UIImage(named: "trackersPlaceholder")
        let imagePlaceholder = UIImageView(image: image)
        return imagePlaceholder
    }()
    
    private lazy var textPlaceholder: UILabel = {
        let textPlaceholder = UILabel()
        textPlaceholder.text = "Что будем отслеживать?"
        textPlaceholder.font = UIFont(name: "YandexSansText-Medium", size: 12)
        return textPlaceholder
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewLayout())
        collectionView.register(
            TrackersCollectionViewCell.self,
            forCellWithReuseIdentifier: TrackersCollectionViewCell().identifier)
        collectionView.register(
            TrackersCellCategoryLabel.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "header")
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    //MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        setUI()
        
        if !categories.isEmpty {
            imagePlaceholder.isHidden = true
            textPlaceholder.isHidden = true
        }
    }
    
    //MARK: - private func
    
    private func setUI() {
        view.addSubview(newTrackerButton)
        view.addSubview(trackersLabel)
        view.addSubview(datePicker)
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        view.addSubview(imagePlaceholder)
        view.addSubview(textPlaceholder)
        
        newTrackerButton.translatesAutoresizingMaskIntoConstraints = false
        trackersLabel.translatesAutoresizingMaskIntoConstraints = false
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        imagePlaceholder.translatesAutoresizingMaskIntoConstraints = false
        textPlaceholder.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            newTrackerButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            newTrackerButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 18),
            
            trackersLabel.topAnchor.constraint(equalTo: newTrackerButton.bottomAnchor, constant: 13),
            trackersLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            datePicker.widthAnchor.constraint(equalToConstant: 95),
            datePicker.topAnchor.constraint(equalTo: newTrackerButton.bottomAnchor, constant: 16),
            datePicker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            searchBar.topAnchor.constraint(equalTo: datePicker.bottomAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 24),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
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

//MARK: - Extensions

extension TrackersViewController: SetNewTrackerViewControllerDelegate {
    func routeNewTracker(id: String, name: String, schedule: [String]) {
        newTracker = Tracker(id: id, name: name, schedule: schedule)
    }
}

extension TrackersViewController: UISearchBarDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension TrackersViewController: UICollectionViewDelegate {
    
}

extension TrackersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrackersCollectionViewCell().identifier, for: indexPath) as? TrackersCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
}

extension TrackersViewController: UICollectionViewDelegateFlowLayout {
    
}
