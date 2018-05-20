//
//  CharactersCollectionViewCell.swift
//  marvel-characters
//
//  Created by Luiza Collado Garofalo on 15/05/18.
//  Copyright © 2018 Luiza Garofalo. All rights reserved.
//

import RealmSwift
import UIKit

class CharactersCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var saveButton: UIButton!

    let realm = try! Realm() // swiftlint:disable:this force_try
    var favorites: Results<Favorite>?

    override func awakeFromNib() {
        super.awakeFromNib()
        favorites = realm.objects(Favorite.self)
    }

    @IBAction func saveCharacter(_ sender: UIButton) {

        let favorite = Favorite()
        favorite.name = characterName.text!

        if (favorites?.contains(where: { $0.name == favorite.name }))! {
            do {
                try realm.write {
                    let character = realm.objects(Favorite.self).filter("name = %@", favorite.name)
                    realm.delete(character)
                    saveButton.setImage(#imageLiteral(resourceName: "Favorites 01"), for: .normal)
                    print("Character removed from favorites.")
                }
            } catch {
                print("Error removing character from favorites: \(error)")
            }
        } else {

            do {
                try realm.write {
                    realm.add(favorite)
                    saveButton.setImage(#imageLiteral(resourceName: "Favorites 02"), for: .normal)
                    print("Character added to favorites.")
                }
            } catch {
                print("Error adding character to favorites: \(error).")
            }
        }
    }
}
