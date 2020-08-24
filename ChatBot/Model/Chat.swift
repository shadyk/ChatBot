//
//  Created by Shady
//  All rights reserved.
//
import Foundation

struct Chat : Codable , Equatable {
    static func == (lhs: Chat, rhs: Chat) -> Bool {
        return lhs.chatID == rhs.chatID
    }

    var chatID : Double?
    var user : User?
    var messages : [Message]?
    var date : Date?

    enum CodingKeys: String, CodingKey {
        case chatID
        case user
        case messages
        case date
    }

     init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        user = try values.decode(User.self, forKey: .user)
        chatID = try values.decode(Double.self, forKey: .chatID)
        messages = try values.decode([Message].self, forKey: .messages)
        date = try values.decode(Date.self, forKey: .date)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(chatID, forKey: .chatID)
        try container.encode(user, forKey: .user)
        try container.encode(messages, forKey: .messages)
        try container.encode(date, forKey: .date)
    }

    init(user:User) {
        self.user = user
        self.date = Date()
        self.chatID = self.date?.timeIntervalSince1970
        self.messages = [Message]()
    }

    
}


