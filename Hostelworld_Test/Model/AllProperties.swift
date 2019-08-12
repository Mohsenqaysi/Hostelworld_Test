//
//  AllProperties.swift
//  Hostelworld_Test
//
//  Created by Mohsen Qaysi on 8/9/19.
//  Copyright © 2019 Mohsen Qaysi. All rights reserved.
//

import Foundation

// MARK: - Properties
struct Properties: Codable {
    let properties: [Property]
}

// MARK: - Property
struct Property: Codable {
    let id, name: String
    let city: City
    let latitude, longitude: String
    let type: String
    let images: [Image]
    let overallRating: OverallRating
}

// MARK: - City
struct City: Codable {
    let id: String
    let name: String
    let country: String
    let idCountry: String
}

// MARK: - Image
struct Image: Codable {
    let suffix: String
    let prefix: String
}

// MARK: - OverallRating
struct OverallRating: Codable {
    let overall: Int?
    let numberOfRatings: Int
}
