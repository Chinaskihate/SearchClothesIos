//
//  DataStorage.swift
//  SearchClothesIos
//
//  Created by user211270 on 3/14/22.
//

import Foundation

class DataStorage {
    public var user: User?
    public var posts: PostList?
    
    static var shared: DataStorage = {
        let instance = DataStorage()
        // setup object
        return instance
    }()
    
    private init() {}
}
