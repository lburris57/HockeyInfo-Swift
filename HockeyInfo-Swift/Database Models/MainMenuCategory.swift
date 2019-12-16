//
//  MainMenuCategory.swift
//  Hockey Info
//
//  Created by Larry Burris on 12/11/18.
//  Copyright © 2018 Larry Burris. All rights reserved.
//
import Foundation
import RealmSwift

class MainMenuCategory: Object
{
    @objc dynamic var id : Int = 0
    @objc dynamic var category : String = ""
    @objc dynamic var dateCreated: String = ""
    
    override static func primaryKey() -> String?
    {
        return "id"
    }
}
