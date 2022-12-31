//
//  ViewController.swift
//  Notes-iOS
//
//  Created by Max Kuznetsov on 30.12.2022.
//

import UIKit

class NotesListViewController: UIViewController {
    
    private let realmDbInstance = RealmStorageManager()
    
    private var notesList: [Note]?
    
    lazy var notesTableView: UITableView = {
        let tv = UITableView()
        tv.layer.backgroundColor = UIColor.clear.cgColor
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.dataSource = self
        tv.register(NoteViewCell.self, forCellReuseIdentifier: NoteViewCell.reuseIdentifier)
        tv.separatorStyle = .none
        return tv
    }()
    
    private let backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "background")
        iv.contentMode = .scaleToFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "NoteApp"
        view.backgroundColor = UIColor(rgb: 0xfbf9fa)
        
        notesList = realmDbInstance.readAllData()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createNewNote))
        
        setupLayout()
        
    }
    
    override func loadView() {
        super.loadView()
        
        view.addSubview(notesTableView)
        view.addSubview(backgroundImageView)
    }
    
    private func setupLayout(){
        notesTableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        backgroundImageView.anchor(top: nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 125, enableInsets: false)
    }
    
    @objc private func createNewNote(){
        let vc = ViewControllerFactory.viewController(for: .editNote) as! EditBasicNoteViewController
        vc.doAfterFinish = { [weak self] newNote in
            self?.realmDbInstance.writeData(noteToWrite: newNote)
            self?.notesList?.append(newNote)
            self?.notesTableView.reloadData()
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension NotesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notesList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NoteViewCell.reuseIdentifier, for: indexPath) as! NoteViewCell
        cell.note = notesList?[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ViewControllerFactory.viewController(for: .editNote) as! EditBasicNoteViewController
        let noteToModify = notesList?[indexPath.row]
        vc.note = noteToModify
        vc.doAfterFinish = { [weak self] newNote in
            self?.realmDbInstance.modifyData(noteToModify: noteToModify!, newNote: newNote)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

//MARK: setup context cofigurator
extension NotesListViewController {
    func configureContextMenu(index: Int) -> UIContextMenuConfiguration {
        let context = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (action) -> UIMenu? in
            
            let delete = UIAction(title: "Удалить", image: UIImage(systemName: "trash.fill"), attributes: [.destructive]) { [self] _ in
                realmDbInstance.deleteData(noteToDelete: notesList![index])
                notesList!.remove(at: index)
                notesTableView.reloadData()
            }
            return UIMenu(title: "", image: nil, identifier: nil, options: UIMenu.Options.displayInline, children: [delete])
            
        }
        return context
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        configureContextMenu(index: indexPath.row)
    }
}
