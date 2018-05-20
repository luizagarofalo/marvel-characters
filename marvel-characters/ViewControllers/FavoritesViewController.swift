//
//  FavoritesViewController.swift
//  marvel-characters
//
//  Created by Luiza Collado Garofalo on 15/05/18.
//  Copyright © 2018 Luiza Garofalo. All rights reserved.
//

import RealmSwift
import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var favoritesCollectionView: UICollectionView!

    let realm = try! Realm() // swiftlint:disable:this force_try
    var favorites: Results<Favorite>?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoritesCollectionView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        favoritesCollectionView.register(UINib(nibName: "CharactersCollectionViewCell", bundle: nil),
                                          forCellWithReuseIdentifier: "CharactersCell")

        let width = (view.frame.size.width - 50) / 2
        let layout = (favoritesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout)!
        layout.itemSize = CGSize(width: width, height: width)

        favorites = realm.objects(Favorite.self)
    }
}

extension FavoritesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favorites?.count ?? 1
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharactersCell",
                                                            for: indexPath) as? CharactersCollectionViewCell else {
                                                                return UICollectionViewCell()
        }

        cell.saveButton.setImage(#imageLiteral(resourceName: "Favorites 02"), for: .normal)

        if let label = cell.viewWithTag(100) as? UILabel {
            label.text = favorites?[indexPath.row].name
        }

        return cell
    }
}
