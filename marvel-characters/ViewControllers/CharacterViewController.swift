//
//  CharacterViewController.swift
//  marvel-characters
//
//  Created by Luiza Collado Garofalo on 15/05/18.
//  Copyright © 2018 Luiza Garofalo. All rights reserved.
//

import RealmSwift
import SDWebImage
import UIKit

class CharacterViewController: UIViewController {

    @IBOutlet weak var characterThumbnail: UIImageView!
    @IBOutlet weak var characterDescription: UITextView!
    @IBOutlet weak var comicsLabel: UILabel!
    @IBOutlet weak var seriesLabel: UILabel!
    @IBOutlet weak var comicsCollectionView: UICollectionView!
    @IBOutlet weak var seriesCollectionView: UICollectionView!
    @IBOutlet weak var errorMessageView: UIView!
    var saveButton: UIBarButtonItem!

    let realm = try! Realm() // swiftlint:disable:this force_try
    var favorites: Results<Favorite>?
    var requestsGateway: RequestsGateway!
    var id = 0

    var character: [Result] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                if self?.character[0].description != "" {
                    self?.characterDescription.text = self?.character[0].description
                } else {
                    self?.characterDescription.text = "No description available."
                }
                self?.characterThumbnail.sd_setImage(with: URL(string: (self?.character[0].thumbnail?.path)! + "." +
                    (self?.character[0].thumbnail?.thumbnailExtension)!.rawValue),
                                                     placeholderImage: UIImage(named: "iconPlaceholder"),
                                                     options: .highPriority, completed: nil)
            }
        }
    }

    var comics: [Result] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                if self?.comics.count != 0 {
                    self?.comicsLabel.isHidden = false
                    self?.comicsCollectionView.isHidden = false
                    self?.comicsCollectionView.reloadData()
                }
            }
        }
    }

    var series: [Result] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                if self?.series.count != 0 {
                    self?.seriesLabel.isHidden = false
                    self?.seriesCollectionView.isHidden = false
                    self?.seriesCollectionView.reloadData()
                }
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        setCollectionView()
        setUIBarButtonItem()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        favorites = realm.objects(Favorite.self)
        initialSetup()
    }

    func loadData() {
        requestsGateway.loadAll(ofType: .character(id), onComplete: updateCharacter)
        requestsGateway.loadAll(ofType: .comics(id), onComplete: updateComics)
        requestsGateway.loadAll(ofType: .series(id), onComplete: updateSeries)
    }

    func updateCharacter(response: Response<MarvelAPI>) {
        switch response {
        case .positive(let character):
            DispatchQueue.main.async {
                self.errorMessageView.isHidden = true
                self.character += character.data.results
            }
        case .negative(let error):
            DispatchQueue.main.async {
                self.errorMessageView.isHidden = false
                print(error)
            }
        }
    }

    func updateComics(response: Response<MarvelAPI>) {
        switch response {
        case .positive(let comics):
            self.comics += comics.data.results
        case .negative(let error):
            print(error)
        }
    }

    func updateSeries(response: Response<MarvelAPI>) {
        switch response {
        case .positive(let series):
            self.series += series.data.results
        case .negative(let error):
            print(error)
        }
    }

    @objc func saveCharacter(sender: UIBarButtonItem) {
        let favorite = Favorite()
        favorite.id = self.id
        favorite.name = self.title!
        favorite.thumbnail = (character[0].thumbnail?.path)! + "." +
            (character[0].thumbnail?.thumbnailExtension)!.rawValue

        if (favorites?.contains(where: { $0.name == favorite.name }))! {
            do {
                try realm.write {
                    let character = realm.objects(Favorite.self).filter("name = %@", favorite.name)
                    realm.delete(character)
                    saveButton.image = #imageLiteral(resourceName: "Favorites 01")
                    print("Character removed from favorites.")
                }
            } catch {
                print("Error removing character from favorites: \(error)")
            }
        } else {

            do {
                try realm.write {
                    realm.add(favorite)
                    saveButton.image = #imageLiteral(resourceName: "Favorites 02")
                    print("Character added to favorites.")
                }
            } catch {
                print("Error adding character to favorites: \(error).")
            }
        }
    }

    func setCollectionView() {
        comicsCollectionView.register(UINib(nibName: "ComicsCollectionViewCell", bundle: nil),
                                      forCellWithReuseIdentifier: "ComicsCell")
        seriesCollectionView.register(UINib(nibName: "SeriesCollectionViewCell", bundle: nil),
                                      forCellWithReuseIdentifier: "SeriesCell")

        let width = 175
        let comicsLayout = (comicsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout)!
        let seriesLayout = (seriesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout)!
        comicsLayout.itemSize = CGSize(width: width, height: width)
        seriesLayout.itemSize = CGSize(width: width, height: width)
    }

    func setUIBarButtonItem() {
        if (favorites?.contains(where: { $0.name == self.title }))! {
            saveButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Favorites 02"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(saveCharacter(sender:)))
        } else {
            saveButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Favorites 01"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(saveCharacter(sender:)))
        }

        self.navigationItem.rightBarButtonItem = saveButton
    }

    func initialSetup() {
        self.comicsLabel.isHidden = true
        self.seriesLabel.isHidden = true
        self.comicsCollectionView.isHidden = true
        self.seriesCollectionView.isHidden = true
        errorMessageView.isHidden = true
    }
}

extension CharacterViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.comicsCollectionView {
            return comics.count
        } else {
            return series.count
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView == self.comicsCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ComicsCell",
                                                                for: indexPath) as? ComicsCollectionViewCell else {
                                                                    return UICollectionViewCell()
            }

            cell.comicsName.text = comics[indexPath.row].title
            cell.comicsImage.sd_setImage(with: URL(string: (comics[indexPath.row].thumbnail?.path)! + "." +
                (comics[indexPath.row].thumbnail?.thumbnailExtension)!.rawValue),
                                         placeholderImage: UIImage(named: "iconPlaceholder"),
                                         options: .highPriority, completed: nil)

            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeriesCell",
                                                                for: indexPath) as? SeriesCollectionViewCell else {
                                                                    return UICollectionViewCell()
            }

            cell.seriesName.text = series[indexPath.row].title
            cell.seriesImage.sd_setImage(with: URL(string: (series[indexPath.row].thumbnail?.path)! + "." +
                (series[indexPath.row].thumbnail?.thumbnailExtension)!.rawValue),
                                         placeholderImage: UIImage(named: "iconPlaceholder"),
                                         options: .highPriority, completed: nil)

            return cell
        }
    }
}
