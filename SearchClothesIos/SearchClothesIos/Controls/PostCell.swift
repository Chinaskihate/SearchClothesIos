//
//  RatePostCell.swift
//  SearchClothesIos
//
//  Created by user211270 on 3/14/22.
//

import UIKit

class PostCell: UIView
{
    public var postView: PostView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.postView = PostView(frame: self.bounds)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        setupTitleLabel()
    }
    
    func setupTitleLabel() {
        addSubview(postView)
        backgroundColor = .clear
        postView.autoresizingMask = self.autoresizingMask
        sendSubviewToBack(postView)
    }
}
