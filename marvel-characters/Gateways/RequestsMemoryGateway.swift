//
//  CharactersMemoryGateway.swift
//  marvel-characters
//
//  Created by Luiza Collado Garofalo on 16/05/18.
//  Copyright © 2018 Luiza Garofalo. All rights reserved.
//

import Foundation

// Dummy data - swiftlint:disable line_length
struct RequestsMemoryGateway: RequestsGateway {

    let characters = [Result(id: 1011334, digitalID: nil, name: "3-D Man", description: "", title: nil, thumbnail: Thumbnail(path: "Teste", thumbnailExtension: .gif)),
                      Result(id: 1017100, digitalID: nil, name: "A-Bomb (HAS)", description: "Rick Jones has been Hulk's best bud since day one, but now he's more than a friend...he's a teammate!", title: nil, thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16", thumbnailExtension: .jpg)),
                      Result(id: 1009144, digitalID: nil, name: "A.I.M.", description: "AIM is a terrorist organization bent on destroying the world.", title: nil, thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/6/20/52602f21f29ec", thumbnailExtension: .jpg)),
                      Result(id: 1010699, digitalID: nil, name: "Aaron Stack", description: "", title: nil, thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available", thumbnailExtension: .jpg))]

    let comics = [Result(id: 22506, digitalID: 10949, name: nil, description: "Join 3-D MAN, CLOUD 9, KOMODO, HARDBALL, and heroes around America in the battle that will decide the fate of the planet and the future of the Initiative program. Will the Kill Krew Army win the day?", title: "Avengers: The Initiative (2007) #19", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/d/03/58dd080719806", thumbnailExtension: .jpg)),
                  Result(id: 22299, digitalID: 10948, name: nil, description: "Now that the Kill Krew knows Skrullowjacket's master plan, can they stop the true mission of the Fifty State Initiative? Plus, Thor Girl vs. Ultra Girl! One is more than she appears to be and the other's a Skrull!", title: "Avengers: The Initiative (2007) #18", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/6/20/58dd057d304d1", thumbnailExtension: .jpg))]

    let series = [Result(id: 1945, digitalID: nil, name: nil, description: nil, title: "Avengers: The Initiative (2007 - 2010)", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/5/a0/514a2ed3302f5", thumbnailExtension: .jpg)),
                  Result(id: 2005, digitalID: nil, name: nil, description: "Wade Wilson: Heartless Merc With a Mouth or...hero? Laugh, cry and applaud at full volume for the mind-bending adventures of Deadpool, exploring the psyche and crazed adventures of Marvel's most unstable personality!", title: "Deadpool (1997 - 2002)", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/7/03/5130f646465e3", thumbnailExtension: .jpg))]

    func loadCharacters(_ onComplete: @escaping ([Result]) -> Void) {
        onComplete(characters)
    }

    func loadComics(id: Int, _ onComplete: @escaping ([Result]) -> Void) {
        onComplete(comics)
    }

    func loadSeries(id: Int, _ onComplete: @escaping ([Result]) -> Void) {
        onComplete(series)
    }
}
