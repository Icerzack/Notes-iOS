//
//  Note.swift
//  Notes-iOS
//
//  Created by Max Kuznetsov on 30.12.2022.
//

import Foundation
import RealmSwift


protocol NoteProtocol: Object {
    var name: String { get set }
    var shortDescription: String { get set }
    var longDescription: String? { get set }
    var images: List<Data?> { get set }
}

class Note: Object, NoteProtocol{
    @Persisted var name: String
    @Persisted var shortDescription: String
    @Persisted var longDescription: String?
    @Persisted var images: List<Data?>
    
    convenience init(name: String, shortDescription: String, longDescription: String?, images: List<Data?>) {
        self.init()
        self.name = name
        self.shortDescription = shortDescription
        self.longDescription = longDescription
        self.images = images
    }
}
