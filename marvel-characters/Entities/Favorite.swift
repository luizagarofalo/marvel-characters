//
//  Favorite.swift
//  marvel-characters
//
//  Created by Luiza Collado Garofalo on 19/05/18.
//  Copyright © 2018 Luiza Garofalo. All rights reserved.
//

import Foundation
import RealmSwift

class Favorite: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var thumbnail = ""
}
