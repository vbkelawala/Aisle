//
//  UIViewController+Extension.swift
//  Aisle
//
//  Created by GVM on 18/06/22.
//

import Foundation
import UIKit

extension UIViewController {
    func dismissView(_ animated: Bool) {
        self.navigationController?.popViewController(animated: animated)
    }
}
