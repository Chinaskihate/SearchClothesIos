//
//  RegisterDto.swift
//  SearchClothesIos
//
//  Created by user211270 on 3/15/22.
//

struct RegisterCommandDto: Encodable {
    var email: String?;
    var username: String?;
    var password: String?;
}
