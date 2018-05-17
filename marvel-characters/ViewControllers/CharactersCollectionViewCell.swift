//
//  CharactersCollectionViewCell.swift
//  marvel-characters
//
//  Created by Luiza Collado Garofalo on 15/05/18.
//  Copyright © 2018 Luiza Garofalo. All rights reserved.
//

import UIKit

class CharactersCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func saveCharacter(_ sender: UIButton) {
    }
}
