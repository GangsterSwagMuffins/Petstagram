//
//  Post.swift
//  PetWorld
//
//  Created by Vinnie Chen on 5/16/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit
import Parse

class Post: PFObject, PFSubclassing {
    /**
     The name of the class as seen in the REST API.
     */
    public static func parseClassName() -> String {
         return "Post"
    }

    
    
   @NSManaged var petName: String?
   @NSManaged var author : Pet?
   @NSManaged var media: PFFile?
   @NSManaged var caption: String?
   @NSManaged var likesCount : NSNumber?
   @NSManaged var commentsCount : NSNumber?
   @NSManaged var timeStamp : String?
    
    weak var delegate: PhotoLoadedDelegate?
    

    
    class func getPosts(completionHandler: ()->()){
        
    }
    
    
    class func postUserImage(photo: UIImage, caption: String?, success: PFBooleanResultBlock?) {
        let post = Post()
        
        post.media = getPhotoFile(photo: photo)
        post.author = Pet.currentPet() // Pointer column type that points to PFUser
        post["caption"] = caption
        post["likesCount"] = 0
        post["commentsCount"] = 0
        
        // Save object (following function will save the object in Parse asynchronously)
        post.saveInBackground(block: success)
        
    }
    
    class func getPhotoFile(photo: UIImage?) -> PFFile? {
        if let photo = photo {
            if let photo_data = UIImagePNGRepresentation(photo) {
                return PFFile(name: "photo.png", data: photo_data)
            }
        } else {
            return nil
        }
        return nil
    }
}


protocol PhotoLoadedDelegate: class{
    func photoLoaded(picture:UIImage, post: Post, tableview: UITableView)

}

