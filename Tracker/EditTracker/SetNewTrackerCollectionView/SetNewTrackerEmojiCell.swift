//
//  SetNewTrackerEmojiCell.swift
//  Tracker
//
//  Created by Всеволод Царев on 30.04.2023.
//

import Foundation
import UIKit

protocol DidTapCellProtocol: AnyObject {
    func didSelect(cell: UICollectionViewCell)
    func didDeselect(cell: UICollectionViewCell)
}

final class SetNewTrackerEmojiCell: UICollectionViewCell {
    static let identifier = "emoji"
    weak var delegate: DidTapCellProtocol?
    
    private lazy var emojiLabel: UILabel = {
        let emojiLabel = UILabel()
        emojiLabel.font = UIFont(name: "YandexSansDisplay-Bold", size: 32)
        emojiLabel.translatesAutoresizingMaskIntoConstraints = false
       return emojiLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(emojiLabel)
        NSLayoutConstraint.activate([
            emojiLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            emojiLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configEmojiCell(emoji: String) {
        emojiLabel.text = emoji
    }
    
    func getEmoji() -> String? {
        return emojiLabel.text
    }
}

extension SetNewTrackerEmojiCell: DidTapCellProtocol {
    func didSelect(cell: UICollectionViewCell) {
        contentView.layer.cornerRadius = 16
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = .emojiBackground
    }
    
    func didDeselect(cell: UICollectionViewCell) {
        contentView.backgroundColor = .clear
    }
    
  
}
