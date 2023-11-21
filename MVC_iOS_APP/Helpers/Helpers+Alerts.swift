//
//  Helpers+Alerts.swift
//  MVC_iOS_APP
//
//  Created by CinNun on 18/11/23.
//

import UIKit

extension UIViewController {
    func createSimpleAlert(title: String, message: String, buttonText: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let actionAceptar = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        alertController.addAction(actionAceptar)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
