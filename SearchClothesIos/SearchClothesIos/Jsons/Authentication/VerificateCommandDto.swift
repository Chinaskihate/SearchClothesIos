//
//  VerificateCommandDto.swift
//  SearchClothesIos
//
//  Created by user211270 on 3/15/22.
//

import Foundation

struct VerificateCommandDto: Encodable {
    var email: String?;
    var verificationCode: String?;
}
