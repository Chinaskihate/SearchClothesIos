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

class SearchMenuControl: UIView {
    let rateSlider = UISlider()
    let doneButton = UIButton()
    let selectedTagsStackView = UIStackView()
    let selectedTagsScrollView = UIScrollView()
    private var selectedTagsCells = [TagCell]()
    let unselectedTagsStackView = UIStackView()
    let unselectedTagsScrollView = UIScrollView()
    private var unselectedTagsCells = [TagCell]()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = ColorConverter.hexStringToUIColor(hex: "27282D")
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        setupRateSlider()
        setupDoneButton()
        setupSelectedTagsScrollView()
        setupSelectedTagsStackView()
        setupUnselectedTagsScrollView()
        setupUnselectedTagsStackView()
        getSelectedCellsStackViewData()
        getUnselectedCellsStackViewData()
    }
    
    private func setupRateSlider() {
        addSubview(rateSlider)
        rateSlider.minimumValue = 0
        rateSlider.maximumValue = 5
        rateSlider.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        rateSlider.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        rateSlider.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -frame.width * 0.15).isActive = true
        rateSlider.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -frame.height * 0.9).isActive = true
        
    }
    
    
    private func setupDoneButton() {
        addSubview(doneButton)
        doneButton.setTitle("F", for: .normal)
        doneButton.backgroundColor = ColorConverter.hexStringToUIColor(hex: "DCDCDC")
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        
        doneButton.layer.cornerRadius = 15
        doneButton.layer.borderWidth = 2
        doneButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        doneButton.leadingAnchor.constraint(equalTo: rateSlider.trailingAnchor, constant: 30).isActive = true
        doneButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        doneButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -frame.height * 0.9).isActive = true
        doneButton.addTarget(self, action: #selector(didTapDoneButton), for: .touchUpInside)
    }
    
    @objc private func didTapDoneButton() {
        var dto = GetPostsCommandDto()
        dto.minRate = rateSlider.value
        var tags = [Tag]()
        for cell in selectedTagsCells {
            tags.append(cell.tagView.tagData)
        }
        dto.tags = tags
        DataStorage.shared.getPostCommandDto = dto
        getCurrentVC()?.dismiss(animated: true)
    }
    
    private func setupSelectedTagsStackView() {
        selectedTagsScrollView.addSubview(selectedTagsStackView)
        
        selectedTagsStackView.distribution = .fillEqually
        selectedTagsStackView.axis = .vertical
        selectedTagsStackView.spacing = 10
        
        selectedTagsStackView.translatesAutoresizingMaskIntoConstraints = false
        selectedTagsStackView.leftAnchor.constraint(equalTo: selectedTagsScrollView.leftAnchor).isActive = true
        selectedTagsStackView.rightAnchor.constraint(equalTo: selectedTagsScrollView.rightAnchor).isActive = true
        // getSelectedCellsStackViewData()
    }
    
    private func setupSelectedTagsScrollView() {
        addSubview(selectedTagsScrollView)
        sendSubviewToBack(selectedTagsScrollView)
        selectedTagsScrollView.backgroundColor = ColorConverter.hexStringToUIColor(hex: "DCDCDC")
        selectedTagsScrollView.translatesAutoresizingMaskIntoConstraints = false
        selectedTagsScrollView.layer.cornerRadius = 15
        selectedTagsScrollView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 30).isActive = true
        selectedTagsScrollView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -frame.width - 30).isActive = true
    }
    
    private func setupUnselectedTagsScrollView() {
        addSubview(unselectedTagsScrollView)
        sendSubviewToBack(unselectedTagsScrollView)
        unselectedTagsScrollView.backgroundColor = ColorConverter.hexStringToUIColor(hex: "DCDCDC")
        unselectedTagsScrollView.translatesAutoresizingMaskIntoConstraints = false
        unselectedTagsScrollView.layer.cornerRadius = 15
        unselectedTagsScrollView.leftAnchor.constraint(equalTo: leftAnchor, constant: frame.width * 0.6).isActive = true
        unselectedTagsScrollView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -30).isActive = true
    }
    private func setupUnselectedTagsStackView() {
        unselectedTagsScrollView.addSubview(unselectedTagsStackView)
        
        unselectedTagsStackView.distribution = .fillEqually
        unselectedTagsStackView.axis = .vertical
        unselectedTagsStackView.spacing = 10
        
        unselectedTagsStackView.translatesAutoresizingMaskIntoConstraints = false
        unselectedTagsStackView.leftAnchor.constraint(equalTo: unselectedTagsScrollView.leftAnchor).isActive = true
        unselectedTagsStackView.rightAnchor.constraint(equalTo: unselectedTagsScrollView.rightAnchor).isActive = true
        // getSelectedCellsStackViewData()
    }
    
    override func layoutSubviews() {
        rateSlider.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        rateSlider.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        rateSlider.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -frame.width * 0.15).isActive = true
        rateSlider.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -frame.height * 0.9).isActive = true
        rateSlider.frame = CGRect(x: 30, y: 30, width: frame.width * 0.5, height: frame.height * 0.1)
        
        doneButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,
                                           constant: -frame.height * 0.9).isActive = true
        doneButton.leadingAnchor.constraint(equalTo: rateSlider.trailingAnchor,
                                              constant: 5).isActive = true
        doneButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,
                                              constant: 50).isActive = true
        doneButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        
        
        selectedTagsScrollView.topAnchor.constraint(equalTo: rateSlider.bottomAnchor, constant: 15).isActive = true
        selectedTagsScrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        selectedTagsScrollView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -frame.width * 0.5).isActive = true
        selectedTagsScrollView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true

        selectedTagsStackView.topAnchor.constraint(equalTo: selectedTagsScrollView.topAnchor, constant: 15).isActive = true
        selectedTagsStackView.bottomAnchor.constraint(equalTo: selectedTagsScrollView.bottomAnchor).isActive = true


        selectedTagsScrollView.contentSize = CGSize(
            width: self.selectedTagsScrollView.frame.width,
            height: selectedTagsStackView.frame.height
        )

        selectedTagsScrollView.alwaysBounceVertical = true
        
        unselectedTagsScrollView.leadingAnchor.constraint(equalTo: selectedTagsScrollView.trailingAnchor, constant: 40).isActive = true
        unselectedTagsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        unselectedTagsScrollView.topAnchor.constraint(equalTo: rateSlider.bottomAnchor, constant: 15).isActive = true
        unselectedTagsScrollView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        

        unselectedTagsStackView.topAnchor.constraint(equalTo: unselectedTagsScrollView.topAnchor, constant: 15).isActive = true
        unselectedTagsStackView.leadingAnchor.constraint(equalTo: unselectedTagsStackView.leadingAnchor).isActive = true
        unselectedTagsStackView.trailingAnchor.constraint(equalTo: unselectedTagsStackView.trailingAnchor).isActive = true
        
        unselectedTagsStackView.bottomAnchor.constraint(equalTo: unselectedTagsScrollView.bottomAnchor).isActive = true
        unselectedTagsStackView.widthAnchor.constraint(equalTo: unselectedTagsScrollView.widthAnchor).isActive = true
        
        unselectedTagsStackView.widthAnchor.constraint(equalTo: unselectedTagsScrollView.widthAnchor, multiplier: 0.5).isActive = true


        unselectedTagsScrollView.contentSize = CGSize(
            width: self.unselectedTagsScrollView.frame.width,
            height: unselectedTagsStackView.frame.height
        )

        unselectedTagsScrollView.alwaysBounceVertical = true
        sendSubviewToBack(unselectedTagsScrollView)
        
        var cell: TagCell = TagCell()
        if (DataStorage.shared.tagList == nil) {
            return
        }
        let tags = DataStorage.shared.tagList!.tags
        let numberOfCells = tags.count
        unselectedTagsCells = []
        if (numberOfCells == 0) {
            return
        }
        for i in 0...(numberOfCells-1) {
            cell = TagCell()
            cell.tagView.changeTag(tagData: tags[i])
            cell.tag = 0
            cell.tagView.tagButton.addTarget(self, action: #selector(didTapTag), for: .touchUpInside)
            unselectedTagsCells.append(cell)
        }
        getUnselectedCellsStackViewData()
        getSelectedCellsStackViewData()
        unselectedTagsScrollView.backgroundColor = .clear
    }
    
    private func getSelectedCellsStackViewData() {
        if (DataStorage.shared.tagList == nil) {
            return
        }
        selectedTagsStackView.arrangedSubviews
            .filter({ $0 is TagCell})
            .forEach({ $0.removeFromSuperview()})
        selectedTagsStackView.frame = selectedTagsScrollView.frame
        var cell: TagCell = TagCell()
        let tags = selectedTagsCells
        let numberOfCells = tags.count
        if (numberOfCells == 0) {
            return
        }
        for i in 0...(numberOfCells-1) {
            cell = tags[i]
            selectedTagsCells.append(cell)
        }

        var top = 5
        for i in 0...(numberOfCells-1) {
            cell = selectedTagsCells[i]
            //cell.timeLabel.text = generator.randomTime()
            cell.layer.masksToBounds = true
            cell.translatesAutoresizingMaskIntoConstraints = false
            selectedTagsStackView.addArrangedSubview(cell)
            selectedTagsStackView.sendSubviewToBack(cell)


            // cell.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true

            // cell.setWidth(to: Double(stackView))
            cell.topAnchor.constraint(equalTo: selectedTagsStackView.topAnchor, constant: CGFloat(top)).isActive = true
            cell.leadingAnchor.constraint(equalTo: selectedTagsStackView.leadingAnchor, constant: 15).isActive = true
            cell.trailingAnchor.constraint(equalTo: selectedTagsStackView.trailingAnchor, constant: -15).isActive = true
            //cell.setHeight(to: Double(stackView.frame.height) * 0.5)
            top += 40
       }
        sendSubviewToBack(selectedTagsScrollView)
    }
    
    private func getUnselectedCellsStackViewData() {
        if (DataStorage.shared.tagList == nil) {
            return
        }
        unselectedTagsStackView.arrangedSubviews
            .filter({ $0 is TagCell})
            .forEach({ $0.removeFromSuperview()})
        unselectedTagsStackView.frame = unselectedTagsScrollView.frame
        var cell: TagCell = TagCell()
        let tags = unselectedTagsCells
        let numberOfCells = tags.count
        if (numberOfCells == 0) {
            return
        }
        for i in 0...(numberOfCells-1) {
            cell = tags[i]
            unselectedTagsCells.append(cell)
        }

        var top = 5
        for i in 0...(numberOfCells-1) {
            cell = unselectedTagsCells[i]
            //cell.timeLabel.text = generator.randomTime()
            cell.layer.masksToBounds = true
            cell.translatesAutoresizingMaskIntoConstraints = false
            unselectedTagsStackView.addArrangedSubview(cell)
            unselectedTagsStackView.sendSubviewToBack(cell)


            // cell.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true

            // cell.setWidth(to: Double(stackView))
            cell.topAnchor.constraint(equalTo: unselectedTagsStackView.topAnchor, constant: CGFloat(top)).isActive = true
            cell.leadingAnchor.constraint(equalTo: unselectedTagsStackView.leadingAnchor, constant: 15).isActive = true
            cell.trailingAnchor.constraint(equalTo: unselectedTagsStackView.trailingAnchor, constant: -15).isActive = true
            //cell.setHeight(to: Double(stackView.frame.height) * 0.5)
            top += 40
       }
        sendSubviewToBack(unselectedTagsScrollView)
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
    
    @objc func didTapTag(sender: UIButton) {
        let title = sender.currentTitle
        var cell: TagCell
        if (sender.tag == 0) {
            cell = unselectedTagsCells.filter {
                $0.tagView.tagButton.currentTitle == title
            }.first!
            sender.tag = 1
        } else {
            cell = selectedTagsCells.filter {
                $0.tagView.tagButton.currentTitle == title
            }.first!
            sender.tag = 0
        }
        if (sender.tag == 1) {
            self.unselectedTagsStackView.removeArrangedSubview(cell)
            cell.removeFromSuperview()
            unselectedTagsCells = unselectedTagsCells.filter {
                $0.tagView.tagData.name != cell.tagView.tagData.name
            }
            selectedTagsCells.append(cell)
            getSelectedCellsStackViewData()
        } else {
            
        }
        sendSubviewToBack(self.unselectedTagsScrollView)
        sendSubviewToBack(self.unselectedTagsStackView)
        bringSubviewToFront(self.selectedTagsScrollView)
        bringSubviewToFront(self.selectedTagsStackView)
    }
}
