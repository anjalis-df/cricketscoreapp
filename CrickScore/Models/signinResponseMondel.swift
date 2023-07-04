//
//  singInDataModel.swift
//  CrickScore
//
//  Created by support on 08/05/23.
//

import Foundation
struct signinResponseMondel: Codable {
    let message: String?
    let userDetail: userDetails?
}
struct userDetails: Codable {
    let _id: String?
    let userFullName: String?
    let userEmail: String?
    let userPassword: String?
    let __v: Int?
}
