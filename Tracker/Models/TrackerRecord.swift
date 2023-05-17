//
//  TrackerRecordModel.swift
//  Tracker
//
//  Created by Всеволод Царев on 11.05.2023.
//

import Foundation

struct TrackerRecord: Hashable {
    let trackerId: UUID
    let id: UUID
    let date: Date
}
