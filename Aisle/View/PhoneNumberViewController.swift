//
//  ViewController.swift
//  Aisle
//
//  Created by GVM on 16/06/22.
//

import UIKit
import SnapKit

class PhoneNumberViewController: BaseViewController {
    
    private var lblTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Regular", size: 20)
        label.text = "Get OTP"
        return label
    }()
    
    private var lblSubTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Bold", size: 35)
        label.text = "Enter Your\nPhone Number"
        label.numberOfLines = 2
        return label
    }()
    
    private var phoneNumberStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8.0
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private var countryCodeTextField: RoundedTextField = {
        let textField = RoundedTextField()
        textField.placeholder = "+91"
        return textField
    }()
    
    private var phoneNumberTextField: RoundedTextField = {
        let textField = RoundedTextField()
        textField.placeholder = "9999999999"
        return textField
    }()
    
    private var continueButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "Inter-Regular", size: 14.0)
        button.setTitle("Continue", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor(hexString: "#F9CB10")
        button.clipsToBounds = true
        return button
    }()

    private var viewModel = PhoneNumberViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        continueButton.layer.cornerRadius = continueButton.bounds.height / 2
    }
    
    private func prepareView() {
        self.view.addSubview(lblTitle)
        self.view.addSubview(lblSubTitle)
        phoneNumberStackView.addArrangedSubview(countryCodeTextField)
        phoneNumberStackView.addArrangedSubview(phoneNumberTextField)
        self.view.addSubview(phoneNumberStackView)
        self.view.addSubview(continueButton)
        lblTitle.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp.top).offset(80)
            make.leading.equalTo(self.view.snp.leading).offset(30)
        }
        lblSubTitle.snp.makeConstraints { make in
            make.top.equalTo(self.lblTitle.snp.bottom).offset(8)
            make.leading.equalTo(self.view.snp.leading).offset(30)
        }
        countryCodeTextField.snp.makeConstraints { make in
            make.width.equalTo(64)
        }
        phoneNumberTextField.snp.makeConstraints { make in
            make.width.equalTo(145)
        }
        phoneNumberStackView.snp.makeConstraints { make in
            make.top.equalTo(self.lblSubTitle.snp.bottom).offset(12)
            make.leading.equalTo(self.view.snp.leading).offset(30)
            make.height.equalTo(36)
        }
        continueButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(96)
            make.top.equalTo(self.phoneNumberStackView.snp.bottom).offset(19)
            make.leading.equalTo(self.view.snp.leading).offset(30)
        }
        //
        countryCodeTextField.delegate = self
        phoneNumberTextField.delegate = self
        //
        continueButton.addTarget(self, action: #selector(continueButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc
    func continueButtonTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        if let phone = self.phoneNumberTextField.text, !phone.isEmpty,
           let countryCode = self.countryCodeTextField.text, !countryCode.isEmpty {
            self.setLoadingViewStatus(.show)
            let param = [
                "number": "\(countryCode)\(phone)"
            ]
            viewModel.sendOTPRequest(dicParam: param) { isSuccess in
                self.setLoadingViewStatus(.hidden)
                if isSuccess == true {
                    let vc = OTPViewController()
                    vc.phoneNumber = phone
                    vc.countryCode = countryCode
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    SnackBar.show(strMessage: ErrorMesssages.wrong, type: .negative)
                }
            }
        } else {
            SnackBar.show(strMessage: ErrorMesssages.emptyPhoneNumber, type: .negative)
        }
    }
}

//MARK: UITextField Delegate Methods
extension PhoneNumberViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == self.countryCodeTextField) {
            self.phoneNumberTextField.becomeFirstResponder()
        }
        if (textField == self.phoneNumberTextField)
        {
            self.phoneNumberTextField.resignFirstResponder()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == phoneNumberTextField {
            let numbersOnly = CharacterSet(charactersIn: "0987654321")
            let characterSetFromTextField = CharacterSet(charactersIn: string)
            let stringIsValid = numbersOnly.isSuperset(of: characterSetFromTextField)
            return stringIsValid
        } else if textField == countryCodeTextField {
            let numbersOnly = CharacterSet(charactersIn: "+987654321")
            let characterSetFromTextField = CharacterSet(charactersIn: string)
            let stringIsValid = numbersOnly.isSuperset(of: characterSetFromTextField)
            return stringIsValid
        }
        return true
    }
}

