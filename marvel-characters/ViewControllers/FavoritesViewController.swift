//
//  FavoritesViewController.swift
//  marvel-characters
//
//  Created by Luiza Collado Garofalo on 15/05/18.
//  Copyright © 2018 Luiza Garofalo. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var favoritesCollectionView: UICollectionView!

    var favorites = ["Favorite 01", "Favorite 02", "Favorite 03", "Favorite 04"]

    override func viewDidLoad() {
        super.viewDidLoad()

        favoritesCollectionView.register(UINib(nibName: "CharactersCollectionViewCell", bundle: nil),
                                          forCellWithReuseIdentifier: "CharactersCell")

        let width = (view.frame.size.width - 50) / 2
        let layout = (favoritesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout)!
        layout.itemSize = CGSize(width: width, height: width)
    }
}

extension FavoritesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favorites.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharactersCell",
                                                            for: indexPath) as? CharactersCollectionViewCell else {
                                                                return UICollectionViewCell()
        }

        if let label = cell.viewWithTag(100) as? UILabel {
            label.text = favorites[indexPath.row]
        }

        return cell
    }
}
