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
    let identifier = "TrackersCollectionViewCellIdentifier"
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
