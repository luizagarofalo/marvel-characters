//
//  MarvelAPI.swift
//  marvel-characters
//
//  Created by Luiza Collado Garofalo on 16/05/18.
//  Copyright © 2018 Luiza Garofalo. All rights reserved.
//

import Foundation

struct MarvelAPI<T: Decodable>: Decodable {
    let data: DataClass<T>
}
