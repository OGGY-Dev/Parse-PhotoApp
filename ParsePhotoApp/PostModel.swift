//
//  PostModel.swift
//  ParsePhotoApp
//
//  Created by Oğulcan DEMİRTAŞ on 25.08.2021.
//

import Foundation
import Parse
struct Post {
    let username: String
    let usercomment: String
    let userImage: PFFileObject
}
