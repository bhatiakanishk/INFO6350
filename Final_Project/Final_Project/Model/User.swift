//
//  User.swift
//  Final_Project
//
//  Created by Raj Kalpesh Mehta on 12/5/22.
//

import Foundation

struct User: Identifiable, Codable {
    var id: String?
    var userId: String
    var firstName: String
    var lastName: String
    var email: String
}