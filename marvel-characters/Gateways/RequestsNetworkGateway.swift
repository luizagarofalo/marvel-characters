//
//  RequestsNetworkGateway.swift
//  marvel-characters
//
//  Created by Luiza Collado Garofalo on 15/05/18.
//  Copyright © 2018 Luiza Garofalo. All rights reserved.
//

import Foundation

struct RequestsNetworkGateway: RequestsGateway {

    let ts = 1
    let publicKey = "cd474e2e09099fd47b15c4f50c28e30d"
    let privateKey = "f8ba8e7d55cb57727b02bcb70174555c24fe24c4"

    var hash: String {
        let combined = "\(ts)\(privateKey)\(publicKey)"
        let md5Data = MD5(string: combined)
        let md5Hex =  md5Data.map { String(format: "%02hhx", $0) }.joined()

        return md5Hex
    }

    func MD5(string: String) -> Data {
        let messageData = string.data(using:.utf8)!
        var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))

        _ = digestData.withUnsafeMutableBytes {digestBytes in
            messageData.withUnsafeBytes {messageBytes in
                CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
            }
        }

        return digestData
    }

    func loadCharacters(_ onComplete: @escaping ([Result]) -> Void) {
        guard let url = URL(string: "https://gateway.marvel.com:443/v1/public/characters?apikey=" +
            "\(publicKey)&hash=\(hash)&ts=\(ts)") else { return }
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error)
                return
            }

            guard let data = data else { return }

            do {
                let characters = try JSONDecoder().decode(MarvelAPI.self, from: data)
                onComplete(characters.data.results)
            } catch {
                print("Error: \(error)")
            }
        }
        task.resume()
    }

    func loadCharacter(id: Int, _ onComplete: @escaping ([Result]) -> Void) {
        guard let url = URL(string: "https://gateway.marvel.com:443/v1/public/characters/\(id)?apikey=" +
            "\(publicKey)&hash=\(hash)&ts=\(ts)") else { return }
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error)
                return
            }

            guard let data = data else { return }

            do {
                let character = try JSONDecoder().decode(MarvelAPI.self, from: data)
                onComplete(character.data.results)
            } catch {
                print("Error: \(error)")
            }
        }
        task.resume()
    }

    func loadComics(id: Int, _ onComplete: @escaping ([Result]) -> Void) {
        guard let url = URL(string: "https://gateway.marvel.com:443/v1/public/characters/\(id)/comics?apikey=" +
            "\(publicKey)&hash=\(hash)&ts=\(ts)") else { return }
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error)
                return
            }

            guard let data = data else { return }

            do {
                let comics = try JSONDecoder().decode(MarvelAPI.self, from: data)
                onComplete(comics.data.results)
            } catch {
                print("Error: \(error)")
            }
        }
        task.resume()
    }

    func loadSeries(id: Int, _ onComplete: @escaping ([Result]) -> Void) {
        guard let url = URL(string: "https://gateway.marvel.com:443/v1/public/characters/\(id)/series?apikey=" +
            "\(publicKey)&hash=\(hash)&ts=\(ts)") else { return }
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error)
                return
            }

            guard let data = data else { return }

            do {
                let series = try JSONDecoder().decode(MarvelAPI.self, from: data)
                onComplete(series.data.results)
            } catch {
                print("Error: \(error)")
            }
        }
        task.resume()
    }
}
