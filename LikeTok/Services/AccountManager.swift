import Foundation

class AccountManager {
    private static let TOKEN_KEY = "TOKEN_KEY"
    private static let USER_ID = "USER_ID"
    
    public static func isAuthorized() -> Bool {
        let token = UserDefaults.standard.string(forKey: TOKEN_KEY)
        if let token = token{
            Api.headers["Authorization"] = "Bearer \(token)"
        }
        return UserDefaults.standard.string(forKey: TOKEN_KEY) != nil
    }
    public static func logout(){
        UserDefaults.standard.removeObject(forKey: TOKEN_KEY)
        UserDefaults.standard.setValue(nil, forKey: USER_ID)
    }
    
    
    public static func saveAccount(token: String){
        UserDefaults.standard.setValue(token, forKey: TOKEN_KEY)
        Api.headers["Authorization"] = "Bearer \(token)"
    }
    
    public static func saveUserId(userId: String){
        UserDefaults.standard.setValue(userId, forKey: USER_ID)
    }
    
    public static func getUserId() -> String {
        return UserDefaults.standard.value(forKey: USER_ID) as! String
    }
}
