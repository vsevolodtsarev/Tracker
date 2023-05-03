//
//  NewCategoryViewController.swift
//  Tracker
//
//  Created by Всеволод Царев on 06.04.2023.
//

import Foundation
import UIKit

protocol CategoryViewControllerDelegate: AnyObject {
    func routeCategory(newCategory: String)
}

final class CategoryViewController: UIViewController {
    
    weak var delegate: CategoryViewControllerDelegate?
    
    //MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
    }
}
