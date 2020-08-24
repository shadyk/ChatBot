//
//  Created by Shady
//  All rights reserved.
// 

import Foundation

class ChatController: NSObject {
    class func getAllChats() -> [Chat]?{
       return UserDefaultHelper.getChatsArray()
    }

    class func createNewChat(user:User){
        let chat = Chat(user: user)
        UserDefaultHelper.addNewChat(chat)
    }

    class func addToChat(chat:Chat,lastMsg :String,isSender:Bool){
        let message = Message(body: lastMsg, date: Date(), isSender: isSender)
        UserDefaultHelper.addToChat(chat: chat, message: message)
    }
}
