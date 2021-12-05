//
//  Book+CoreDataProperties.swift
//  MyBookList
//
//  Created by Daichi Morihara on 2021/12/05.
//
//

import Foundation
import CoreData


extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    @NSManaged public var author: String?
    @NSManaged public var date: Date?
    @NSManaged public var genre: String?
    @NSManaged public var id: UUID?
    @NSManaged public var rating: Int16
    @NSManaged public var review: String?
    @NSManaged public var title: String?
    
    public var wrappedAuthor: String {
        author ?? "Unknown Author"
    }
    public var wrappedDate: Date {
        date ?? Date()
    }
    public var wrappedId: UUID {
        id ?? UUID()
    }
    public var wrappedGenre: String {
        genre ?? "Unknown Genre"
    }
    public var wrappedReview: String {
        review ?? ""
    }
    public var wrappedTitle: String {
        title ?? "Unknown Title"
    }
    

}

extension Book : Identifiable {

}
