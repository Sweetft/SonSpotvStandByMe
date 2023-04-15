//
//  UserDefaultsManager.swift
//  UserDefaultsKeys
//
//  Created by Heo on 2023/03/15.
//

import Foundation

enum UserDefaultsKeys: String, UserDefaultsKeysProtocol {
    /**
     dev.lucasheo.SonSpotvStandByMe.phoneNumber
     */
    case phoneNumber
    
    var keyName: String {
        self.prefix + self.rawValue
    }
}
