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
    var getPostsDto = GetPostsCommandDto()
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
        setupKeyboard()
        setupSearchInput()
        setupFindButton()
        setupOptionsButton()
        setupScrollView()
        setupStackView()
        
    }
    
    
    
    private func setupKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        endEditing(true)
    }
    
    private func setupSearchInput() {
        addSubview(searchInput)
        searchInput.backgroundColor = ColorConverter.hexStringToUIColor(hex: "DCDCDC")
        searchInput.translatesAutoresizingMaskIntoConstraints = false
        searchInput.layer.cornerRadius = 15
        searchInput.layer.borderWidth = 2
        searchInput.placeholder = "Post title"
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
        
        findButton.layer.cornerRadius = 15
        findButton.layer.borderWidth = 2
        findButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        findButton.leadingAnchor.constraint(equalTo: searchInput.trailingAnchor, constant: 30).isActive = true
        findButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        findButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -frame.height * 0.9).isActive = true
        findButton.addTarget(self, action: #selector(didTapFindButton), for: .touchUpInside)
    }
    
    @objc private func didTapFindButton() {
        var dto = GetPostsCommandDto(token: DataStorage.shared.user?.token,
                                             title: searchInput.text,
                                             tags: DataStorage.shared.getPostCommandDto?.tags ?? [],
                                             minRate: DataStorage.shared.getPostCommandDto?.minRate ?? 0)
        let jsonGetPosts = try! jsonEncoder.encode(dto)
        
        var request = URLRequest(url: URL(string: "http://185.242.104.101/api/post/get-posts")!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonGetPosts
        sendRequest(data: jsonGetPosts, request: request)
        if(DataStorage.shared.postList != nil) {
            for i in DataStorage.shared.postList!.posts {
                print(DataStorage.shared.postList!.posts)
            }
        }
        getStackViewData()
    }
    
    private func setupOptionsButton() {
        addSubview(optionsButton)
        
        optionsButton.setTitle("O", for: .normal)
        optionsButton.backgroundColor = ColorConverter.hexStringToUIColor(hex: "DCDCDC")
        optionsButton.translatesAutoresizingMaskIntoConstraints = false
        optionsButton.layer.cornerRadius = 15
        optionsButton.layer.borderWidth = 2
        optionsButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        optionsButton.leadingAnchor.constraint(equalTo: findButton.trailingAnchor, constant: 30).isActive = true
        optionsButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        optionsButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -frame.height * 0.9).isActive = true
        optionsButton.addTarget(self, action: #selector(didTapOptionsButton), for: .touchUpInside)
    }
    
    @objc private func didTapOptionsButton() {
        var menuControl = SearchMenuControl()
        let vc = UIViewController()
        vc.view.addSubview(menuControl)
        vc.view.backgroundColor = ColorConverter.hexStringToUIColor(hex: "27282D")
        menuControl.frame = CGRect(x: 30, y: 100, width: getCurrentVC()!.view.frame.width - 60, height: getCurrentVC()!.view.frame.height - 200)
//        menuControl.topAnchor.constraint(equalTo: vc.view.topAnchor).isActive = true
//        menuControl.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor).isActive = true
//        menuControl.trailingAnchor.constraint(equalTo: vc.view.trailingAnchor).isActive = true
//        menuControl.bottomAnchor.constraint(equalTo: vc.view.bottomAnchor).isActive = true
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        navVC.title = "Search options"
        // navVC.isNavigationBarHidden = true
        getCurrentVC()?.present(navVC, animated: true)
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
                storage.postList = postList
            }
        }
        task.resume()
    }
    
    private func getStackViewData() {
        if (DataStorage.shared.postList == nil) {
            return
        }
        stackView.arrangedSubviews
            .filter({ $0 is PostCell})
            .forEach({ $0.removeFromSuperview()})
        stackView.frame = scrollView.frame
        postCells = [PostCell]()
        var cell: PostCell = PostCell()
        let posts = DataStorage.shared.postList!.posts
        let numberOfCells = DataStorage.shared.postList!.posts.count
        if (numberOfCells == 0) {
            return
        }
        for i in 0...(numberOfCells-1) {
            cell = PostCell()
            cell.postView.changePost(post: posts[i])
            postCells.append(cell)
        }
        
        postCells.sort(by: {(first: PostCell, second: PostCell) -> Bool in
            first.postView.post.rate > second.postView.post.rate
        })
        
        var top = 5
        for i in 0...(numberOfCells-1) {
            cell = postCells[i]
            //cell.timeLabel.text = generator.randomTime()
            cell.layer.masksToBounds = true
            cell.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(cell)
            stackView.sendSubviewToBack(cell)
            
            
            // cell.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
            
            // cell.setWidth(to: Double(stackView))
            cell.topAnchor.constraint(equalTo: stackView.topAnchor, constant: CGFloat(top)).isActive = true
            cell.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 15).isActive = true
            cell.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -15).isActive = true
            //cell.setHeight(to: Double(stackView.frame.height) * 0.5)
            top += Int(stackView.frame.height) / 4
       }
        sendSubviewToBack(scrollView)
    }
    
    func getCurrentVC() -> UIViewController? {
        if let rootController = UIApplication.shared.keyWindow?.rootViewController {
            var currentController: UIViewController! = rootController
            while( currentController.presentedViewController != nil ) {
                currentController = currentController.presentedViewController
            }
            return currentController
        }
        return nil
    }
}
