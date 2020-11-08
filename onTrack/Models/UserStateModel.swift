//
//  UserStateModel.swift
//  onTrack
//
//  Created by Elena Sadler on 11/8/20.
//

import Foundation
import Firebase
import FirebaseFirestore
import UIKit

//Track Structure
public struct TrackModel: Codable {
    let trackName: String
    let timeInvested: Double
    let createdTasksDict: [String: Double]
    let completedTasksDict: [String:Double]
    var dictionary: [String: Any] {
            let data = (try? JSONEncoder().encode(self)) ?? Data()
            return (try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]) ?? [:]
        }
    
    enum CodingKeys: String, CodingKey {
        case trackName
        case timeInvested
        case createdTasksDict
        case completedTasksDict
    }
}


//User structure

public struct UserStateModel: Codable {
    let uid: String
    let email: String
    let userTrackArray: [String]
    var dictionary: [String: Any] {
            let data = (try? JSONEncoder().encode(self)) ?? Data()
            return (try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]) ?? [:]
        }
    
    enum CodingKeys: String, CodingKey {
        case uid
        case email
        case userTrackArray
    }

    

    
}


