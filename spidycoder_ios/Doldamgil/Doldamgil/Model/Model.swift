//
//  Model.swift
//  Doldamgil
//
//  Created by Kyle Yang on 2020/09/08.
//  Copyright © 2020 Kyle Yang. All rights reserved.
//

import Foundation

struct HoldList: Codable {
    let holds: [Hold]
}

struct Hold: Codable {
    var id: Int
    var leftTopX: Double
    var leftTopY: Double
    var rightBottomX: Double
    var rightBottomY: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case leftTopX = "x1"
        case leftTopY = "y1"
        case rightBottomX = "x2"
        case rightBottomY = "y2"
    }
}

struct Problem: Codable {
    var title: String
    var difficulty: String
    var start: Array<Int>
    var steps: Array<Int>
    var finish: Array<Int>
}

struct ProblemInfo: Codable {
    var edgeCode: Int
    var creatorId: Int
    var wallCreationTime: Date
    var difficulty: String
    var routeDoc: String
    var gymId: Int
    var title: String
    var creationTime: Date
//    var records: Array<Any?>
}
