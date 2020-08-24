//
//  Created by Shady
//  All rights reserved.
//
import Foundation

class UserDefaultHelper: NSObject {

    private static let sharedUserDefault = UserDefaults.standard

    private static let USERS_ARRAY = "USERS_ARRAY"
    private static let CHATS_ARRAY = "CHATS_ARRAY"


    static func addUSER(_ user : User){
        var array = getUsersArray()
        if array != nil && array!.count > 0{
             array!.append(user)
        }
        else{
            array = [user]
        }
        sharedUserDefault.setStructArray(array!, forKey: USERS_ARRAY)
    }

    static func getUsersArray() -> [User]? {
        return sharedUserDefault.structArrayData(User.self, forKey: USERS_ARRAY)
    }
    static func deleteAllUsers(){
        sharedUserDefault.setStructArray([User](), forKey: USERS_ARRAY)
    }

    static func addNewChat(_ chat : Chat){
        var array = getChatsArray()
        if array != nil && array!.count > 0{
            array!.append(chat)
        }
        else{
            array = [chat]
        }
        sharedUserDefault.setStructArray(array!, forKey: CHATS_ARRAY)
    }

    static func getChatsArray() -> [Chat]? {
        return sharedUserDefault.structArrayData(Chat.self, forKey: CHATS_ARRAY)
    }

    static func addToChat(chat : Chat, message:Message){
        var chatArray = getChatsArray()!

        if let i = chatArray.firstIndex(where: {$0 == chat}) {
            var tempChat = chatArray.remove(at: i)
            tempChat.messages?.append(message)
            chatArray.insert(tempChat, at: 0)
            sharedUserDefault.setStructArray(chatArray, forKey: CHATS_ARRAY)
            NotificationCenterHelper.postMessageAdded(chat: tempChat)
        }
    }

    static func deleteAllChats(){
        sharedUserDefault.setStructArray([Chat](), forKey: CHATS_ARRAY)
    }



//    static func setIsLoggedIn(_ logIN : Bool){
//        sharedUserDefault.set(logIN, forKey: isLoggedIN)
//        sharedUserDefault.synchronize()
//    }
//
//    static func isLoggedIn() -> Bool{
//        return sharedUserDefault.bool(forKey: isLoggedIN)
//    }

}



extension UserDefaults {
    open func setStruct<T: Codable>(_ value: T?, forKey defaultName: String){
        let data = try? JSONEncoder().encode(value)
        set(data, forKey: defaultName)
        synchronize()
    }

    open func structData<T>(_ type: T.Type, forKey defaultName: String) -> T? where T : Decodable {
        guard let encodedData = data(forKey: defaultName) else {
            return nil
        }

        return try! JSONDecoder().decode(type, from: encodedData)
    }

    open func setStructArray<T: Codable>(_ value: [T], forKey defaultName: String){
        let data = value.map { try? JSONEncoder().encode($0) }
        set(data, forKey: defaultName)
        synchronize()
    }

    open func structArrayData<T>(_ type: T.Type, forKey defaultName: String) -> [T] where T : Decodable {
        guard let encodedData = array(forKey: defaultName) as? [Data] else {
            return []
        }

        return encodedData.map { try! JSONDecoder().decode(type, from: $0) }
    }
}
