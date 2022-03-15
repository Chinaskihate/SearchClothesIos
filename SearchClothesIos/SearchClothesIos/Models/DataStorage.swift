//
//  DataStorage.swift
//  SearchClothesIos
//
//  Created by user211270 on 3/14/22.
//

import Foundation

class DataStorage {
    public var user: User?
    public var postList: PostList?
    public var registrationResult: Int?
    public var tagList: TagList?
    public var createTagResult: Bool?
    public var ratePostResult: Bool?
    
    static var shared: DataStorage = {
        let instance = DataStorage()
        // setup object
        return instance
    }()
    
    private init() {}
}
