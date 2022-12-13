//
//  User.swift
//  Final_Project
//
//  Created by Kanishk Bhatia on 12/5/22.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Identifiable, Codable {
    @DocumentID var id: String?
    var userId: String
    var firstName: String
    var lastName: String
    var email: String
}
