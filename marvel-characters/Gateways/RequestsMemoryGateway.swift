//
//  CharactersMemoryGateway.swift
//  marvel-characters
//
//  Created by Luiza Collado Garofalo on 16/05/18.
//  Copyright © 2018 Luiza Garofalo. All rights reserved.
//

import Foundation

struct RequestsMemoryGateway: RequestsGateway {

    // swiftlint:disable line_length
    let characters = [Result(id: 1011334, digitalID: nil, name: "3-D Man", description: "", title: nil, thumbnail: Thumbnail(path: "Teste", thumbnailExtension: .gif)),
                      Result(id: 1017100, digitalID: nil, name: "A-Bomb (HAS)", description: "Rick Jones has been Hulk's best bud since day one, but now he's more than a friend...he's a teammate!", title: nil, thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16", thumbnailExtension: .jpg)),
                      Result(id: 1009144, digitalID: nil, name: "A.I.M.", description: "AIM is a terrorist organization bent on destroying the world.", title: nil, thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/6/20/52602f21f29ec", thumbnailExtension: .jpg)),
                      Result(id: 1010699, digitalID: nil, name: "Aaron Stack", description: "", title: nil, thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available", thumbnailExtension: .jpg))]
    // swiftlint:enable line_length

    func loadCharacters(_ onComplete: @escaping ([Result]) -> Void) {
        onComplete(characters)
    }

    func loadComics(id: Int, _ onComplete: @escaping ([Result]) -> Void) {
        onComplete(characters)
    }
}
