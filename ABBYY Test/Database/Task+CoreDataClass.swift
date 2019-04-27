//
//  Task+CoreDataClass.swift
//  ABBYY Test
//
//  Created by Victor on 27/04/2019.
//  Copyright © 2019 com.example.LoD. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Task)
public class Task: NSManagedObject {
    convenience init() {
        self.init(entity: CoreDataManager.instance.entityForName(entityName: "Task"), insertInto: CoreDataManager.instance.persistentContainer.viewContext)
    }
}
