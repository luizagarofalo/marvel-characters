//
//  Comic.swift
//  marvel-characters
//
//  Created by Luiza Collado Garofalo on 22/05/18.
//  Copyright © 2018 Luiza Garofalo. All rights reserved.
//

import Foundation

struct Comic: Decodable {
    let id: Int
    let digitalID: Int?
    let name, description, title: String?
    let thumbnail: Thumbnail?

    enum CodingKeys: String, CodingKey {
        case digitalID = "digitalId"
        case description, id, name, title, thumbnail
    }
}
