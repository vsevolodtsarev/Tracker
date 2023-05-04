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
    weak var delegate: DidTapCellProtocol?
    
    private lazy var colorLabel: UILabel = {
        let colorLabel = UILabel()
        colorLabel.layer.cornerRadius = 8
        colorLabel.layer.masksToBounds = true
        colorLabel.translatesAutoresizingMaskIntoConstraints = false
       return colorLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(colorLabel)
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        NSLayoutConstraint.activate([
            colorLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            colorLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            colorLabel.heightAnchor.constraint(equalToConstant: 40),
            colorLabel.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configColorCell(color: UIColor) {
        colorLabel.backgroundColor = color
    }
    
    func getColor() -> UIColor? {
        colorLabel.backgroundColor
    }
}

extension SetNewTrackerColorCell: DidTapCellProtocol {
    func didSelect(cell: UICollectionViewCell) {
        contentView.layer.borderWidth = 3
        contentView.layer.borderColor = UIColor.color2.withAlphaComponent(0.3).cgColor
        contentView.layer.cornerRadius = 8
    }
    
    func didDeselect(cell: UICollectionViewCell) {
        contentView.layer.borderWidth = 0
        
    }
}
