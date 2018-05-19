//
//  CharacterViewController.swift
//  marvel-characters
//
//  Created by Luiza Collado Garofalo on 15/05/18.
//  Copyright © 2018 Luiza Garofalo. All rights reserved.
//

import UIKit

class CharacterViewController: UIViewController {

    @IBOutlet weak var characterThumbnail: UIImageView!
    @IBOutlet weak var characterDescription: UITextView!
    @IBOutlet weak var comicsCollectionView: UICollectionView!
    @IBOutlet weak var seriesCollectionView: UICollectionView!

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
        requestsGateway.loadComics(id: id, updateComics)
        requestsGateway.loadSeries(id: id, updateSeries)
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

            if let label = cell.viewWithTag(100) as? UILabel {
                label.text = comics[indexPath.row].title
            }

            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeriesCell",
                                                                for: indexPath) as? SeriesCollectionViewCell else {
                                                                    return UICollectionViewCell()
            }

            if let label = cell.viewWithTag(100) as? UILabel {
                label.text = series[indexPath.row].title
            }

            return cell
        }
    }
}
