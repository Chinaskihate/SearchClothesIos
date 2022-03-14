//
//  MainController.swift
//  SearchClothesIos
//
//  Created by user211270 on 3/14/22.
//

import Foundation

import UIKit

class MainViewController: UIViewController {
    let buttonStack = UIStackView()
    let buttonCreatedPosts = UIButton()
    let buttonRatedPosts = UIButton()
    let buttonFindPosts = UIButton()
    let buttonTags = UIButton()
    var mainControl = SearchPostsControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorConverter.hexStringToUIColor(hex: "27282D")
        setupButtonStack()
        setupButtonCreatedPosts()
        setupButtonRatedPosts()
        setupButtonFindPosts()
        setupButtonTags()
        setupSearchPostsControl()
        view.bringSubviewToFront(buttonStack)
    }
    
    private func setupSearchPostsControl() {
        view.addSubview(mainControl)
        mainControl.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height - CGFloat(100))
        view.sendSubviewToBack(mainControl)
    }
    
    private func setupButtonStack() {
        view.addSubview(buttonStack)
        buttonStack.backgroundColor = ColorConverter.hexStringToUIColor(hex: "D0C3BD")
        buttonStack.axis = .horizontal
        buttonStack.distribution = .fillEqually
        buttonStack.spacing = 10
        let height = CGFloat(100)
        buttonStack.frame = CGRect(x: 0, y: view.frame.size.height - height, width: view.frame.size.width, height: height)
    }

    private func setupButtonCreatedPosts() {
        buttonStack.addArrangedSubview(buttonCreatedPosts)
        buttonCreatedPosts.setTitle("CP", for: .normal)
//        buttonCreatedPosts.frame = CGRect(x: 0, y: view.frame.size.height - buttonStack.frame.size.height,
//                                          width: CGFloat(25), height: buttonStack.frame.height)
    }
    
    private func setupButtonRatedPosts() {
        buttonStack.addArrangedSubview(buttonRatedPosts)
        buttonRatedPosts.setTitle("RP", for: .normal)
        
    }
    
    private func setupButtonFindPosts() {
        buttonStack.addArrangedSubview(buttonFindPosts)
        buttonFindPosts.setTitle("FP", for: .normal)
        
    }
    
    private func setupButtonTags() {
        buttonStack.addArrangedSubview(buttonTags)
        buttonTags.setTitle("T", for: .normal)
    }
}
