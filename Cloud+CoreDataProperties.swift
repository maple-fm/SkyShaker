//
//  Cloud+CoreDataProperties.swift
//  SkyShaker
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

    @NSManaged public var id: String
    @NSManaged public var content: String
    @NSManaged public var createdDate: Date
    @NSManaged public var opacity: Double

}

extension Cloud : Identifiable {

}
