//
//  Character.swift
//  MarvelChallenge
//
//  Created by Valter Louro on 18/12/2022.
//

import Foundation

typealias CharactersList = [Character]

// MARK: - Character Api Response
struct MarvelApiResponse: Decodable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: MarvelApiData
}

struct MarvelApiData: Decodable {
    let offset, limit, total, count: Int
    let results: [Character]
}

struct Character: Codable {
    let id: Int
    let name, resultDescription: String
    let modified: String
    let thumbnail: CharacterThumbnail
    let resourceURI: String
    let comics, series: Comics
    let stories: Stories
    let events: Comics
    let urls: [URLElement]
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case resultDescription = "description"
        case modified, thumbnail, resourceURI, comics, series, stories, events, urls
    }
}
