//
//  RoundedTextField.swift
//  Aisle
//
//  Created by GVM on 16/06/22.
//

import Foundation
import UIKit

class RoundedTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        self.layer.cornerRadius = 8.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.black.cgColor
        self.font = UIFont(name: "Inter-Regular", size: 20)
        self.textAlignment = .center
        self.textContentType = .telephoneNumber
        self.keyboardType = .phonePad
    }
}
