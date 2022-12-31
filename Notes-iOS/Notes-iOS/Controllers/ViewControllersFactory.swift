//
//  ViewControllersFactory.swift
//  Notes-iOS
//
//  Created by Max Kuznetsov on 30.12.2022.
//

import UIKit

enum ViewControllerType{
    case notesList
    case editNote
    case settings
    
    func viewController() -> UIViewController{
        switch self {
        case .notesList:
            return NotesListViewController()
        case .editNote:
            return EditBasicNoteViewController()
        case .settings:
            return SettingsViewController()
        }
    }
    
}

final class ViewControllerFactory{
    static func viewController(for typeOfVC: ViewControllerType) -> UIViewController{
        let vc = typeOfVC.viewController()
        return vc
    }
}
