//
//  CharactersGateway.swift
//  marvel-characters
//
//  Created by Luiza Collado Garofalo on 15/05/18.
//  Copyright © 2018 Luiza Garofalo. All rights reserved.
//

import Foundation

protocol CharactersGateway {
    func allCharacters(onComplete: @escaping ([Character]) -> Void)
}
