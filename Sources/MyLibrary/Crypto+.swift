//
//  Crypto.swift
//  
//
//  Created by 張家豪 on 2023/11/23.
//

import Foundation
import CryptoKit

extension MyLibrary {
    public struct Crypto {
        ///加密 : AES
        func encryptLicensePlate(licensePlate: [[String: String]], key: String) throws -> Data? {
            var inputData = try PropertyListSerialization.data(fromPropertyList: licensePlate, format: .binary, options: 0)
            let symmetricKey = SymmetricKey(data: Data(key.utf8))
            let sealedBox = try AES.GCM.seal(inputData, using: symmetricKey)
            let sealedData = sealedBox.combined
            return sealedData ?? Data()
        }
        
        ///解密 : AES
        func decryptLicensePlate(encryptedData: Data, key: String) throws -> [[String: String]]? {
            let symmetricKey = SymmetricKey(data: Data(key.utf8))
            let sealedBox = try AES.GCM.SealedBox(combined: encryptedData)
            let decryptedData = try AES.GCM.open(sealedBox, using: symmetricKey)
            let decrypted = try PropertyListSerialization.propertyList(from: decryptedData, options: [], format: nil) as? [[String: String]]
            return decrypted
        }
    }
}
