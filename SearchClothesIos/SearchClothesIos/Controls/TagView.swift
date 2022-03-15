//
//  TagView.swift
//  SearchClothesIos
//
//  Created by user211270 on 3/14/22.
//

import UIKit

class TagView : UIView {
    var tagData: Tag!
    
    let tagButton: UIButton = {
        let control = UIButton()
        
        control.backgroundColor = .clear
        control.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        control.titleLabel?.textAlignment = .center
        control.titleLabel?.textColor = UIColor.black
        control.titleLabel?.text = ""
        control.setTitleColor(UIColor.black, for: .normal)
        control.translatesAutoresizingMaskIntoConstraints = false // required
        return control
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeTag(tagData: Tag) {
        self.tagData = tagData
        tagButton.setTitle("#\(tagData.name)", for: .normal)
    }
    
    func addView() {
        backgroundColor = ColorConverter.hexStringToUIColor(hex: "DCDCDC")
        layer.cornerRadius = 15
        layer.borderWidth = 3
        
        addSubview(tagButton)
        tagButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tagButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        tagButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        tagButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        tagButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
     }
}
