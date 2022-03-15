// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

struct User: Codable {
    let id, token, username, email: String
    let createdPosts, ratedPosts: PostList
}

// MARK: - PostList
struct PostList: Codable {
    let posts: [Post]
}

// MARK: - Post
struct Post: Codable {
    let id, creatorID, title, sellerLink: String
    let postDescription, lastEditTime: String
    let rate: Int
    let tags: [Tag]

    enum CodingKeys: String, CodingKey {
        case id
        case creatorID = "creatorId"
        case title, sellerLink
        case postDescription = "description"
        case lastEditTime, rate, tags
    }
}

struct TagList: Codable {
    let tags: [Tag]
}

// MARK: - Tag
struct Tag: Codable {
    let id, creatorID, name: String

    enum CodingKeys: String, CodingKey {
        case id
        case creatorID = "creatorId"
        case name
    }
}
