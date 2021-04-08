//
//  TFInTableViewCell.swift
//  Doldamgil
//
//  Created by Kyle Yang on 2020/10/21.
//  Copyright © 2020 Kyle Yang. All rights reserved.
//

import UIKit

//protocol TFInTableViewCellDelegate: NSObjectProtocol {
//    func textFieldDidEndEditing(text: String, cell: TFInTableViewCell)
//}

class TFInTableViewCell: UITableViewCell {
    
    let problemTitleTF: UITextField = {
        let tf = UITextField()
        tf.placeholder = "문제 제목"
        tf.underlined()
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
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
        
        self.contentView.addSubview(problemTitleTF)
        
        problemTitleTF.delegate = self
        problemTitleTF.returnKeyType = UIReturnKeyType.done
        
        problemTitleTF.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        problemTitleTF.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        problemTitleTF.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        problemTitleTF.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
//    override func layoutSubviews() {
//        self.layoutSubviews()
//        
//        problemTitleTF.underlined()
//    }
}

extension TFInTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        
        let vc = SetProblemDetailVC()
        vc.problemTitle = text
    }
}
