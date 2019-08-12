//
//  Hostel.swift
//  Hostelworld_Test
//
//  Created by Mohsen Qaysi on 8/9/19.
//  Copyright © 2019 Mohsen Qaysi. All rights reserved.
//

import Foundation

// MARK: - Hostel
struct Hostel: Codable {
    let id, name: String?
    let rating: Rating?
    let description, latitude, longitude: String?
    let address1, address2, directions: String?
    let city: City?
    let paymentMethods, policies: [String]?
    let totalRatings: String?
    let images: [Image]?
    let type: String?
    let depositPercentage: Int?
//    let checkIn: CheckIn?
}

// MARK: - CheckIn
struct CheckIn: Codable {
    let startsAt: String?
    let endsAt: Int?
}

// MARK: - Rating
struct Rating: Codable {
    let overall, atmosphere, cleanliness, facilities: Int?
    let staff, security, location, valueForMoney: Int?
}
