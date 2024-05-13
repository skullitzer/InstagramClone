//
//  FeedViewCell.swift
//  InstagramClone
//
//  Created by english on 2024-04-03.
//

import UIKit
import Firebase

class FeedViewCell: UITableViewCell {
    
    //  Link these to the Cell in Feedview
    @IBOutlet weak var userEmailLabel: UILabel!
    
    @IBOutlet weak var commentLabel: UILabel!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var likeCount: UILabel!
    
    @IBOutlet weak var documentIDLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func likeButtonPressed(_ sender: UIButton) {
        // we will work on it later in firebase.
        print("Like Button Pressed. \(documentIDLabel.text!)")
        let firestoreDatabase = Firestore.firestore()
                
                if let like = Int(likeCount.text!){
                    if like < 1 {
                        let data = ["likes": like + 1] as [String: Any]
                        firestoreDatabase.collection("Posts").document(documentIDLabel.text!).setData(data, merge: true)
                    } else {
                        let data = ["likes": like - 1] as [String: Any]
                        firestoreDatabase.collection("Posts").document(documentIDLabel.text!).setData(data, merge: true)
                    }
                    
                }
    }
    
}
