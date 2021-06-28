//
//  ContactInfoViewModel.swift
//  
//
//  Created by Jobert on 25/06/2021.
//

import Domain
import Foundation

public class ContactInfoViewModel: CallDetailsItemViewModel {
    let photo: Data?
    let name: String
    let location: String?

    init(_ call: Call) {
        name = call.from
        photo = nil
        location = nil
    }
}
