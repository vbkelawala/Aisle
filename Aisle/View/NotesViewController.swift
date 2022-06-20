//
//  NotesViewController.swift
//  Aisle
//
//  Created by GVM on 18/06/22.
//

import UIKit
import SDWebImage
class NotesViewController: UIViewController, LoaderViewPresentable {
    
    
    private var lblTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Bold", size: 20)
        label.text = "Notes"
        return label
    }()
    
    private var lblSubTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Regular", size: 18)
        label.text = "Personal messages to you"
        label.numberOfLines = 2
        return label
    }()
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.sd_setImage(with: URL(string: "https://testimages.aisle.co/58b125e52d319c0390fc2d68b7da2ba6729804903.png"))
        imageView.layer.cornerRadius = 5.0
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var lblName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Bold", size: 18)
        label.text = "Meena, 23"
        label.numberOfLines = 2
        label.textColor = .white
        return label
    }()
    
    private var reviewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Regular", size: 16)
        label.text = "Tap to review 50+ notes"
        label.numberOfLines = 2
        label.textColor = .white
        return label
    }()
    
    private var upgLblStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    private var upgLblTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Bold", size: 18)
        label.text = "Interested In You"
        label.numberOfLines = 2
        return label
    }()
    
    private var upgLblSubtitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Regular", size: 14)
        label.text = "Premium members can view all their likes at once"
        label.numberOfLines = 2
        label.textColor = UIColor(hexString: "#9B9B9B")
        return label
    }()
    
    private var upgradeButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "Inter-Regular", size: 14.0)
        button.setTitle("Upgrade", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor(hexString: "#F9CB10")
        button.clipsToBounds = true
        return button
    }()
    
    private var imageView2: UIImageView = {
        let imageView = UIImageView()
        imageView.sd_setImage(with: URL(string: "https://testimages.aisle.co/58b125e52d319c0390fc2d68b7da2ba6729804903.png"))
        imageView.layer.cornerRadius = 5.0
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var imageView3: UIImageView = {
        let imageView = UIImageView()
        imageView.sd_setImage(with: URL(string: "https://testimages.aisle.co/58b125e52d319c0390fc2d68b7da2ba6729804903.png"))
        imageView.layer.cornerRadius = 5.0
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var lblName2: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Bold", size: 20)
        label.textColor = .white
        return label
    }()
    
    private var lblName3: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Bold", size: 20)
        label.textColor = .white
        return label
    }()
    
    var viewModel = NoteViewModel()
    var noteData: Notes?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.prepareView()
        self.fetchData()
    }
    
    private func fetchData() {
        viewModel.sendOTPRequest(dicParam: [:]) { isSuccess,notes  in
            if isSuccess == true, let data = notes {
                self.noteData = data
                if let imgUrl = data.likes?.profiles?.first?.avatar {
                    self.imageView.sd_setImage(with: URL(string: imgUrl))
                    self.imageView2.sd_setImage(with: URL(string: imgUrl))
                }
                if let name = data.likes?.profiles?.first?.firstName {
                    self.lblName.text = name
                }
                if let imgURL = data.likes?.profiles?.last?.avatar {
                    self.imageView3.sd_setImage(with: URL(string: imgURL))
                }
                if let name = data.likes?.profiles?.first?.firstName {
                    self.lblName2.text = name
                }
                if let name = data.likes?.profiles?.last?.firstName {
                    self.lblName3.text = name
                }
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        upgradeButton.layer.cornerRadius = upgradeButton.bounds.height / 2
    }
    
    private func prepareView() {
        self.view.backgroundColor = .white
        self.view.addSubview(lblTitle)
        self.view.addSubview(lblSubTitle)
        self.view.addSubview(imageView)
        self.view.addSubview(lblName)
        self.view.addSubview(reviewLabel)
        self.upgLblStackView.addArrangedSubview(upgLblTitle)
        self.upgLblStackView.addArrangedSubview(upgLblSubtitle)
        self.view.addSubview(upgLblStackView)
        self.view.addSubview(upgradeButton)
        self.view.addSubview(imageView2)
        self.view.addSubview(imageView3)
        self.view.addSubview(lblName2)
        self.view.addSubview(lblName3)
        lblTitle.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp.top).offset(53)
            make.centerX.equalTo(self.view.snp.centerX)
        }
        lblSubTitle.snp.makeConstraints { make in
            make.top.equalTo(self.lblTitle.snp.bottom).offset(8)
            make.centerX.equalTo(self.view.snp.centerX)
        }
        imageView.snp.makeConstraints { make in
            make.top.equalTo(self.lblSubTitle.snp.bottom).offset(13)
            make.leading.equalTo(self.view.snp.leading).offset(12)
            make.trailing.equalTo(self.view.snp.trailing).offset(-12)
            make.width.height.equalTo(344)
        }
        lblName.snp.makeConstraints { make in
            make.leading.equalTo(self.imageView.snp.leading).offset(13)
        }
        reviewLabel.snp.makeConstraints { make in
            make.top.equalTo(self.lblName.snp.bottom).offset(5)
            make.leading.equalTo(self.imageView.snp.leading).offset(13)
            make.bottom.equalTo(self.imageView.snp.bottom).offset(-8)
        }
        upgLblTitle.snp.makeConstraints { make in
            make.height.equalTo(27)
        }
        upgLblSubtitle.snp.makeConstraints { make in
            make.height.equalTo(35)
        }
        upgLblStackView.snp.makeConstraints { make in
            make.top.equalTo(self.imageView.snp.bottom).offset(12)
            make.leading.equalTo(self.view.snp.leading).offset(31)
        }
        upgradeButton.snp.makeConstraints { make in
            make.trailing.equalTo(self.view.snp.trailing).offset(-12)
            make.leading.equalTo(self.upgLblStackView.snp.trailing).offset(24)
            make.top.equalTo(self.imageView.snp.bottom).offset(24)
            make.height.equalTo(50)
            make.width.equalTo(113)
        }
        imageView2.snp.makeConstraints { make in
            make.top.equalTo(upgLblStackView.snp.bottom).offset(12)
            make.leading.equalTo(self.view.snp.leading).offset(12)
            make.height.equalTo(220)
            make.width.equalTo(176)
        }
        imageView3.snp.makeConstraints { make in
            make.top.equalTo(upgLblStackView.snp.bottom).offset(12)
            make.leading.equalTo(self.imageView2.snp.trailing).offset(12)
            make.trailing.equalTo(self.view.snp.trailing).offset(-12)
            make.height.equalTo(220)
            make.width.equalTo(176)
        }
        
        lblName2.snp.makeConstraints { make in
            make.leading.equalTo(self.imageView2.snp.leading).offset(13)
            make.bottom.equalTo(self.imageView2.snp.bottom).offset(-11)
        }
        lblName3.snp.makeConstraints { make in
            make.leading.equalTo(self.imageView3.snp.leading).offset(13)
            make.bottom.equalTo(self.imageView2.snp.bottom).offset(-11)
        }
    }
}
