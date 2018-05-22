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
    @IBOutlet weak var errorMessageView: UIView!

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
        errorMessageView.isHidden = true
        setCollectionView()
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
