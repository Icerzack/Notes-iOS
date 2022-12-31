//
//  NoteViewCell.swift
//  Notes-iOS
//
//  Created by Max Kuznetsov on 30.12.2022.
//

import UIKit

class NoteViewCell: UITableViewCell {
    
    public static let reuseIdentifier = "NoteCell"
    
    var note: Note? {
        didSet{
            guard let name = note?.name, let shortDescription = note?.shortDescription, let _ = note?.longDescription, let _ = note?.images else {
                return
            }
            nameLabel.text = name
            shortDescriptionLabel.text = shortDescription
        }
    }
    
    private let mainLayer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(rgb: 0x009a99)
        view.layer.borderWidth = 0.1
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    private let shadowLayer: ShadowView = {
        let view = ShadowView()
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray6
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    private let shortDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray6
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(mainLayer)
        contentView.insertSubview(shadowLayer, belowSubview: mainLayer)
        mainLayer.addSubview(nameLabel)
        mainLayer.addSubview(shortDescriptionLabel)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        mainLayer.frame = contentView.bounds
        shadowLayer.frame = contentView.bounds
        
        mainLayer.frame = mainLayer.frame.inset(by: UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10))
        shadowLayer.frame = shadowLayer.frame.inset(by: UIEdgeInsets(top: 15, left: 10, bottom: 13, right: 10))

        nameLabel.anchor(top: mainLayer.topAnchor, left: mainLayer.leftAnchor, bottom: nil, right: mainLayer.rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: (mainLayer.bounds.height-15)/2, enableInsets: false)
        shortDescriptionLabel.anchor(top: nil, left: mainLayer.leftAnchor, bottom: mainLayer.bottomAnchor, right: mainLayer.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 5, paddingRight: 10, width: 0, height: (mainLayer.bounds.height-15)/2, enableInsets: false)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
