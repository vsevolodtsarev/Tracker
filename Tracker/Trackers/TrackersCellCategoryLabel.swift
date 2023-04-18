//
//  TrackerCategoryLabel.swift
//  Tracker
//
//  Created by Всеволод Царев on 13.04.2023.
//

import Foundation
import UIKit

final class TrackersCellCategoryLabel: UICollectionReusableView {
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "YandexSansDisplay-Bold", size: 19)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 28),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configHeader(category: String) {
        label.text = category
    }
}
