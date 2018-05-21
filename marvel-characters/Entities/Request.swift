//
//  Request.swift
//  marvel-characters
//
//  Created by Luiza Collado Garofalo on 21/05/18.
//  Copyright © 2018 Luiza Garofalo. All rights reserved.
//

import Foundation

enum Request {
    case character(Int)
    case characters(Int, Int)
    case comics(Int)
    case series(Int)
}
