//
//  CharacterViewController.swift
//  marvel-characters
//
//  Created by Luiza Collado Garofalo on 15/05/18.
//  Copyright © 2018 Luiza Garofalo. All rights reserved.
//

import SDWebImage
import UIKit

class CharacterViewController: UIViewController {

    @IBOutlet weak var characterThumbnail: UIImageView!
    @IBOutlet weak var characterDescription: UITextView!
    @IBOutlet weak var comicsCollectionView: UICollectionView!
    @IBOutlet weak var seriesCollectionView: UICollectionView!

    var character: [Result] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                if self?.character[0].description != "" {
                    self?.characterDescription.text = self?.character[0].description
                } else {
                    self?.characterDescription.text = "No description available."
                }
                self?.characterThumbnail.sd_setImage(with: URL(string: (self?.character[0].thumbnail?.path)! + "." + (self?.character[0].thumbnail?.thumbnailExtension)!.rawValue), placeholderImage: UIImage(named: "iconPlaceholder"), options: .highPriority, completed: nil) // swiftlint:disable:this line_length
            }
        }
    }

    var comics: [Result] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.comicsCollectionView.reloadData()
            }
        }
    }

    var series: [Result] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.seriesCollectionView.reloadData()
            }
        }
    }

    var id = 0
    var requestsGateway: RequestsGateway!

    override func viewDidLoad() {
        super.viewDidLoad()

        comicsCollectionView.register(UINib(nibName: "ComicsCollectionViewCell", bundle: nil),
                                      forCellWithReuseIdentifier: "ComicsCell")
        seriesCollectionView.register(UINib(nibName: "SeriesCollectionViewCell", bundle: nil),
                                      forCellWithReuseIdentifier: "SeriesCell")

        let width = 175
        let comicsLayout = (comicsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout)!
        comicsLayout.itemSize = CGSize(width: width, height: width)
        let seriesLayout = (seriesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout)!
        seriesLayout.itemSize = CGSize(width: width, height: width)
    }

    func loadData() {
        requestsGateway.loadCharacter(id: id, updateCharacter)
        requestsGateway.loadComics(id: id, updateComics)
        requestsGateway.loadSeries(id: id, updateSeries)
    }

    func updateCharacter(with results: [Result]) {
        self.character = results
    }

    func updateComics(with results: [Result]) {
        self.comics = results
    }

    func updateSeries(with results: [Result]) {
        self.series = results
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
            cell.comicsImage.sd_setImage(with: URL(string: (comics[indexPath.row].thumbnail?.path)! + "." + (comics[indexPath.row].thumbnail?.thumbnailExtension)!.rawValue), placeholderImage: UIImage(named: "iconPlaceholder"), options: .highPriority, completed: nil) // swiftlint:disable:this line_length

            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeriesCell",
                                                                for: indexPath) as? SeriesCollectionViewCell else {
                                                                    return UICollectionViewCell()
            }

            cell.seriesName.text = series[indexPath.row].title
            cell.seriesImage.sd_setImage(with: URL(string: (series[indexPath.row].thumbnail?.path)! + "." + (series[indexPath.row].thumbnail?.thumbnailExtension)!.rawValue), placeholderImage: UIImage(named: "iconPlaceholder"), options: .highPriority, completed: nil) // swiftlint:disable:this line_length

            return cell
        }
    }
}
