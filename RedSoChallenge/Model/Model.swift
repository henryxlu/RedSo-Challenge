//
//  Model.swift
//  RedSoChallenge
//
//  Created by Henry on 2019/11/1.
//  Copyright © 2019 Henry. All rights reserved.
//

import Foundation




struct Staff: Codable {
    let results: [Result]
    
    struct Result: Codable {
        let id: String?
        let type: String
        let name, position: String?
        let expertise: [String]?
        let avatar: String?
        let url: String?
    }
}

