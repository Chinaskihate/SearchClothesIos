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

class TagsControl: UIView {
    let jsonEncoder = JSONEncoder()
    let tagsLable = UILabel()
    let refreshButton = UIButton()
    let createButton = UIButton()
    let stackView = UIStackView()
    let scrollView = UIScrollView()
    private var tagCells = [TagCell]()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        setupTagsTitle()
        setupRefreshButton()
        setupCreateButton()
        setupScrollView()
        setupStackView()
    }
    
    private func setupTagsTitle() {
        addSubview(tagsLable)
        tagsLable.text = "All tags"
        tagsLable.backgroundColor = .clear
        tagsLable.textColor = .white
        tagsLable.translatesAutoresizingMaskIntoConstraints = false
        tagsLable.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        tagsLable.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        tagsLable.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -frame.height * 0.85).isActive = true
        tagsLable.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -frame.width * 0.6).isActive = true
    }
    
    private func setupRefreshButton() {
        addSubview(refreshButton)
        refreshButton.setTitle("R", for: .normal)
        refreshButton.backgroundColor = ColorConverter.hexStringToUIColor(hex: "D0C3BD")
        refreshButton.translatesAutoresizingMaskIntoConstraints = false
        
        refreshButton.layer.cornerRadius = 15
        refreshButton.layer.borderWidth = 2
        refreshButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        refreshButton.leadingAnchor.constraint(equalTo: tagsLable.trailingAnchor, constant: 30).isActive = true
        refreshButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -frame.height * 0.9).isActive = true
        refreshButton.addTarget(self, action: #selector(didTapRefreshButton), for: .touchUpInside)
    }
    
    @objc private func didTapRefreshButton() {
        var dto = GetAllTagsCommandDto(token: DataStorage.shared.user?.token)
        
        let jsonGetTags = try! jsonEncoder.encode(dto)
        var request = URLRequest(url: URL(string: "http://185.242.104.101/api/tag/get-all")!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonGetTags
        sendGetTagsRequest(data: jsonGetTags, request: request)
        getStackViewData()
    }
    
    private func setupCreateButton() {
        addSubview(createButton)
        
        createButton.setTitle("C", for: .normal)
        createButton.backgroundColor = ColorConverter.hexStringToUIColor(hex: "D0C3BD")
        createButton.translatesAutoresizingMaskIntoConstraints = false
        createButton.layer.cornerRadius = 15
        createButton.layer.borderWidth = 2
        createButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        createButton.leadingAnchor.constraint(equalTo: refreshButton.trailingAnchor, constant: 30).isActive = true
        createButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        createButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -frame.height * 0.9).isActive = true
        createButton.addTarget(self, action: #selector(didTapCreateButton), for: .touchUpInside)
    }
    
    @objc private func didTapCreateButton() {
        var dto = CreateTagCommandDto()
        dto.token = DataStorage.shared.user!.token
        let ac = UIAlertController(title: "Create tag", message: nil, preferredStyle: .alert)
        ac.addTextField { (textField) in
            textField.placeholder = "Enter tag name"
        }
        let submitAction = UIAlertAction(title: "Confirm", style: .default, handler: { (action: UIAlertAction!) in
            dto.name = ac.textFields![0].text
            let jsonCreateTag = try! self.jsonEncoder.encode(dto)
            var request = URLRequest(url: URL(string: "http://185.242.104.101/api/tag/create")!)
            request.httpMethod = HTTPMethod.post.rawValue
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonCreateTag
            self.sendCreateTagRequest(data: jsonCreateTag, request: request)
        })
        ac.addAction(submitAction)
        getCurrentVC()?.present(ac, animated: true)
//                                , completion: {() in
//            let jsonCreateTag = try! self.jsonEncoder.encode(dto)
//            var request = URLRequest(url: URL(string: "http://185.242.104.101/api/tag/create")!)
//            request.httpMethod = HTTPMethod.post.rawValue
//            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//            request.httpBody = jsonCreateTag
//            self.sendCreateTagRequest(data: jsonCreateTag, request: request)
//        })
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
        tagsLable.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        tagsLable.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        tagsLable.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -frame.height * 0.85).isActive = true
        tagsLable.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -frame.width * 0.6).isActive = true
        
        refreshButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,
                                            constant: -frame.height * 0.85).isActive = true
        refreshButton.leadingAnchor.constraint(equalTo: tagsLable.trailingAnchor,
                                                constant: frame.height * 0.75).isActive = true
        refreshButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,
                                              constant: -frame.width * 0.175).isActive = true
        
        createButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,
                                            constant: -frame.height * 0.85).isActive = true
        createButton.leadingAnchor.constraint(equalTo: refreshButton.trailingAnchor,
                                              constant: 5).isActive = true
        createButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,
                                              constant: -30).isActive = true
        
        scrollView.topAnchor.constraint(equalTo: refreshButton.bottomAnchor, constant: 15).isActive = true
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
    
    private func sendGetTagsRequest(data: Data, request: URLRequest) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let tagList = try? JSONDecoder().decode(TagList.self, from: data) {
                var storage = DataStorage.shared
                storage.tagList = tagList
            }
        }
        task.resume()
    }
    
    private func sendCreateTagRequest(data: Data, request: URLRequest) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let createResult = try? JSONDecoder().decode(Bool?.self, from: data) {
                let storage = DataStorage.shared
                storage.createTagResult = createResult
            }
        }
        task.resume()
    }
    
    private func getStackViewData() {
        if (DataStorage.shared.tagList == nil) {
            return
        }
        stackView.arrangedSubviews
            .filter({ $0 is TagCell})
            .forEach({ $0.removeFromSuperview()})
        stackView.frame = scrollView.frame
        tagCells = [TagCell]()
        var cell: TagCell = TagCell()
        let tags = DataStorage.shared.tagList!.tags
        let numberOfCells = tags.count
        if (numberOfCells == 0) {
            return
        }
        for i in 0...(numberOfCells-1) {
            cell = TagCell()
            cell.tagView.changeTag(tagData: tags[i])
            tagCells.append(cell)
        }
        
        tagCells.sort(by: {(first: TagCell, second: TagCell) -> Bool in
            first.tagView.tagData.name.lowercased() < second.tagView.tagData.name.lowercased()
        })
        
        var top = 5
        for i in 0...(numberOfCells-1) {
            cell = tagCells[i]
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
            top += 100
            //top += Int(stackView.frame.height) / 4
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
