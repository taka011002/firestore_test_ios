//
//  LoginUser.swift
//  firestore_test
//
//  Created by Takahiro Ishitsuka  on 2019/05/01.
//  Copyright © 2019 Taka. All rights reserved.
//

import Foundation

class LoginUser {
    
    struct Item {
        var id: String
        var user: String

    }
    
    static var current = Item(id: "", user: "")
    
}
