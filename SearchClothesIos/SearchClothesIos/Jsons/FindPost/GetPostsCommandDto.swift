//
//  GetPostsCommandDto.swift
//  SearchClothesIos
//
//  Created by user211270 on 3/14/22.
//

import Foundation

struct GetPostsCommandDto: Encodable {
    var token: String?;
    var title: String?;
    var tags: [Tag]?;
    var minRate: Int;
}
