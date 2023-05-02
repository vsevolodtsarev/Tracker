//
//  TrackersViewController.swift
//  Tracker
//
//  Created by Всеволод Царев on 03.04.2023.
//

import Foundation
import UIKit

final class TrackersViewController: UIViewController {
    
    private var currentDate = Date()
    private var categories: [TrackerCategory] = []
    private var visibleCategories: [TrackerCategory] = []
    private var completedTrackers: Set<TrackerRecord> = []
    
    
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
        datePicker.calendar = Calendar(identifier: .iso8601)
        datePicker.addTarget(self, action: #selector(datePickerDidChange), for: .valueChanged)
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
        setUI()
        addToVisibleCategory()
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
            
            datePicker.widthAnchor.constraint(equalToConstant: 100),
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
    
    private func checkCategoryIsEmpty() {
        if !visibleCategories.isEmpty {
            imagePlaceholder.isHidden = true
            textPlaceholder.isHidden = true
        } else {
            imagePlaceholder.isHidden = false
            textPlaceholder.isHidden = false
        }
    }
    
    private func addToVisibleCategory() {
        let currentWeekday = datePicker.calendar.component(.weekday, from: currentDate)
        visibleCategories = categories.filter { trackerCategory in
            trackerCategory.trackers.contains { tracker in
                guard let schedule = tracker.schedule else { return false }
                return schedule.contains { weekday in
                    weekday.orderDay == currentWeekday
                }
            }
        }.map { trackerCategory in
            let filteredTrackers = trackerCategory.trackers.filter { tracker in
                guard let schedule = tracker.schedule else { return false }
                return schedule.contains { weekday in
                    weekday.orderDay == currentWeekday
                }
            }
            return TrackerCategory(name: trackerCategory.name, trackers: filteredTrackers)
        }
        checkCategoryIsEmpty()
        collectionView.reloadData()
    }

    @objc private func didTapNewTrackerButton() {
        let newTrackerViewController = NewTrackersViewController()
        newTrackerViewController.delegate = self
        present(newTrackerViewController, animated: true)
    }
    
    @objc private func datePickerDidChange(_ sender: UIDatePicker) {
        currentDate = datePicker.date
        addToVisibleCategory()
        dismiss(animated: true) {
        }
    }
}


//MARK: - Extensions

extension TrackersViewController: NewTrackersViewControllerDelegate {
    func didAcceptButton(tracker: Tracker, category: String) {
        dismiss(animated: true)
        
                if categories.contains(where: { $0.name == category }) {
                    guard let index = categories.firstIndex(where: { $0.name == category }) else { return }
                    let updatedTrackers = categories[index].trackers + [tracker]
                    let updatedTrackerCategory = TrackerCategory(name: category, trackers: updatedTrackers)
                    categories[index] = updatedTrackerCategory
                } else {
                    let newTrackerCategory = TrackerCategory(name: category, trackers: [tracker])
                    categories.append(newTrackerCategory)
                }

        addToVisibleCategory()
    }
}

extension TrackersViewController: TrackerCollectionViewCellDelegate {
    func didTapPlusButton(cell: TrackersCollectionViewCell) {
        guard let indexPath: IndexPath = collectionView.indexPath(for: cell) else { return }
        let id = visibleCategories[indexPath.section].trackers[indexPath.row].id
        var daysCount = completedTrackers.filter { $0.id == id }.count
        if !completedTrackers.contains(where: { $0.id == id && $0.date == currentDate }) {
            completedTrackers.insert(TrackerRecord(id: id, date: currentDate))
            daysCount += 1
            cell.configRecord(days: daysCount, isDone: true)
        } else {
            completedTrackers.remove(TrackerRecord(id: id, date: currentDate))
            daysCount -= 1
            cell.configRecord(days: daysCount, isDone: false)
        }
    }
}

extension TrackersViewController: UISearchBarDelegate, UITextFieldDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchBar.text = ""
        searchBar.setShowsCancelButton(false, animated: true)
        addToVisibleCategory()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        addToVisibleCategory()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty || searchText == "" {
            addToVisibleCategory()
        } else {
            visibleCategories = visibleCategories.filter({ trackersCategory in
                let filteredTrackers = trackersCategory.trackers.filter { $0.name.range(of: searchText, options: .caseInsensitive) != nil }
                return !filteredTrackers.isEmpty
            }).map { category in
                TrackerCategory(name: category.name, trackers: category.trackers.filter { $0.name.range(of: searchText, options: .caseInsensitive) != nil })
            }
            
        }
        collectionView.reloadData()
    }
}

extension TrackersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return visibleCategories[section].trackers.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return visibleCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrackersCollectionViewCell.identifier, for: indexPath) as? TrackersCollectionViewCell else { return UICollectionViewCell() }
        let tracker = visibleCategories[indexPath.section].trackers[indexPath.row]
        let daysCount = completedTrackers.filter { $0.id == tracker.id }.count
        let isDone = completedTrackers.contains { $0.id == tracker.id && $0.date == currentDate }
        cell.configCell(tracker: tracker)
        cell.configRecord(days: daysCount, isDone: isDone)
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as? TrackersCellCategoryLabel else { return UICollectionReusableView() }
        view.configHeader(category: visibleCategories[indexPath.section].name)
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
