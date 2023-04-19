//
//  Tracker.swift
//  Tracker
//
//  Created by Всеволод Царев on 05.04.2023.
//

import Foundation
import UIKit

enum TypeOfTracker {
    case habit
    case nonRegularEvent
}

enum WeekDay: String, CaseIterable {
    case monday = "Понедельник"
    case tuesday = "Вторник"
    case wednesday = "Среда"
    case thurshday = "Четверг"
    case friday = "Пятница"
    case saturday = "Суббота"
    case sunday = "Воскресенье"
}

struct Tracker {
    let id: String
    let name: String
    let emoji: String
    let color: UIColor
    let schedule: [String]?
}

struct TrackerCategory {
    let name: String
    let trackers: [Tracker]
}

struct TrackerRecord: Hashable {
    let id: UUID
    let date: Date
}

