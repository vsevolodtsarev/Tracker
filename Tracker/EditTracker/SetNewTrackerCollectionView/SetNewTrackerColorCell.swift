//
//  SetNewTrackerColorCell.swift
//  Tracker
//
//  Created by Всеволод Царев on 30.04.2023.
//

import Foundation
import UIKit

final class SetNewTrackerColorCell: UICollectionViewCell {
    static let identifier = "color"
    
    private lazy var colorLabel: UILabel = {
        let colorLabel = UILabel()
        colorLabel.text = ""
        colorLabel.font = UIFont(name: "YandexSansDisplay-Bold", size: 32)
        colorLabel.layer.cornerRadius = 16
        translatesAutoresizingMaskIntoConstraints = false
       return colorLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(colorLabel)
        NSLayoutConstraint.activate([
            colorLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            colorLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configColorCell(color: UIColor) {
        colorLabel.backgroundColor = color
    }
}
