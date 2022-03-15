//
//  RatePostView.swift
//  SearchClothesIos
//
//  Created by user211270 on 3/14/22.
//

import UIKit

class PostView : UIView {
    var post: Post!
    private var tagCells = [TagCell]()
    

    let titleLabel: UILabel = {
        let control = UILabel()
        control.font = UIFont.systemFont(ofSize: 20)
        control.textAlignment = .center
        control.textColor = UIColor.black
        control.text = ""
        control.translatesAutoresizingMaskIntoConstraints = false // required
        return control
    }()
    
    let rateLabel: UILabel = {
        let control = UILabel()
        control.font = UIFont.systemFont(ofSize: 20)
        control.textAlignment = .center
        control.textColor = UIColor.black
        control.text = ""
        control.translatesAutoresizingMaskIntoConstraints = false // required
        return control
    }()
    
    let stackView: UIStackView = {
        let control = UIStackView()
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    let scrollView: UIScrollView = {
       let control = UIScrollView()
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    let tagsStackView: UIStackView = {
        let control = UIStackView()
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changePost(post: Post) {
        self.post = post
        titleLabel.text = post.title
        rateLabel.text = String(post.rate)
        getStackViewData()
    }
    
    func setup() {
        backgroundColor = UIColor.white
        layer.cornerRadius = 15
        
        setupTitleLabel()
        setupRateLabel()
        setupScrollView()
        setupStackView()
    }
    
    func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    func setupRateLabel() {
        addSubview(rateLabel)
        rateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        rateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
    }
    
    func setupScrollView() {
        addSubview(scrollView)
        sendSubviewToBack(scrollView)
        scrollView.backgroundColor = ColorConverter.hexStringToUIColor(hex: "27282D")
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.layer.cornerRadius = 15
        scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: rateLabel.topAnchor, constant: -5).isActive = true
        
        scrollView.alwaysBounceHorizontal = true
    }
    
    func setupStackView() {
        scrollView.addSubview(stackView)
        
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 5
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        scrollView.contentSize = CGSize(
            width: stackView.frame.width,
            height: scrollView.frame.height
        )
        getStackViewData()
    }
    
    func getStackViewData() {
        if (post == nil) {
            return
        }
        stackView.arrangedSubviews
            .filter({ $0 is TagCell})
            .forEach({ $0.removeFromSuperview()})
        stackView.frame = scrollView.frame
        print(stackView.frame.height)
        print(stackView.frame.width)
        tagCells = [TagCell]()
        var cell: TagCell = TagCell()
        let tags = post.tags
        let numberOfCells = tags.count
        if (numberOfCells == 0) {
            return
        }
        
        for i in 0...(numberOfCells-1) {
            cell = TagCell()
            cell.tagView.changeTag(tagData: tags[i])
            tagCells.append(cell)
        }
        
        var left = 5
        for i in 0...(numberOfCells-1) {
            cell = tagCells[i]
            //cell.timeLabel.text = generator.randomTime()
            cell.layer.masksToBounds = true
            cell.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(cell)
            stackView.sendSubviewToBack(cell)
            
            cell.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 5).isActive = true
            cell.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: -5).isActive = true
            cell.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: CGFloat(left)).isActive = true
            cell.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -5).isActive = true
            //left += Int(stackView.frame.width) / 4
            left += 100
            print(stackView.frame.width)
       }
        sendSubviewToBack(scrollView)
        layoutSubviews()
    }
    
    override func layoutSubviews() {
        scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: rateLabel.topAnchor, constant: -5).isActive = true
        
        stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 5).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        scrollView.contentSize = CGSize(
            width: self.frame.width,
            height: stackView.frame.height
        )
        
        scrollView.alwaysBounceVertical = true
        scrollView.automaticallyAdjustsScrollIndicatorInsets = false;
    }
}
