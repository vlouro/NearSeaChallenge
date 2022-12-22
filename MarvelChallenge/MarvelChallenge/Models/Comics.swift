//
//  Comics.swift
//  MarvelChallenge
//
//  Created by Valter Louro on 18/12/2022.
//

import Foundation

// MARK: - Comics
struct Comics: Codable {
    let available: Int
    let collectionURI: String
    let items: [ComicsItem]
    let returned: Int
}

struct ComicsItem: Codable {
    let resourceURI: String
    let name: String
}



