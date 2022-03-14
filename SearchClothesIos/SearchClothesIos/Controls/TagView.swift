//
//  TagView.swift
//  SearchClothesIos
//
//  Created by user211270 on 3/14/22.
//

import UIKit

class TagView : UIView {
    var tagData: Tag!
    
    let tagLabel: UILabel = {
        let control = UILabel()
        control.font = UIFont.systemFont(ofSize: 14)
        control.textAlignment = .center
        control.textColor = UIColor.black
        control.text = ""
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
        tagLabel.text = "#\(tagData.name)"
    }
    
    func addView() {
        backgroundColor = ColorConverter.hexStringToUIColor(hex: "DCDCDC")
        layer.cornerRadius = 15
        
        addSubview(tagLabel)
        tagLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tagLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        tagLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        tagLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
}
