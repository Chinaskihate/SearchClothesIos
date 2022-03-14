//
//  LoginPost.swift
//  SearchClothesIos
//
//  Created by user211270 on 3/13/22.
//

import Foundation

struct LoginCommandDto: Encodable {
    var email: String?;
    var password: String?;
}
