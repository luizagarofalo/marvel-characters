//
//  DataClass.swift
//  marvel-characters
//
//  Created by Luiza Collado Garofalo on 16/05/18.
//  Copyright © 2018 Luiza Garofalo. All rights reserved.
//

import Foundation

struct DataClass<T: Decodable>: Decodable {
    let items: [T]

    enum CodingKeys: String, CodingKey {
        case items = "results"
    }
}
