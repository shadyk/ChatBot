//
//  Created by Shady
//  All rights reserved.
// 

import UIKit

class ChatListViewController: BaseViewController, UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var chatsArray = [Chat]()
    let CELL_HEIGHT = 70.0
    var alert : UIAlertController?


    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        NotificationCenterHelper.listenMessageAdded(observer: self, selector: #selector(refreshView))
    }

    func setupData(){
        chatsArray.removeAll()
        let users = UserController.getUsers()

        users.forEach{
            ChatController.createNewChat(user: $0)
        }

        let allChats = ChatController.getAllChats()!
        let noMessageChats = allChats.filter{$0.messages?.count == 0}
        let messageChats = allChats.filter{$0.messages!.count > 0}
        chatsArray = chatsArray + messageChats
        chatsArray =  chatsArray + noMessageChats
    }

    @objc func refreshView(notification:NSNotification){
        refreshTable()
    }

    func refreshTable(){
        setupData()
        tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toChatDetail" {
            let vc = segue.destination as! ChatDetailViewController
            vc.currentChat = (sender as! Chat)
        }
    }



    //MARK: UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chat = chatsArray[indexPath.row]
        performSegue(withIdentifier: "toChatDetail", sender: chat)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(CELL_HEIGHT)
    }
    //MARK: UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatsArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell", for: indexPath) as! ChatTableViewCell
        configureCell(cell: cell, forRowAt: indexPath)
        return cell
    }

    func configureCell(cell: ChatTableViewCell, forRowAt indexPath: IndexPath) {
        let item = chatsArray[indexPath.row]
        cell.userName.text = item.user?.name
        cell.lastMsg.text = item.messages?.last?.body
        cell.lastMsg.textColor = .gray
    }
}


//MARK: - OTHER FXNS
extension ChatListViewController {
    func showTextFieldAlert(body message:String, placeholder:String,OKHandler action: @escaping (UIAlertAction) -> Void) {

         alert? = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
        let newalert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
        alert = newalert
        alert?.addTextField { (textField) in
            textField.placeholder = placeholder
        }
        let submitAction = UIAlertAction(title: "OK", style: .default, handler: action)
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
        alert?.addAction(submitAction)
        alert?.addAction(cancel)
        self.present(alert!, animated: true)
    }
}

