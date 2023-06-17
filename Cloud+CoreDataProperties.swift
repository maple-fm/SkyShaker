//
//  Cloud+CoreDataProperties.swift
//  CloudNegative
//
//  Created by 出口楓真 on 2023/03/12.
//
//

import Foundation
import CoreData


extension Cloud {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cloud> {
        return NSFetchRequest<Cloud>(entityName: "Cloud")
    }

    @NSManaged public var id: UUID
    @NSManaged public var content: String
    @NSManaged public var createTime: Date
    @NSManaged public var opacity: Int16

}

extension Cloud : Identifiable {

}
