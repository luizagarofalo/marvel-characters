//
//  Character.swift
//  marvel-characters
//
//  Created by Luiza Collado Garofalo on 15/05/18.
//  Copyright © 2018 Luiza Garofalo. All rights reserved.
//

import Foundation

struct Character: Decodable {
    let id: Int?
    let name, description: String?
    let thumbnail: Thumbnail?
}
