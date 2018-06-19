//
//  Group.swift
//  EzParseandCoreData
//
//  Created by MacMiniCorei5-26Ghz on 6/18/18.
//  Copyright © 2018 GVN. All rights reserved.
//

import UIKit
struct Datas: Codable {
    var datas: Groups
    
    enum  CodingKeys : String, CodingKey {
        case datas = "data"
    }
}

struct Groups: Codable  {
    var groups: [Group]
    
    enum  CodingKeys : String, CodingKey {
        case groups
    }
}

struct Group: Codable {
    var title: String
    var teamsGroup: [Team]
    
    enum CodingKeys : String, CodingKey {
        case title
        case teamsGroup = "teams_group"
    }
}

struct Team: Codable {
    var id: Int
    var teamName: String
    var winner: Int
    var lost: Int
    var drawn: Int
    var flag: URL
    
    enum CodingKeys : String, CodingKey {
        case id
        case teamName = "team_name"
        case winner
        case lost
        case drawn
        case flag
    }
}

struct WorldCupTeam {
    var drawn: Int32
    var flag: String
    var group: String
    var id: Int32
    var lost: Int32
    var teamName: String
    var winner: Int32
    
    enum CodingKeys : String, CodingKey {
        case id
        case teamName = "team_Name"
        case winner
        case lost
        case drawn
        case flag
    }
}
