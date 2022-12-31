//
//  EditNoteViewController.swift
//  Notes-iOS
//
//  Created by Max Kuznetsov on 31.12.2022.
//

import UIKit
import RealmSwift

class EditBasicNoteViewController: UIViewController {
    
    var note: Note?
    var doAfterFinish: ((Note)->Void)?
    
    private let shadowLayerForName: ShadowView = {
        let view = ShadowView()
        return view
    }()
    
    private let shadowLayerForArea: ShadowView = {
        let view = ShadowView()
        return view
    }()
    
    private let shadowLayerForButton: ShadowView = {
        let view = ShadowView()
        return view
    }()
    
    private let nameTextField: UITextField = {
        let tf = UITextField()
        tf.font = .systemFont(ofSize: 24)
        tf.textColor = .black
        tf.layer.borderWidth = 0.1
        tf.layer.borderColor = UIColor.black.cgColor
        tf.layer.cornerRadius = 20
        tf.backgroundColor = .white
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        tf.leftViewMode = .always
        tf.placeholder = "Input short name"
        return tf
    }()
    
    private let areaTextView: UITextView = {
        let tv = UITextView()
        tv.font = .systemFont(ofSize: 18)
        tv.textColor = .black
        tv.layer.borderWidth = 0.1
        tv.layer.borderColor = UIColor.black.cgColor
        tv.layer.cornerRadius = 20
        tv.text = "I want to..."
        return tv
    }()
    
    private let submitButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.layer.borderWidth = 0.1
        btn.layer.borderColor = UIColor.black.cgColor
        btn.backgroundColor = .link
        btn.layer.cornerRadius = 20
        btn.setTitle("Submit", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "NoteApp"
        view.backgroundColor = UIColor(rgb: 0xfbf9fa)
        
        setupLayout()
        
        submitButton.addTarget(self, action: #selector(submitPressed), for: .touchUpInside)
        
        if let note = note {
            nameTextField.text = note.name
            areaTextView.text = note.longDescription
        }
        
    }
    
    @objc private func submitPressed(){
        guard let name = nameTextField.text, let longDescription = areaTextView.text, !name.isEmpty, !longDescription.isEmpty else {
            return
        }
        var shortDescription = longDescription.substring(with: 0..<min(longDescription.count, 40))
        if shortDescription.count == 40 {
            shortDescription+="..."
        }
        let note = Note(name: name, shortDescription: shortDescription, longDescription: longDescription, images: List())
        doAfterFinish?(note)
        navigationController?.popViewController(animated: true)
    }
    
    override func loadView() {
        super.loadView()
        
        view.addSubview(nameTextField)
        view.addSubview(areaTextView)
        view.addSubview(submitButton)
        
        view.insertSubview(shadowLayerForName, belowSubview: nameTextField)
        view.insertSubview(shadowLayerForArea, belowSubview: areaTextView)
        view.insertSubview(shadowLayerForButton, belowSubview: submitButton)
        
    }
    
    private func setupLayout(){
        nameTextField.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 50, enableInsets: false)
        submitButton.anchor(top: nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 20, paddingRight: 10, width: 0, height: 50, enableInsets: false)
        areaTextView.anchor(top: nameTextField.topAnchor, left: view.leftAnchor, bottom: submitButton.topAnchor, right: view.rightAnchor, paddingTop: 70, paddingLeft: 10, paddingBottom: 20, paddingRight: 10, width: 0, height: 0, enableInsets: false)
        
        shadowLayerForName.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 50, enableInsets: false)
        shadowLayerForButton.anchor(top: nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 20, paddingRight: 10, width: 0, height: 50, enableInsets: false)
        shadowLayerForArea.anchor(top: shadowLayerForName.topAnchor, left: view.leftAnchor, bottom: shadowLayerForButton.topAnchor, right: view.rightAnchor, paddingTop: 70, paddingLeft: 10, paddingBottom: 20, paddingRight: 10, width: 0, height: 0, enableInsets: false)
    }

}
