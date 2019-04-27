//
//  Task+CoreDataProperties.swift
//  ABBYY Test
//
//  Created by Victor on 27/04/2019.
//  Copyright © 2019 com.example.LoD. All rights reserved.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var comment: String?
    @NSManaged public var date: NSDate?
    @NSManaged public var id: UUID?
    @NSManaged public var taskName: String?
    @NSManaged public var status: String?

}
