//
//  Response.swift
//  marvel-characters
//
//  Created by Luiza Collado Garofalo on 18/05/18.
//  Copyright © 2018 Luiza Garofalo. All rights reserved.
//

import Foundation

enum Response<T> {
    case positive(T)
    case negative(Error)
}
