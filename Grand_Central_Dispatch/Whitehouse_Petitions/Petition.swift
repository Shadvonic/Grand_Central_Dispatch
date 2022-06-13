//
//  Petition.swift
//  Whitehouse_Petitions
//
//  Created by Marc Moxey on 5/25/22.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
