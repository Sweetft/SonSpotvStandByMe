//
//  UserDefaultsKeysProtocol.swift
//  SonSpotvStandByMe
//
//  Created by 허성진 on 2023/04/16.
//

import Foundation

protocol UserDefaultsKeysProtocol: CaseIterable {
    /**
     keyName앞에 접두사로 사용.(BundleID 사용)
     
     ex) dev.lucasheo.SonSpotvStandByMe
     */
    var prefix: String { get }
    
    /**
     키값으로 사용
     */
    var keyName: String { get }
}

extension UserDefaultsKeysProtocol {
    var prefix: String {
        Bundle.main.bundleIdentifier! + "."
    }
}
