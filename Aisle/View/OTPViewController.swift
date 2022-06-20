//
//  OPTViewController.swift
//  Aisle
//
//  Created by GVM on 16/06/22.
//

import UIKit

class OTPViewController: BaseViewController {
    
    var phoneNumber: String?
    var countryCode: String?
    
    private var lblTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Regular", size: 20)
        return label
    }()
    
    private var lblSubTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Bold", size: 35)
        label.text = "Enter The\nOTP"
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

    private var editButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "edit"), for: .normal)
        return button
    }()
    
    private var otpTextField: RoundedTextField = {
        let textField = RoundedTextField()
        textField.placeholder = "9999"
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
    
    private var otpViewModel = OTPViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        continueButton.layer.cornerRadius = continueButton.bounds.height / 2
    }
    
    private func prepareView() {
        self.view.backgroundColor = .white
        phoneNumberStackView.addArrangedSubview(lblTitle)
        phoneNumberStackView.addArrangedSubview(editButton)
        self.view.addSubview(phoneNumberStackView)
        self.view.addSubview(lblSubTitle)
        self.view.addSubview(otpTextField)
        self.view.addSubview(continueButton)
        phoneNumberStackView.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp.top).offset(80)
            make.leading.equalTo(self.view.snp.leading).offset(30)
        }
        lblSubTitle.snp.makeConstraints { make in
            make.top.equalTo(self.lblTitle.snp.bottom).offset(8)
            make.leading.equalTo(self.view.snp.leading).offset(30)
        }
        otpTextField.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.width.equalTo(78)
            make.top.equalTo(self.lblSubTitle.snp.bottom).offset(12)
            make.leading.equalTo(self.view.snp.leading).offset(30)
        }
        continueButton.snp.makeConstraints { make in
            make.top.equalTo(self.otpTextField.snp.bottom).offset(19)
            make.leading.equalTo(self.view.snp.leading).offset(30)
            make.height.equalTo(40)
            make.width.equalTo(96)
        }
        self.lblTitle.text = prepareMobileNumber()
        self.editButton.addTarget(self, action: #selector(goBack(_:)), for: .touchUpInside)
        continueButton.addTarget(self, action: #selector(continueButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc
    func continueButtonTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        self.setLoadingViewStatus(.show)
        if let otp = self.otpTextField.text, !otp.isEmpty,
        let phone = phoneNumber, let code = countryCode {
            let params = [
                "number": "\(code)\(phone)",
                "otp": "\(otp)"
            ]
            otpViewModel.verifyOTPRequest(dicParam: params) { isSuccess in
                self.setLoadingViewStatus(.hidden)
                if isSuccess == true {
                    let vc = NotesViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    SnackBar.show(strMessage: ErrorMesssages.wrong, type: .negative)
                }
            }
        } else {
            SnackBar.show(strMessage: ErrorMesssages.emptyOTP, type: .negative)
        }
    }
    
    @objc
    func goBack(_ sender: UIButton) {
        self.dismissView(true)
    }
    
    func prepareMobileNumber() -> String {
        guard let countryCode = countryCode else {
            return ""
        }
        guard let phoneNumber = phoneNumber else {
            return ""
        }
        return "\(countryCode) \(phoneNumber)"
    }
    
}
