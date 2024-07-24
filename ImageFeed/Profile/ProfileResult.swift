//
//  ProfileResult.swift
//  ImageFeed
//
//  Created by Дмитрий Мартынцов on 18.07.2024.
//

import Foundation

struct ProfileResult: Decodable {
    let username: String
    let firstName: String
    let lastName: String?
    let bio: String?
}
