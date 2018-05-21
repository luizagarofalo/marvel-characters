//
//  RequestsGateway.swift
//  marvel-characters
//
//  Created by Luiza Collado Garofalo on 15/05/18.
//  Copyright © 2018 Luiza Garofalo. All rights reserved.
//

import Foundation

protocol RequestsGateway {
    func loadCharacters(limit: Int, offset: Int, _ onComplete: @escaping ([Result]) -> Void)
    func loadCharacter(id: Int, _ onComplete: @escaping ([Result]) -> Void)
    func loadComics(id: Int, _ onComplete: @escaping ([Result]) -> Void)
    func loadSeries(id: Int, _ onComplete: @escaping ([Result]) -> Void)
}
