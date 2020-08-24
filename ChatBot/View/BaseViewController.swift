//
//  Created by Shady
//  All rights reserved.
// 
import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func showAlert(_ message:String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func showAlert(body message:String, placeholder:String,OKHandler action: @escaping (UIAlertAction) -> Void) {

        let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addTextField { (textField) in
            textField.placeholder = placeholder
        }
        let submitAction = UIAlertAction(title: "OK", style: .default, handler: action)
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
        alert.addAction(submitAction)
        alert.addAction(cancel)
        self.present(alert, animated: true)
    }



}
extension String {
    var localized: String {
        let localizedString = Bundle.main.localizedString(forKey: self, value: "", table: nil)
        return localizedString
    }
}
