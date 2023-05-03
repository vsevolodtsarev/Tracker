//
//  SetNewTrackerCollectionViewHeader.swift
//  Tracker
//
//  Created by Всеволод Царев on 30.04.2023.
//

import Foundation
import UIKit

final class SetNewTrackerCollectionViewHeader: UICollectionReusableView {
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "YandexSansDisplay-Bold", size: 19)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Emoji"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 28),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func configHeader(collectionName: String) {
//        label.text = collectionName
//    }
}
