//
//  StorageManager.swift
//  Notes-iOS
//
//  Created by Max Kuznetsov on 30.12.2022.
//

import Foundation
import RealmSwift

protocol StorageManagerProtocol: AnyObject{
    static var shared: StorageManagerProtocol {get}
    
    func writeData(noteToWrite: Note)
    func readAllData() -> [Note]?
    func modifyData(noteToModify: Note, newNote: Note)
    func deleteData(noteToDelete: Note)
}

final class RealmStorageManager: StorageManagerProtocol{
    static let shared: StorageManagerProtocol = RealmStorageManager()
    private let localRealm = try! Realm()
    
    func writeData(noteToWrite: Note){
        try! localRealm.write {
            localRealm.add(noteToWrite)
        }
    }
    
    func readAllData() -> [Note]? {
        let notes = localRealm.objects(Note.self)
        return Array(notes)
    }
    
    func modifyData(noteToModify: Note, newNote: Note) {
        try! localRealm.write {
            noteToModify.name = newNote.name
            noteToModify.shortDescription = newNote.shortDescription
            noteToModify.longDescription = newNote.longDescription
            noteToModify.images = newNote.images
        }
    }
    
    func deleteData(noteToDelete: Note) {
        try! localRealm.write {
            localRealm.delete(noteToDelete)
        }
    }
}


