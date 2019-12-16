//
//  MainMenuViewController.swift
//  HockeyInfo-Swift
//
//  Created by Larry Burris on 12/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import UIKit

class MainMenuViewController: UIViewController
{
    let databaseManager = DatabaseManager()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if(databaseManager.mainMenuCategoriesRequiresSaving())
        {
            databaseManager.saveMainMenuCategories()
        }
    }
}
