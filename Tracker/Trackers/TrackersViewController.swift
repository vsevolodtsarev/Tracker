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
    private var categoryName: String?
    private let setNewTrackerViewController = SetNewTrackerViewController()
    private let trackersCollectionViewCell = TrackersCollectionViewCell()
    
    var mockTracker: Tracker {
        return Tracker(id: "testID", name: "Test Tracker", emoji: "🐻", color: .gray, schedule: ["Sunday"])
    }
    var  mockTracker2: Tracker {
        return Tracker(id: "testID2", name: "Test Tracker2", emoji: "🤪", color: .blue, schedule: ["Sunday"])
    }
    var  mockArray: [Tracker] {
        return [mockTracker, mockTracker2]
    }
    
    let mockCategory: [String] = ["Домашний уют", "Радостные мелочи", "Самочувствие"]
    
    
    
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
        searchBar.delegate = self
        return searchBar
    }()
    
    private lazy var imagePlaceholder: UIImageView = {
        let image = UIImage(named: "trackersPlaceholder")
        let imagePlaceholder = UIImageView(image: image)
        imagePlaceholder.isHidden = false
        return imagePlaceholder
    }()
    
    private lazy var textPlaceholder: UILabel = {
        let textPlaceholder = UILabel()
        textPlaceholder.text = "Что будем отслеживать?"
        textPlaceholder.font = UIFont(name: "YandexSansText-Medium", size: 12)
        textPlaceholder.isHidden = false
        return textPlaceholder
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(
            TrackersCollectionViewCell.self,
            forCellWithReuseIdentifier: TrackersCollectionViewCell.identifier)
        collectionView.register(
            TrackersCellCategoryLabel.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "header")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsMultipleSelection = false
        return collectionView
    }()
    
    //MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setNewTrackerViewController.delegate = self
        trackersCollectionViewCell.delegate = self
        setUI()
        
        if !mockCategory.isEmpty {
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
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
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
    
    private func createNewTracker(id: String, name: String, schedule: [String], category: String) {
        
        //        newTracker = Tracker(id: id, name: name, schedule: schedule)
        //        categoryName = category
        //        var tracker = [Tracker]()
        //        guard let newTracker else { return }
        //        tracker.append(newTracker)
        //        let newTrackerCategory = TrackerCategory(name: category, category: tracker)
        //        categories.append(newTrackerCategory)
        //        collectionView.reloadData()
    }
}

//MARK: - Extensions

extension TrackersViewController: SetNewTrackerViewControllerDelegate {
    func routeNewTracker(id: String, name: String, schedule: [String], category: String) {
        createNewTracker(id: id, name: name, schedule: schedule, category: category)
    }
}

extension TrackersViewController: TrackerCollectionViewCellDelegate {
    func didTapPlusButton() {
        
    }
}

extension TrackersViewController: UISearchBarDelegate {
    
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchBar.setShowsCancelButton(false, animated: true)
        collectionView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //TODO: search
        collectionView.reloadData()
    }
}

extension TrackersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        mockArray.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return mockCategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrackersCollectionViewCell.identifier, for: indexPath) as? TrackersCollectionViewCell else { return UICollectionViewCell() }
        cell.delegate = self
        cell.configCell(tracker: mockArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as? TrackersCellCategoryLabel else { return UICollectionReusableView() }
        view.configHeader(category: mockCategory[indexPath.section])
        return view
    }
}

extension TrackersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let indexPath = IndexPath(row: 0, section: section)
        let headerView = self.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: indexPath)
        return headerView.systemLayoutSizeFitting(
            CGSize(
                width: collectionView.frame.width,
                height: UIView.layoutFittingExpandedSize.height),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 2 - 16 - 4.5, height: 148)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 16, bottom: 16, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}
