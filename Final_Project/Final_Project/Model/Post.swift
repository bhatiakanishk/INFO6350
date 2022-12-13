//
//  Post.swift
//  Final_Project
//
//  Created by Kanishk Bhatia on 12/5/22.
//

import Foundation
import FirebaseFirestoreSwift

struct Post: Identifiable, Codable {
    @DocumentID var id: String?
    var title: String
    var body: String
    var createdById: String
    var createdByName: String
    @ServerTimestamp var updateTime: Date? = nil
}
