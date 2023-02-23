//
//  AlertManager.swift
//  NewsApp
//
//  Created by MohamedNajeh on 23/02/2023.
//

import Foundation
import UIKit

class AlertsManager {
    
    static let topVC = UIApplication.topViewController()
    //=================
    // MARK: Show Alert
    //=================
    static func showAlert(withTitle title: String?,
        message: String?,
        viewController: UIViewController?,
        showingCancelButton: Bool = false,
        showingOkButton: Bool = true,
        cancelHandler: ((UIAlertAction) -> Void)? = nil,
        actionTitle: String = "Ok",
        actionStyle: UIAlertAction.Style = .default,
        actionHandler: ((UIAlertAction) -> Void)? = nil)
    {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        if showingOkButton {
        let okAction = UIAlertAction(title: actionTitle, style: actionStyle, handler: actionHandler)
        alertController.addAction(okAction)
        }
        else
        {// auto hide
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                alertController.dismiss(animated: true, completion: nil)
            }
        }
        if showingCancelButton {
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: cancelHandler)
            alertController.addAction(cancelAction)
        }

        if let presentingVC = viewController {
            presentingVC.present(alertController, animated: true, completion: nil)
        } else {
            topVC?.present(alertController, animated: true, completion: nil)
        }
    } // showAlert
}
