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

        favorites = realm.objects(Favorite.self)
        favoritesCollectionView.register(UINib(nibName: "CharactersCollectionViewCell", bundle: nil),
                                         forCellWithReuseIdentifier: "CharactersCell")

        let width = (view.frame.size.width - 50) / 2
        let layout = (favoritesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout)!
        layout.itemSize = CGSize(width: width, height: width)
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
        cell.characterName.text = favorites?[indexPath.row].name
        cell.characterImage.sd_setImage(with: URL(string: (favorites?[indexPath.row].thumbnail)!),
                                        placeholderImage: UIImage(named: "iconPlaceholder"),
                                        options: .highPriority, completed: nil)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let character = self.favorites![indexPath.row]
        print("\(character.name) e \(character.id)")
        self.performSegue(withIdentifier: "showCharacter", sender: character)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let characterViewController = segue.destination as? CharacterViewController {
            if let character = sender as? Favorite {
                characterViewController.title = character.name
                characterViewController.id = character.id
                characterViewController.requestsGateway = RequestsNetworkGateway()
                characterViewController.loadData()
            }
        }
    }
}
