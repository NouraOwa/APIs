//
//  StatusExtension.swift
//  APIExample
//
//  Created by Noura Alowayid on 12/11/1444 AH.
//

import Foundation
func isSuccessful(response: HTTPURLResponse) -> Bool {
    guard response.statusCode >= 200 && response.statusCode < 300 else {
        print("Status code is not in the 200s")
        return false
    }
    print("Status code is in the 200s")
    return true
}
