//
//  ArticleEntity+CoreDataProperties.swift
//  
//
//  Created by Alexandr Mefisto on 17.11.2022.
//
//

import Foundation
import CoreData


extension ArticleEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ArticleEntity> {
        return NSFetchRequest<ArticleEntity>(entityName: "ArticleEntity")
    }

    @NSManaged public var title: String?
    @NSManaged public var descr: String?
    @NSManaged public var url: String?
    @NSManaged public var image: String?

}
