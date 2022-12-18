//
//  CharacterThumbnail.swift
//  MarvelChallenge
//
//  Created by Valter Louro on 18/12/2022.
//

import Foundation

struct CharacterThumbnail: Codable {
    let path: String
    let thumbnailExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}
