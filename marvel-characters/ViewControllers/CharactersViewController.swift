//
//  CharactersViewController.swift
//  marvel-characters
//
//  Created by Luiza Collado Garofalo on 15/05/18.
//  Copyright © 2018 Luiza Garofalo. All rights reserved.
//

import RealmSwift
import SDWebImage
import UIKit

class CharactersViewController: UIViewController {

    @IBOutlet weak var charactersCollectionView: UICollectionView!

    let realm = try! Realm() // swiftlint:disable:this force_try

    var characters: [Result] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.charactersCollectionView.reloadData()
            }
        }
    }

    var favorites: Results<Favorite>?
    var requestsGateway = RequestsNetworkGateway()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        charactersCollectionView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        charactersCollectionView.register(UINib(nibName: "CharactersCollectionViewCell", bundle: nil),
                                          forCellWithReuseIdentifier: "CharactersCell")

        let width = (view.frame.size.width - 50) / 2
        let layout = (charactersCollectionView.collectionViewLayout as? UICollectionViewFlowLayout)!
        layout.itemSize = CGSize(width: width, height: width)

        favorites = realm.objects(Favorite.self)
        loadData()
    }

    func loadData() {
        requestsGateway.loadCharacters(updateCharacters)
    }

    func updateCharacters(characters: [Result]) {
        self.characters = characters
    }
}

extension CharactersViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharactersCell",
                                                            for: indexPath) as? CharactersCollectionViewCell else {
                                                                return UICollectionViewCell()
        }

        cell.characterName.text = characters[indexPath.row].name
        cell.characterImage.sd_setImage(with: URL(string: (characters[indexPath.row].thumbnail?.path)! + "." + (characters[indexPath.row].thumbnail?.thumbnailExtension)!.rawValue), placeholderImage: UIImage(named: "iconPlaceholder"), options: .highPriority, completed: nil) // swiftlint:disable:this line_length

        if (favorites?.contains(where: { $0.name == characters[indexPath.row].name }))! {
            cell.saveButton.setImage(#imageLiteral(resourceName: "Favorites 02"), for: .normal)
        } else {
            cell.saveButton.setImage(#imageLiteral(resourceName: "Favorites 01"), for: .normal)
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let character = self.characters[indexPath.row]
        self.performSegue(withIdentifier: "showCharacter", sender: character)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let characterViewController = segue.destination as? CharacterViewController {
            if let character = sender as? Result {
                characterViewController.title = character.name!
                characterViewController.id = character.id!
                characterViewController.requestsGateway = RequestsNetworkGateway()
                characterViewController.loadData()
            }
        }
    }
}
