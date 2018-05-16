//
//  CharactersMemoryGateway.swift
//  marvel-characters
//
//  Created by Luiza Collado Garofalo on 16/05/18.
//  Copyright © 2018 Luiza Garofalo. All rights reserved.
//

import Foundation

struct CharactersMemoryGateway: CharactersGateway {
    let characters: [Character] = [Character(id: 1011334, name: "3-D Man", description: "", thumbnail: Thumbnail(path: "Teste", thumbnailExtension: .gif)),
                                   Character(id: 1017100, name: "A-Bomb (HAS)", description: "Rick Jones has been Hulk's best bud since day one, but now he's more than a friend...he's a teammate!", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16", thumbnailExtension: .jpg)),
                                   Character(id: 1009144, name: "A.I.M.", description: "AIM is a terrorist organization bent on destroying the world.", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/6/20/52602f21f29ec", thumbnailExtension: .jpg)),
                                   Character(id: 1010699, name: "Aaron Stack", description: "", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available", thumbnailExtension: .jpg)),
                                   Character(id: 1011334, name: "3-D Man", description: "", thumbnail: Thumbnail(path: "Teste", thumbnailExtension: .gif)),
                                   Character(id: 1017100, name: "A-Bomb (HAS)", description: "Rick Jones has been Hulk's best bud since day one, but now he's more than a friend...he's a teammate!", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16", thumbnailExtension: .jpg)),
                                   Character(id: 1009144, name: "A.I.M.", description: "AIM is a terrorist organization bent on destroying the world.", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/6/20/52602f21f29ec", thumbnailExtension: .jpg)),
                                   Character(id: 1010699, name: "Aaron Stack", description: "", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available", thumbnailExtension: .jpg))]
    
    func allCharacters(onComplete: @escaping ([Character]) -> Void) {
        onComplete(characters)
    }
}
