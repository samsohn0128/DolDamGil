//
//  ProblemInfoInTableViewCell.swift
//  Doldamgil
//
//  Created by Kyle Yang on 2020/10/22.
//  Copyright © 2020 Kyle Yang. All rights reserved.
//

import UIKit

class ProblemInfoInTableViewCell: UITableViewCell {
    
    let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        
        return lbl
    }()
    
    let difficultyLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 12)
        
        return lbl
    }()
    
    let creatorLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 12)
        
        return lbl
    }()
    
    let problemImgView: UIImageView = {
        let imgView = UIImageView()
         imgView.downloaded(from: "https://s3.ap-northeast-2.amazonaws.com/s3.doldamgil.spidycoder.com/gyms/1/edges/1/walls/2020-11-17T02%3A27%3A51Z/background.jpg")
        imgView.layer.cornerRadius = 10
        
        return imgView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(titleLbl)
        self.contentView.addSubview(difficultyLbl)
        self.contentView.addSubview(creatorLbl)
        self.contentView.addSubview(problemImgView)
        
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        difficultyLbl.translatesAutoresizingMaskIntoConstraints = false
        creatorLbl.translatesAutoresizingMaskIntoConstraints = false
        problemImgView.translatesAutoresizingMaskIntoConstraints = false
        
        problemImgView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20).isActive = true
        problemImgView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
//        problemImgView.trailingAnchor.constraint(equalTo: difficultyLbl.leadingAnchor, constant: -20).isActive = true
        problemImgView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20).isActive = true
        problemImgView.widthAnchor.constraint(equalTo: problemImgView.heightAnchor).isActive = true
        
        titleLbl.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20).isActive = true
        titleLbl.leadingAnchor.constraint(equalTo: problemImgView.trailingAnchor, constant: 27).isActive = true
        titleLbl.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20).isActive = true
        titleLbl.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        difficultyLbl.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 2).isActive = true
        difficultyLbl.leadingAnchor.constraint(equalTo: problemImgView.trailingAnchor, constant: 30).isActive = true
        difficultyLbl.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20).isActive = true
        difficultyLbl.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        creatorLbl.topAnchor.constraint(equalTo: difficultyLbl.bottomAnchor, constant: 2).isActive = true
        creatorLbl.leadingAnchor.constraint(equalTo: problemImgView.trailingAnchor, constant: 30).isActive = true
        creatorLbl.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20).isActive = true
        creatorLbl.heightAnchor.constraint(equalToConstant: 18).isActive = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
