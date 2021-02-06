//
//  SessionSingletone.swift
//  geekbrains-vkapp
//
//  Created by David Dakhovich on 06/02/2021.
//

import Foundation

class UserSession {
    
    let shared = UserSession()
    
    var userId: Int = 0
    var token: String = ""
    
    private init() {}
}
