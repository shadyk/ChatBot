//
//  Created by Shady
//  All rights reserved.
//
import Foundation

let MESSAGE_ADDED = "MESSAGE_ADDED"

class NotificationCenterHelper: NSObject {
    private static let shared = NotificationCenter.default


    static func postMessageAdded(chat:Chat){
        shared.post(name: NSNotification.Name(MESSAGE_ADDED), object: nil,userInfo: ["chat":chat])
    }
    static func listenMessageAdded(observer: Any,selector: Selector) {
        shared.addObserver(observer, selector: selector, name: NSNotification.Name(MESSAGE_ADDED), object: nil)

    }
}
