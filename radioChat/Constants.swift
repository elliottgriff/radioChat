//
//  Constants.swift
//  radioChat
//
//  Created by elliott on 3/18/21.
//

struct K {
    
    static let appName = "the lounge"
    
    static let cellIdentifier = "ReusableCell"
    static let otherCellIdentifier = "OtherReusableCell"
    static let cellNibName = "MessageCell"
    static let otherCellNibName = "OtherUserCell"
    static let signupSegue = "SignUpToGroup"
    static let loginSegue = "LoginToGroup"
    static let groupSegue = "GroupToRoom"
    static let welcomeSegue = "WelcomeToRoom"
    
    struct Fstore {
        static var roomName = ""
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
    
    struct Spotify {
        static let clientID = "4fe5e2e28ebd430e8f2158db28b14289"
        static let clientSecret = "75d7f41bd79a435cb58c4e72592daa16"
    }
    
}
