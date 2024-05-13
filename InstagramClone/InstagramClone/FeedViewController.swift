//
//  FeedViewController.swift
//  InstagramClone
//
//  Created by english on 2024-04-03.
//

import UIKit
import FirebaseAuth // firebase imports
import FirebaseStorage // firebase imports
import FirebaseFirestore // firebase imports
import SDWebImage // Image library import

// SDWebImage - https://github.com/SDWebImage/SDWebImageSVGKitPlugin.git


class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource { // these are required.

    @IBOutlet weak var tableView: UITableView! // link to storyboard
    
    // Will be used to destructure the information.
    var userEmailArray = [String]()
    var userCommentArray = [String]()
    var likeArray = [Int]()
    var userImageArray = [String]()
    var documentIDArray = [String]()

        override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        getDataFromFirestore() // firebase firestore

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.rowHeight = 400 // explicity set the height of the table view cell
        return userEmailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedViewCell
        cell.userEmailLabel.text = userEmailArray[indexPath.row]
        cell.userImageView.sd_setImage(with: URL(string: userImageArray[indexPath.row]))
        cell.commentLabel.text = userCommentArray[indexPath.row]
        cell.likeCount?.text = String(likeArray[indexPath.row])
        cell.documentIDLabel?.text = String(documentIDArray[indexPath.row]) // add this line.
        return cell
    }

        func getDataFromFirestore( ){
        let firestoreDatabase = Firestore.firestore()
        
        firestoreDatabase.collection("Posts").addSnapshotListener( {
            ( snapshot, error) in
            if error != nil {
                print(error?.localizedDescription ?? "Something went Wrong.")
            }else{
                // We have some data in it.
                if  snapshot?.isEmpty != true && snapshot != nil {
                    
                    for document in snapshot!.documents {
                        let documentID = document.documentID
                        self.documentIDArray.append(documentID)
                        print(documentID)
                        
                        if let postedBy =  document.get("postedBy") as? String{
                            self.userEmailArray.append(postedBy)
                        }
                        
                        if let postComment = document.get("comment") as? String {
                            self.userCommentArray.append(postComment)
                        }
                        
                        if let likes = document.get("likes") as? Int {
                            self.likeArray.append(likes)
                        }
                        
                        if let imageurl = document.get("imageUrl") as? String {
                            self.userImageArray.append(imageurl)
                        }
                    }
                    // after the for loop.
                    // reload the table view
                    self.tableView.reloadData() // reload table view.
                }
            }
        })
    }



}
