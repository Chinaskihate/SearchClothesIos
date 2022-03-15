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
    var mainControl: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorConverter.hexStringToUIColor(hex: "27282D")
        mainControl = SearchPostsControl()
        setupButtonStack()
        setupButtonCreatedPosts()
        setupButtonRatedPosts()
        setupButtonFindPosts()
        setupButtonTags()
        setupMainControl()
        view.bringSubviewToFront(buttonStack)
    }
    
    private func setupMainControl() {
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
        buttonCreatedPosts.addTarget(self, action: #selector(didTapCreatedPostsButton), for: .touchUpInside)
    }
    
    private func changeMainControl(control: UIView) {
        if (mainControl != nil) {
            mainControl.removeFromSuperview()
        }
        mainControl = control
        view.addSubview(mainControl)
        setupMainControl()
    }
    
    @objc private func didTapCreatedPostsButton() {
        changeMainControl(control: CreatedPostsControl())
    }
    
    private func setupButtonRatedPosts() {
        buttonStack.addArrangedSubview(buttonRatedPosts)
        buttonRatedPosts.setTitle("RP", for: .normal)
        buttonRatedPosts.addTarget(self, action: #selector(didTapRatesPostsButton), for: .touchUpInside)
    }
    
    @objc private func didTapRatesPostsButton() {
        changeMainControl(control: RatedPostsControl())
    }
    
    private func setupButtonFindPosts() {
        buttonStack.addArrangedSubview(buttonFindPosts)
        buttonFindPosts.setTitle("FP", for: .normal)
        buttonFindPosts.addTarget(self, action: #selector(didTapFindPostsButton), for: .touchUpInside)
    }
    
    @objc private func didTapFindPostsButton() {
        changeMainControl(control: SearchPostsControl())
    }
    
    private func setupButtonTags() {
        buttonStack.addArrangedSubview(buttonTags)
        buttonTags.setTitle("T", for: .normal)
    }
}
