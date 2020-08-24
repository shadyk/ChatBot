//
//  Created by Shady
//  All rights reserved.
// 
import Foundation

struct Message : Codable {
    var body : String?
    var date : Date?
    var isSender : Bool

    enum CodingKeys: String, CodingKey {
        case body
        case date
        case isSender
    }

    init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        body = try values.decode(String.self, forKey: .body)
        date = try values.decode(Date.self, forKey: .date)
        isSender = try values.decode(Bool.self, forKey: .isSender)

    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(body, forKey: .body)
        try container.encode(date, forKey: .date)
        try container.encode(isSender, forKey: .isSender)
    }

    init(body:String,date:Date,isSender:Bool) {
        self.body = body
        self.date = date
        self.isSender = isSender
    }
    
}
