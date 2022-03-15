//
//  RatePostDto.swift
//  SearchClothesIos
//
//  Created by user211270 on 3/15/22.
//

struct RatePostDto: Encodable {
    var token: String?;
    var postId: String?;
    var rate: Int?;
}
