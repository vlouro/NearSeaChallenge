//
//  Character.swift
//  MarvelChallenge
//
//  Created by Valter Louro on 18/12/2022.
//

import Foundation

struct Character: Codable {
    let id: Int
    let name, resultDescription: String
    let modified: Date
    let thumbnail: CharacterThumbnail
    let resourceURI: String
    let comics, series: Comics
    let stories: Stories
    let events: Comics
    let urls: [URLElement]

    enum CodingKeys: String, CodingKey {
        case id, name
        case resultDescription = "description"
        case thumbnail = "thumbnail"
        case modified, resourceURI, comics, series, stories, events, urls
    }
}
