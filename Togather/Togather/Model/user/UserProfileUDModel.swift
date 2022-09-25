import Foundation

struct Account {
    static var _email: String?
    static var email: String? {
        get {
            _email = UserDefaults.standard.string(forKey: "Account.User.Email")
            return _email
        }
        
        set(newEmail) {
            UserDefaults.standard.set(newEmail, forKey: "Account.User.Email")
            _email = newEmail
        }
    }
    
    static var _ID: String?
    static var ID: String? {
        get {
            _ID = UserDefaults.standard.string(forKey: "Account.User.ID")
            return _ID
        }
        
        set(newID) {
            UserDefaults.standard.set(newID, forKey: "Account.User.ID")
            _ID = newID
        }
    }
    
    static var _profileImagLink: String?
    static var profileImagLink: String? {
        get {
            _profileImagLink = UserDefaults.standard.string(forKey: "Account.User.ProfileImagLink")
            return _profileImagLink
        }
        
        set(newProfileImagLink) {
            UserDefaults.standard.set(newProfileImagLink, forKey: "Account.User.ProfileImagLink")
            _profileImagLink = newProfileImagLink
        }
    }
    
    static func deleteAccount() {
        self.ID = nil
        self.email = nil
        self.profileImagLink = nil
    }
}