//
//  ShadowView.swift
//  Notes-iOS
//
//  Created by Max Kuznetsov on 31.12.2022.
//
import UIKit

class ShadowView: UIView {
    
    var setupShadowDone: Bool = false
    
    public func setupShadow() {
        if setupShadowDone { return }
        self.layer.cornerRadius = 20
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.2
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 20, height: 20)).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        
        setupShadowDone = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupShadow()
    }
}
