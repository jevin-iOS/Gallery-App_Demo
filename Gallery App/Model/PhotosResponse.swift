//
//  PhotosResponse.swift
//  Gallery App
//
//  Created by jevin kamani on 16/03/24.
//

import Foundation

typealias PhotosResponse = [PhotosDetails]

struct PhotosDetails: Codable {
    let id: String
    let createdAt: String
    let altDescription: String
    let urls: Urls
    let likes: Int

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case altDescription = "alt_description"
        case urls, likes
    }
}

// MARK: - Urls
struct Urls: Codable {
    let regular: String
}


