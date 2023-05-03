//
//  SetNewTrackerEmojiCell.swift
//  Tracker
//
//  Created by Всеволод Царев on 30.04.2023.
//

import Foundation
import UIKit

final class SetNewTrackerEmojiCell: UICollectionViewCell {
    static let identifier = "emoji"
    
    private lazy var emojiLabel: UILabel = {
        let emojiLabel = UILabel()
        emojiLabel.text = "😀"
        emojiLabel.font = UIFont(name: "YandexSansDisplay-Bold", size: 32)
        emojiLabel.layer.cornerRadius = 16
        translatesAutoresizingMaskIntoConstraints = false
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
}
