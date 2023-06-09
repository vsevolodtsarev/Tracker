//
//  TabBarController.swift
//  Tracker
//
//  Created by Всеволод Царев on 03.04.2023.
//

import Foundation
import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let trackersViewController = TrackersViewController()
        trackersViewController.tabBarItem = UITabBarItem(
            title: "Трекеры",
            image: UIImage(named: "tabBarTrackers"),
            selectedImage: nil)

        let statisticViewController = StatisticViewController()
        statisticViewController.tabBarItem = UITabBarItem(
            title: "Статистика",
            image: UIImage(named: "tabBarStats"),
            selectedImage: nil)
        
        let fontAttributes = [NSAttributedString.Key.font: UIFont(name: "YandexSansText-Medium", size: 10)]
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes as [NSAttributedString.Key : Any], for: .normal)
        
        self.viewControllers = [trackersViewController, statisticViewController]
    }
}
