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

    let comics = ["Comics 01", "Comics 02", "Comics 03", "Comics 04"]
    let series = ["Series 01", "Series 02", "Series 03", "Series 04", "Series 05", "Series 06"]

    var characterName = ""
    var requestsGateway = RequestsNetworkGateway()

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
}

extension CharacterViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comics.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView == self.comicsCollectionView {

            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ComicsCell",
                                                                for: indexPath) as? ComicsCollectionViewCell else {
                                                                    return UICollectionViewCell()
            }

            if let label = cell.viewWithTag(100) as? UILabel {
                label.text = comics[indexPath.row]
            }

            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeriesCell",
                                                                for: indexPath) as? SeriesCollectionViewCell else {
                                                                    return UICollectionViewCell()
            }

            if let label = cell.viewWithTag(100) as? UILabel {
                label.text = series[indexPath.row]
            }

            return cell
        }
    }
}
