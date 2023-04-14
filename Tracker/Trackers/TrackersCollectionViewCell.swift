//
//  TrackersCollectionViewCell.swift
//  Tracker
//
//  Created by Всеволод Царев on 13.04.2023.
//

import Foundation
import UIKit

protocol TrackerCollectionViewCellDelegate: AnyObject {
    func didTapPlusButton()
}

final class TrackersCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: TrackerCollectionViewCellDelegate?
    
    private lazy var cellView: UIView = {
       let view = UIView()
        view.layer.cornerRadius = 16
        view.backgroundColor = UIColor(named: "Color selection 1")
        return view
    }()
    
    private lazy var emojiLabel: UILabel = {
       let emojiLabel = UILabel()
        emojiLabel.backgroundColor = UIColor(named: "emojiBackground")
        emojiLabel.layer.cornerRadius = 30
        emojiLabel.text = "❤️"
        emojiLabel.textAlignment = .center
        return emojiLabel
    }()
    
    private lazy var  trackerNameLabel: UILabel = {
       let trackerNameLabel = UILabel()
        trackerNameLabel.text = "Поливать растения"
        trackerNameLabel.textColor = .white
        trackerNameLabel.font = UIFont(name: "YandexSansText-Medium", size: 12)
        return trackerNameLabel
    }()
    
    private lazy var  countLabel: UILabel = {
       let countLabel = UILabel()
        countLabel.text = "1 день"
        countLabel.font = UIFont(name: "YandexSansText-Medium", size: 12)
        return countLabel
    }()
    
    private lazy var plusButton: UIButton = {
       let plusButton = UIButton()
        plusButton.setTitle("􀅼", for: .normal)
        plusButton.setTitleColor(.white, for: .normal)
        plusButton.backgroundColor = cellView.backgroundColor
        plusButton.addTarget(self, action: #selector(didTapPlusButton), for: .touchUpInside)
        return plusButton
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapPlusButton() {
        
    }
    
    private func setUI() {
        contentView.addSubview(cellView)
        contentView.addSubview(countLabel)
        contentView.addSubview(plusButton)
        cellView.addSubview(emojiLabel)
        cellView.addSubview(trackerNameLabel)
        
        cellView.translatesAutoresizingMaskIntoConstraints = false
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        emojiLabel.translatesAutoresizingMaskIntoConstraints = false
        trackerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cellView.heightAnchor.constraint(equalToConstant: 90),
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            emojiLabel.heightAnchor.constraint(equalToConstant: 24),
            emojiLabel.widthAnchor.constraint(equalToConstant: 24),
            emojiLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 12),
            emojiLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 12),
            
            trackerNameLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -12),
            trackerNameLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 12),
            trackerNameLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -12),
            
            plusButton.topAnchor.constraint(equalTo: cellView.bottomAnchor, constant: 8),
            plusButton.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -12),
            plusButton.widthAnchor.constraint(equalToConstant: 34),
            plusButton.heightAnchor.constraint(equalToConstant: 34),
            
            countLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 12),
            countLabel.centerYAnchor.constraint(equalTo: plusButton.centerYAnchor)
        ])
    }
}
