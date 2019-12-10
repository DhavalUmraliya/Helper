import Foundation

class UserDefaultManager
{
    class func setObjectValueToUserDefaults(idValue: AnyObject, ForKey strKey: String) {
        
        let defaults = UserDefaults.standard
        
        defaults.set(idValue, forKey: strKey)
        defaults.synchronize()
        
    }
    
    class func getObjectValueFromUserDefaults_ForKey(strKey: String) -> AnyObject {
        let defaults = UserDefaults.standard
        var obj: AnyObject? = nil
        obj = defaults.object(forKey: strKey) as AnyObject?
        return obj!
    }
    
    class func setDoubleToUserDefaults(value: Double , key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    class func getDoubleFromUserDefaults(key: String) -> Double {
        return UserDefaults.standard.double(forKey: key)
    }
    
    class func setFloatToUserDefaults(value: Float , key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    class func getFloatFromUserDefaults(key: String) -> Float {
      return UserDefaults.standard.float(forKey: key)
    }
    
    class func setBooleanToUserDefaults(value: Bool , key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    class func getBooleanFromUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.bool(forKey: key)
    }
    
    
    class func setStringToUserDefaults(value: String , key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    class func getStringFromUserDefaults(key: String) -> String
    {
        if(UserDefaults.standard.string(forKey: key) == nil)
        {
            return "N/A"
        }
        else
        {
            return UserDefaults.standard.string(forKey: key)!
        }
    }
    
    class func setCustomObjToUserDefaults(CustomeObj: AnyObject , key: String) {
        
        let defaults = UserDefaults.standard
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: CustomeObj)
        defaults.set(encodedData, forKey: key)
        defaults.synchronize() 
    }
    
    class func getCustomObjFromUserDefaults(key: String) -> AnyObject {
        let defaults = UserDefaults.standard
        let decoded  = defaults.object(forKey: key) as! NSData
        let decodedTeams = NSKeyedUnarchiver.unarchiveObject(with: decoded as Data)! as AnyObject
        return decodedTeams
    }
    
    class func removeCustomObject(key: String)
    {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: key)
        defaults.synchronize()
    }
    
    class func iskeyAlreadyExist(key: String) -> Bool
    {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
}
