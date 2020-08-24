//
//  Created by Shady
//  All rights reserved.
// 

import UIKit

enum USERError: Error {
    case alreadyExists
    case emptyName
}

class UserController: NSObject {

    class func createNewUser(name:String) throws -> User {
        guard !name.isEmpty else {
            throw USERError.emptyName
        }

        if getUser(name: name) != nil{
            throw USERError.alreadyExists
        }

        else{
            let user = User.init(name: name)
            UserDefaultHelper.addUSER(user)
            return user
        }
    }

    class func getUser(name:String) -> User?{
        if let array = UserDefaultHelper.getUsersArray(){
            let fitlered =  array.filter{$0.name == name}
            if fitlered.count > 0 {
                return fitlered.first
            }
        }
        return nil
    }
    class func getUsers() -> [User]{
         if let array = UserDefaultHelper.getUsersArray(), array.count > 0 {
             return array
         }
        else{
            return self.get200RandomUser()
        }
     }

    class func get200RandomUser() -> [User]{
        var users = [User]()
        for i in 1...200{
            users.append(try! self.createNewUser(name: "User \(i)"))
        }
        return users
    }

}
