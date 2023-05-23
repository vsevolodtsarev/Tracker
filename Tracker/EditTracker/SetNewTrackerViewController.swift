//
//  NewHabitViewController.swift
//  Tracker
//
//  Created by Всеволод Царев on 04.04.2023.
//

import Foundation
import UIKit

protocol SetNewTrackerViewControllerDelegate: AnyObject {
    func didAcceptButton(tracker: Tracker, category: TrackerCategory)
}

final class SetNewTrackerViewController: UIViewController {
    
    private var category: String = ["Домашний уют", "Спорт", "Уборка"].randomElement()! //Mock category
    private var schedule: [WeekDay] = []
    private let emoji: [String] = ["🙂", "😻", "🌺", "🐶", "❤️", "😱", "😇", "😡", "🥶", "🤔", "🙌", "🍔", "🥦", "🏓", "🥇", "🎸", "🏝", "😪" ]
    private let colors: [UIColor] = [UIColor.color1, UIColor.color2, UIColor.color3, UIColor.color4, UIColor.color5, UIColor.color6, UIColor.color7, UIColor.color8, UIColor.color9, UIColor.color10, UIColor.color11, UIColor.color12, UIColor.color13, UIColor.color14, UIColor.color15, UIColor.color16, UIColor.color17, UIColor.color18]
    weak var delegate: SetNewTrackerViewControllerDelegate?
    var typeOfTracker: TypeOfTracker?
    private var selectedEmoji: String?
    private var selectedColor: UIColor?
    
    private lazy var scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        return scrollView
    }()
    
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
    
    private lazy var emojiCollectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(SetNewTrackerEmojiCell.self, forCellWithReuseIdentifier: SetNewTrackerEmojiCell.identifier)
        collectionView.register(
            SetNewTrackerCollectionViewHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "header")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    private lazy var colorCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(SetNewTrackerColorCell.self, forCellWithReuseIdentifier: SetNewTrackerColorCell.identifier)
        collectionView.register(
            SetNewTrackerCollectionViewHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "header")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    //MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUI()
    }
    
    //MARK: - private func

    private func checkForReadyAcceptButton() {
        if (selectedColor != nil) && (selectedEmoji != nil) && (!schedule.isEmpty) && (!(trackerNameTextField.text?.isEmpty ?? false)) {
            createTrackerButton.isEnabled = true
            createTrackerButton.backgroundColor = .black
        } else {
            createTrackerButton.isEnabled = false
            createTrackerButton.backgroundColor = UIColor(named: "ypGrey")
        }
    }

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
        scrollView.addSubview(emojiCollectionView)
        scrollView.addSubview(colorCollectionView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        trackerNameTextField.translatesAutoresizingMaskIntoConstraints = false
        cancelCreateTrackerButton.translatesAutoresizingMaskIntoConstraints = false
        createTrackerButton.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        emojiCollectionView.translatesAutoresizingMaskIntoConstraints = false
        colorCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 38),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            trackerNameTextField.topAnchor.constraint(equalTo: scrollView.topAnchor),
            trackerNameTextField.heightAnchor.constraint(equalToConstant: 75),
            trackerNameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32),
            trackerNameTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            trackerNameTextField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            
            tableView.topAnchor.constraint(equalTo: trackerNameTextField.bottomAnchor, constant: 24),
            tableView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            tableView.heightAnchor.constraint(equalToConstant: tableViewHeightSize()),
            
            cancelCreateTrackerButton.heightAnchor.constraint(equalToConstant: 60),
            cancelCreateTrackerButton.widthAnchor.constraint(equalToConstant: 166),
            cancelCreateTrackerButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            cancelCreateTrackerButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            
            createTrackerButton.heightAnchor.constraint(equalToConstant: 60),
            createTrackerButton.leadingAnchor.constraint(equalTo: cancelCreateTrackerButton.trailingAnchor, constant: 8),
            createTrackerButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            createTrackerButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            
            emojiCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emojiCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emojiCollectionView.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 32),
            emojiCollectionView.heightAnchor.constraint(equalToConstant: 205),
            emojiCollectionView.bottomAnchor.constraint(equalTo: colorCollectionView.topAnchor, constant: -46),
            
            colorCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            colorCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            colorCollectionView.topAnchor.constraint(equalTo: emojiCollectionView.bottomAnchor, constant: 46),
            colorCollectionView.heightAnchor.constraint(equalToConstant: 205),
            colorCollectionView.bottomAnchor.constraint(equalTo: cancelCreateTrackerButton.topAnchor, constant: -46)
        ])
    }
    
    @objc private func didTapCancelButton() {
        dismiss(animated: true)
    }
    
    @objc private func didTapCreateButton() {
        let uuid = UUID()
        guard
            let trackerName = trackerNameTextField.text,
            let selectedColor,
            let selectedEmoji
        else { return }
        
        let trackerCategory = TrackerCategory(
            id: uuid,
            name: category)
        
        let tracker = Tracker(
            id: uuid,
            name: trackerName,
            emoji: selectedEmoji,
            color: selectedColor, schedule:
                schedule,
            recordCount: 0)
        
        delegate?.didAcceptButton(tracker: tracker, category: trackerCategory)
    }
}

//MARK: - Extensions

extension SetNewTrackerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == emojiCollectionView {
            return emoji.count
        } else {
            return colors.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == emojiCollectionView {
            guard let emojiCell = collectionView.dequeueReusableCell(withReuseIdentifier: SetNewTrackerEmojiCell.identifier, for: indexPath) as? SetNewTrackerEmojiCell else { return UICollectionViewCell() }
            let emoji = emoji[indexPath.row]
            emojiCell.configEmojiCell(emoji: emoji)
            return emojiCell
        } else {
            guard let colorCell = collectionView.dequeueReusableCell(withReuseIdentifier: SetNewTrackerColorCell.identifier, for: indexPath) as? SetNewTrackerColorCell else { return UICollectionViewCell() }
            let color = colors[indexPath.row]
            colorCell.configColorCell(color: color)
                return colorCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as? SetNewTrackerCollectionViewHeader else { return UICollectionReusableView() }
        if collectionView == emojiCollectionView {
            view.configHeader(headerLabel: "Emoji")
        } else {
            view.configHeader(headerLabel: "Цвет")
        }
        return view
    }
}

extension SetNewTrackerViewController: UICollectionViewDelegateFlowLayout {
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
                CGSize(width: 52, height: 52)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 25, left: 20, bottom: 25, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}

extension SetNewTrackerViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == emojiCollectionView {
            guard let cell = collectionView.cellForItem(at: indexPath) as? SetNewTrackerEmojiCell else { return }
            cell.didSelect(cell: cell)
            let emoji = cell.getEmoji()
            selectedEmoji = emoji
            checkForReadyAcceptButton()
        } else {
            guard let cell = collectionView.cellForItem(at: indexPath) as? SetNewTrackerColorCell else { return }
            cell.didSelect(cell: cell)
            let color = cell.getColor()
            selectedColor = color
            checkForReadyAcceptButton()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? DidTapCellProtocol else { return }
        cell.didDeselect(cell: cell as? UICollectionViewCell ?? UICollectionViewCell())
    }
}

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
       checkForReadyAcceptButton()
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
                let sortedSchedule = schedule.sorted { $0.orderDay < $1.orderDay}
                let orderedDays = sortedSchedule.compactMap { $0.shortName }.joined(separator: ", ")
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
    func routeSchedule(selectedSchedule: [WeekDay]) {
        schedule = selectedSchedule
        checkForReadyAcceptButton()
        tableView.reloadData()
    }
}

extension SetNewTrackerViewController: CategoryViewControllerDelegate {
    func routeCategory(newCategory: String) {
        category = newCategory
        checkForReadyAcceptButton()
        tableView.reloadData()
    }
}
