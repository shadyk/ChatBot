//
//  Created by Shady
//  All rights reserved.
// 

struct User : Codable{
    var name : String?

    enum CodingKeys: String, CodingKey {
        case name
    }

    init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }


    init(name:String) {
        self.name = name
    }
    
}
