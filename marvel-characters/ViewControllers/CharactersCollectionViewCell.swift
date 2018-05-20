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

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func saveCharacter(_ sender: UIButton) {

        let favorite = Favorite()
        favorite.name = characterName.text!

        do {
            try realm.write {
                realm.add(favorite)
                print("Character added.")
            }
        } catch {
            print("Error saving character: \(error).")
        }

        saveButton.setImage(#imageLiteral(resourceName: "Favorites 02"), for: .normal)
    }
}
