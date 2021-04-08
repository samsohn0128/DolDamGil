//
//  EndPoint.swift
//  Doldamgil
//
//  Created by Kyle Yang on 2020/09/08.
//  Copyright © 2020 Kyle Yang. All rights reserved.
//

import Alamofire
import SwiftyJSON

let mainUrl        = "https://test.rest.doldamgil.spidycoder.com/"
// let holdListUrl    = "https://s3.ap-northeast-2.amazonaws.com/s3.doldamgil.spidycoder.com/gyms/1/edges/1/walls/2020-11-17T02%3A27%3A51Z/info"
// let wallImageUrl   = "https://s3.ap-northeast-2.amazonaws.com/s3.doldamgil.spidycoder.com/gyms/1/edges/1/walls/2020-11-17T02%3A27%3A51Z/background.jpg"
let s3Url = "https://s3.ap-northeast-2.amazonaws.com/s3.doldamgil.spidycoder.com/gyms/1/edges/1/walls/"

//let setProblemUrl  = "https://test.rest.doldamgil.spidycoder.com:4430/gyms/1/edges/1/walls/2020-11-09T01%3A59%3A31Z/routes/1/2020-11-09T02%3A03%3A44Z/records"
let setProblemUrl  = "https://test.rest.doldamgil.spidycoder.com:4430/gyms/1/edges/1/walls/"

//let postProblemUrl = "https://test.rest.doldamgil.spidycoder.com:4430/gyms/1/edges/1/walls/2020-11-17T02%3A27%3A51Z/routes"
let postProblemUrl = "https://test.rest.doldamgil.spidycoder.com:4430/gyms/1/edges/1"

//let getProblemUrl = "https://test.rest.doldamgil.spidycoder.com:4430/gyms/1/edges/1/walls/2020-11-17T02%3A27%3A51Z/routes"
let getProblemUrl  = "https://test.rest.doldamgil.spidycoder.com:4430/gyms/1/edges/1"

let signInUrl      = "https://test.rest.doldamgil.spidycoder.com:4430/login?"
