//
//  Post.swift
//  Final_Project
//
//  Created by Kanishk Bhatia on 12/5/22.
//

import Foundation

struct Post: Identifiable, Codable {
    var id: String?
    var title: String
    var body: String
    var createdById: String
    var createdByName: String
    var updateTime: Date? = nil
}
