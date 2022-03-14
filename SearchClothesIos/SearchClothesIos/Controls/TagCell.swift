//
//  TagCell.swift
//  SearchClothesIos
//
//  Created by user211270 on 3/14/22.
//

import UIKit

class TagCell: UIView
{
    public var tagView: TagView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.tagView = TagView(frame: self.bounds)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        setupTitleLabel()
    }
    
    func setupTitleLabel() {
        addSubview(tagView)
        backgroundColor = .clear
        tagView.autoresizingMask = self.autoresizingMask
        sendSubviewToBack(tagView)
    }
}
