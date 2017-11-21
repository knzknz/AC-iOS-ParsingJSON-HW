//
//  Contact.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/18/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
struct Contacts: Codable {
        let results: [Person]
    }

struct Person: Codable {
        let gender: String
        let name: NameWrapper
        let location: LocationWrapper
        let email: String
        let picture: PictureWrapper
        let cell: String
    }

struct NameWrapper: Codable {
        let first: String
        let last: String
    }

struct LocationWrapper: Codable {
        let street: String
        let city: String
        let state: String
    
    }

struct PictureWrapper: Codable {
        let thumbnail: String
        let medium: String
        let large: String
    }








