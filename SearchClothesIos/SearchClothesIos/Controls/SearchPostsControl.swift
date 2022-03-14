//
//  SearchPostsControl.swift
//  SearchClothesIos
//
//  Created by user211270 on 3/14/22.
//

import Foundation
import UIKit
import Alamofire
import SDWebImage
import SwiftyJSON

class SearchPostsControl: UIView {
    let jsonEncoder = JSONEncoder()
    let searchInput = UITextField()
    let findButton = UIButton()
    let optionsButton = UIButton()
    let stackView = UIStackView()
    let scrollView = UIScrollView()
    private var postCells = [PostCell]()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        setupSearchInput()
        setupFindButton()
        setupOptionsButton()
        setupScrollView()
        setupStackView()
        
    }
    
    private func setupSearchInput() {
        addSubview(searchInput)
        searchInput.backgroundColor = ColorConverter.hexStringToUIColor(hex: "DCDCDC")
        searchInput.translatesAutoresizingMaskIntoConstraints = false
        //let space = frame.
        searchInput.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        searchInput.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        searchInput.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        searchInput.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -frame.height * 0.9).isActive = true
        
    }
    
    
    private func setupFindButton() {
        addSubview(findButton)
        findButton.setTitle("F", for: .normal)
        findButton.backgroundColor = ColorConverter.hexStringToUIColor(hex: "DCDCDC")
        findButton.translatesAutoresizingMaskIntoConstraints = false
        //let space = frame.
        findButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        findButton.leadingAnchor.constraint(equalTo: searchInput.trailingAnchor, constant: 30).isActive = true
        findButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        findButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -frame.height * 0.9).isActive = true
        findButton.addTarget(self, action: #selector(didTapFindButton), for: .touchUpInside)
    }
    
    @objc private func didTapFindButton() {
        var dto = GetPostsCommandDto(token: DataStorage.shared.user?.token,
                                     title: searchInput.text,
                                     tags: [],
                                     minRate: 0)
        
        let jsonLoginPost = try! jsonEncoder.encode(dto)
        var request = URLRequest(url: URL(string: "http://185.242.104.101/api/post/get-posts")!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonLoginPost
        sendRequest(data: jsonLoginPost, request: request)
        if(DataStorage.shared.posts != nil) {
            for i in DataStorage.shared.posts!.posts {
                print(DataStorage.shared.posts!.posts)
            }
        }
        getStackViewData()
    }
    
    private func setupOptionsButton() {
        addSubview(optionsButton)
        
        optionsButton.setTitle("O", for: .normal)
        optionsButton.backgroundColor = ColorConverter.hexStringToUIColor(hex: "DCDCDC")
        optionsButton.translatesAutoresizingMaskIntoConstraints = false
        //let space = frame.
        optionsButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        optionsButton.leadingAnchor.constraint(equalTo: findButton.trailingAnchor, constant: 30).isActive = true
        optionsButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        optionsButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -frame.height * 0.9).isActive = true
    }
    
    private func setupStackView() {
        scrollView.addSubview(stackView)
        
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        getStackViewData()
    }
    
    private func setupScrollView() {
        addSubview(scrollView)
        sendSubviewToBack(scrollView)
        scrollView.backgroundColor = ColorConverter.hexStringToUIColor(hex: "DCDCDC")
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.layer.cornerRadius = 15
        scrollView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 30).isActive = true
        scrollView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -30).isActive = true
    }
    
    override func layoutSubviews() {
        searchInput.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,
                                            constant: -frame.height * 0.85).isActive = true
        searchInput.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,
                                              constant: -(30 + frame.width * 0.25)).isActive = true
        
        findButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,
                                            constant: -frame.height * 0.85).isActive = true
        findButton.leadingAnchor.constraint(equalTo: searchInput.trailingAnchor,
                                              constant: 5).isActive = true
        findButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,
                                              constant: -frame.width * 0.175).isActive = true
        
        optionsButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,
                                            constant: -frame.height * 0.85).isActive = true
        optionsButton.leadingAnchor.constraint(equalTo: findButton.trailingAnchor,
                                              constant: 5).isActive = true
        optionsButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,
                                              constant: -30).isActive = true
        
        scrollView.topAnchor.constraint(equalTo: searchInput.bottomAnchor, constant: 15).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 20).isActive = true
        
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 15).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        
        scrollView.contentSize = CGSize(
            width: self.scrollView.frame.width,
            height: stackView.frame.height
        )
        
        scrollView.alwaysBounceVertical = true
    }
    
    private func sendRequest(data: Data, request: URLRequest) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let postList = try? JSONDecoder().decode(PostList.self, from: data) {
                var storage = DataStorage.shared
                storage.posts = postList
            }
        }
        task.resume()
    }
    
    private func getStackViewData() {
        if (DataStorage.shared.posts == nil) {
            return
        }
        stackView.arrangedSubviews
            .filter({ $0 is PostCell})
            .forEach({ $0.removeFromSuperview()})
        stackView.frame = scrollView.frame
        postCells = [PostCell]()
        var cell: PostCell = PostCell()
        let posts = DataStorage.shared.posts!.posts
        let numberOfCells = DataStorage.shared.posts!.posts.count
        if (numberOfCells == 0) {
            return
        }
        for i in 0...(numberOfCells-1) {
            cell = PostCell()
            cell.postView.changePost(post: posts[i])
            postCells.append(cell)
        }
        
//        alarms.sort(by: {(first: StackCell, second: StackCell) -> Bool in
//            first.alarm.timeViewModel < second.alarm.timeViewModel
//        })
        var top = 5
        for i in 0...(numberOfCells-1) {
            cell = postCells[i]
            //cell.timeLabel.text = generator.randomTime()
            cell.layer.masksToBounds = true
            cell.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(cell)
            stackView.sendSubviewToBack(cell)
            
            
            // cell.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
            cell.setHeight(to: Double(stackView.frame.height)/5)
            
            // cell.setWidth(to: Double(stackView))
            cell.topAnchor.constraint(equalTo: stackView.topAnchor, constant: CGFloat(top)).isActive = true
            cell.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 15).isActive = true
            cell.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -15).isActive = true
            top += Int(stackView.frame.height) / 4
       }
        sendSubviewToBack(scrollView)
    }
}
