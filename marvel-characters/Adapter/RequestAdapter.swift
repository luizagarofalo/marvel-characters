//
//  RequestAdapter.swift
//  marvel-characters
//
//  Created by Luiza Collado Garofalo on 21/05/18.
//  Copyright © 2018 Luiza Garofalo. All rights reserved.
//

import Foundation
import UIKit

class RequestAdapter {
    static func request<T: Decodable>(_ url: URL, _ onComplete: @escaping (Response<T>) -> Void) {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: url) { (data, _, requestError) in
            if let requestError = requestError {
                return onComplete(.negative(requestError))
            }

            guard let data = data else { return }

            do {
                let response = try JSONDecoder().decode(T.self, from: data)
                onComplete(.positive(response))
            } catch {
                onComplete(.negative(error))
            }
        }
        task.resume()
    }
}
