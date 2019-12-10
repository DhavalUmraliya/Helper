

import Foundation
import UIKit
import SystemConfiguration
//import SwiftMessages
//import GoogleMobileAds


//MARK:- COLOR RGB
public func Color_RGBA(_ R: Int,_ G: Int,_ B: Int,_ A: Int) -> UIColor
{
    return UIColor(red: CGFloat(R)/255.0, green: CGFloat(G)/255.0, blue: CGFloat(B)/255.0, alpha :CGFloat(A))
}

//Set boreder to UI controller
public func setBorder(viewName: UIView ,  borderwidth : CGFloat , borderColor: CGColor , cornerRadius: CGFloat)
{
 // viewName.backgroundColor = UIColor.clear
    viewName.layer.borderWidth =  borderwidth
    viewName.layer.borderColor = borderColor
    viewName.layer.cornerRadius = cornerRadius
    
}
//MARK:ShowAlert

func showAlertMsg(Message: String, AutoHide:Bool) -> Void {
    DispatchQueue.main.async {
        let alert = UIAlertController(title: APP_NAME, message: Message, preferredStyle: UIAlertControllerStyle.alert)
        
        if AutoHide == true {
            //alert.dismiss(animated: true, completion:nil)
            
            let deadlineTime = DispatchTime.now() + .seconds(2)
            DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                print("Alert Dismiss")
                alert.dismiss(animated: true, completion:nil)
            }
        }
        else {
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        }
        UIApplication.shared.windows[0].rootViewController?.present(alert, animated: true, completion: nil)
    }
}

public func cornerRadius(viewName:UIView, radius: CGFloat)
{
    viewName.layer.cornerRadius = radius
  
}


func setCornerRadius( objLayer: CALayer, radiusValue:CGFloat) -> Void {
    objLayer.cornerRadius = radiusValue
    objLayer.masksToBounds = true
}
// for Gradient layer
var gradientLayer: CAGradientLayer!


//ACTIVITY controller
@discardableResult
func customActivityIndicatory(_ viewContainer: UIView, startAnimate:Bool? = true) -> UIActivityIndicatorView {
    let mainContainer: UIView = UIView(frame: viewContainer.frame)
    mainContainer.center = viewContainer.center
//  mainContainer.backgroundColor = UIColor.init(coder: 0xFFFFFF)
    mainContainer.alpha = 0.5
    mainContainer.tag = 789456123
    mainContainer.isUserInteractionEnabled = false
    
    let viewBackgroundLoading: UIView = UIView(frame: CGRect(x:0,y: 0,width: 80,height: 80))
    viewBackgroundLoading.center = viewContainer.center
// viewBackgroundLoading.backgroundColor = UIColor.init(coder: 0x444444)
    viewBackgroundLoading.alpha = 0.5
    viewBackgroundLoading.clipsToBounds = true
    viewBackgroundLoading.layer.cornerRadius = 15
    
    let activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
    activityIndicatorView.frame = CGRect(x:0.0,y: 0.0,width: 40.0, height: 40.0)
    activityIndicatorView.activityIndicatorViewStyle =
        UIActivityIndicatorViewStyle.whiteLarge
    activityIndicatorView.center = CGPoint(x: viewBackgroundLoading.frame.size.width / 2, y: viewBackgroundLoading.frame.size.height / 2)
    if startAnimate!{
        viewBackgroundLoading.addSubview(activityIndicatorView)
        mainContainer.addSubview(viewBackgroundLoading)
        viewContainer.addSubview(mainContainer)
        activityIndicatorView.startAnimating()
    }else{
        for subview in viewContainer.subviews{
            if subview.tag == 789456123{
                subview.removeFromSuperview()
            }
        }
    }
    return activityIndicatorView
}

public func createGradientLayer(button: UIButton) {
    gradientLayer = CAGradientLayer()
    gradientLayer.frame = button.bounds
    gradientLayer.frame.size.width = button.frame.size.width
    gradientLayer.colors = [UIColor.blue.cgColor, UIColor.red.cgColor]
    button.layer.addSublayer(gradientLayer)
}

//MARK:- Userdefault check key exists or not
func isKeyPresentInUserDefaults(key: String) -> Bool {
    return UserDefaults.standard.object(forKey: key) != nil
}


//MARK:- Storyboard and Navigation Function

public func loadVC(strStoryboardId: String, strVCId: String) -> UIViewController {
        let vc = getStoryboard(storyboardName: strStoryboardId).instantiateViewController(withIdentifier: strVCId)
        return vc
}

public func getStoryboard(storyboardName: String) -> UIStoryboard {
    return UIStoryboard(name: storyboardName, bundle: Bundle.main)
}

func getTextfield(view: UIView) -> [UITextField] {

    var results = [UITextField]()
    for subview in view.subviews as [UIView] {
        if let textField = subview as? UITextField {
            results += [textField]
        } else {
            results += getTextfield(view: subview)
        }
    }
    return results
}

//MARK:- Remove all Defaults

func resetUserDefaults()
{
    let defaults = UserDefaults.standard
    let dictionary = defaults.dictionaryRepresentation()
    dictionary.keys.forEach { key in
        defaults.removeObject(forKey: key)
    }
}

//MARK:- function for set hex color

public func hexStringToUIColor (hex:String) -> UIColor {
    

    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

public func IOS_VERSION() -> String {
    return UIDevice.current.systemVersion
}

func SetPlaceholderTextWithColor(_ txtView : UITextField,PlaceHolderColor : UIColor,Text : NSString) {
    txtView.attributedPlaceholder = NSAttributedString(string:Text as String,
                                                       attributes:[NSAttributedStringKey.foregroundColor: PlaceHolderColor])
}

public func SCREENWIDTH() -> CGFloat
{
    let screenSize = UIScreen.main.bounds
    return screenSize.width
}

public func SCREENHEIGHT() -> CGFloat
{
    let screenSize = UIScreen.main.bounds
    return screenSize.height
}
public func ShowNetworkIndicator(xx :Bool)
{
    UIApplication.shared.isNetworkActivityIndicatorVisible = xx
}

//MARK:- FONT
public func FontWithSize(_ fname: String,_ fsize: Int) -> UIFont
{
    return UIFont(name: fname, size: CGFloat(fsize))!
}

//Most top view Controller

public var mostTopViewController: UIViewController? {
get {
    return UIApplication.shared.keyWindow?.rootViewController
}
set {
    UIApplication.shared.keyWindow?.rootViewController = newValue
}

}

public func pushView(viewName: AnyObject)
{
    let animation = CATransition()
    animation.subtype = kCATransitionFromTop //kCATransitionFromRight//kCATransitionFromLeft
    animation.duration = 0.5
    animation.type = kCATransitionPush
    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    viewName.layer.add(animation, forKey: "SwitchToView1")
    
}

//MARK : Length validation
public func TRIM(string: Any) -> String
{
    return (string as AnyObject).trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
}
public func istextFieldBlank(_ txtVal: UITextField, withMessage msg: String) -> Bool {
    if TRIM(string: txtVal.text ?? "").count == 0
    {
        //showMessage("", msg, 3)
        //showAlertMsg(Message: msg, AutoHide: true)
        Toast.makeText(msg).show()
        return false
    }
    return true
}
public func validateMinTxtFieldLength(_ txtVal: UITextField, withMessage msg: String) -> Bool {
    if TRIM(string: txtVal.text ?? "").count < 4
    {
        //showMessage("", msg, 3)
        //showAlertMsg(Message: msg, AutoHide: true)
        Toast.makeText(msg).show()
          return false
    }
    return true
}

public func validatePhoneNumberLength(_ txtVal: UITextField, withMessage msg: String) -> Bool {
    if TRIM(string: txtVal.text ?? "").count < 10
    {
        //showMessage("", msg, 3)
       // showAlertMsg(Message: msg, AutoHide: true)
        Toast.makeText(msg).show()
        return false
    }
    return true
}



struct DIRECTORY_NAME
{
    public static let IMAGES = "Images"
    public static let VIDEOS = "Videos"
    public static let DOWNLOAD_VIDEOS = "Download_videos"
}

func getDocumentDirectoryPath() -> URL?
{
    
    return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
}

func saveImageToLocalDirectoryReturn(imageName: String, imageToSave: UIImage) -> String
{
    let documentsURL = getDocumentDirectoryPath()
    let imagesDirectoryPath = documentsURL?.appendingPathComponent(DIRECTORY_NAME.IMAGES)
    
 
    let imageURL = imagesDirectoryPath?.appendingPathComponent("\(imageName).jpg")
    //print("IMAGE SAVED AT : \(imageURL?.absoluteString)")
    
    do {
        try UIImageJPEGRepresentation(imageToSave, 0.5)?.write(to: imageURL!)
        //try UIImagePNGRepresentation(imageToSave)?.write(to: imageURL!)
    } catch {
        print(error)
    }
    return "\(imageName).jpg"
}

func nullToNil(value : AnyObject?) -> AnyObject? {
    if value is NSNull {
        return nil
    } else {
        return value
    }
}

func nullToNill(value : Any?) -> String? {
    if value is NSNull {
        return nil
    } else {
        return value as? String
    }
}

func stringify(json: Any, prettyPrinted: Bool = false) -> String {
    var options: JSONSerialization.WritingOptions = []
    if prettyPrinted {
        options = JSONSerialization.WritingOptions.prettyPrinted
    }
    do {
        
       // let data = try JSONSerialization.jsonObject(with: json , options: [])
        let data = try JSONSerialization.data(withJSONObject: json, options: options)
        if let string = String(data: data, encoding: String.Encoding.utf8) {
            return string
        }
    } catch {
        print(error)
    }
   
    return ""
}

func stringToDic(text: String) -> [String:Any]?{
    
    if let data = text.data(using: .utf8){
        do{
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
        }
        catch
        {
            print(error.localizedDescription)
        }
    }
    
    return nil
}



func randomString(length: Int) -> String {
    
    let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    let len = UInt32(letters.length)
    
    var randomString = ""
    
    for _ in 0 ..< length {
        let rand = arc4random_uniform(len)
        var nextChar = letters.character(at: Int(rand))
        randomString += NSString(characters: &nextChar, length: 1) as String
    }
    
    return randomString
}

public func forTrailingZero(temp: Double) -> String {
    let tempVar = String(format: "%g", temp)
    return tempVar
}

public func validateTxtLength(_ txtVal: String, withMessage msg: String) -> Bool {
    if TRIM(string: txtVal).count < 4 
    {
        //showMessage("", msg, 3)
        showAlertMsg(Message: msg, AutoHide: true)
        return false
    }
    return true
}
public func passwordMismatch(_ txtVal: String, _ txtVal1: String, withMessage msg: String) -> Bool {
    if TRIM(string: txtVal) != TRIM(string: txtVal1)
    {
       //showMessage("", msg, 3);
        showAlertMsg(Message: msg, AutoHide: true)
        return false
    }
    return true
}

public func validateEmailAddress(_ txtVal: UITextField ,withMessage msg: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
   // let emailRegEx =   "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"

    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    if(emailTest.evaluate(with: txtVal.text) != true)
    {
        //showMessage("", msg, 3);
        Toast.makeText(msg).show()
       // showAlertMsg(Message: msg, AutoHide: true)
        return false
    }
    return true
}

public func convertStringToDictionary(str:String) -> [String: Any]? {
    if let data = str.data(using: .utf8) {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch {
            print(error.localizedDescription)
        }
    }
    return nil
}

func isConnectedToNetwork() -> Bool
{
    var zeroAddress = sockaddr_in()
    zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)
    
    guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
            SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
        }
    })
        else
    {
        return false
    }
    
    var flags : SCNetworkReachabilityFlags = []
    if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
        return false
    }
    
    let isReachable = flags.contains(.reachable)
    let needsConnection = flags.contains(.connectionRequired)
    let available =  (isReachable && !needsConnection)
    if(available)
    {
        return true
    }
    else
    {
        //showMessage("", InternetNotAvailable, 3)
        showAlertMsg(Message: "INTERNET_LOSS", AutoHide: true)
        return false
    }
}

func viewSlideInFromTop(toBottom views: UIView)
{
    let transition = CATransition()
    transition.duration = 0.5
    transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    transition.type = kCATransitionPush
    transition.subtype = kCATransitionFromBottom
    views.layer.add(transition, forKey: nil)
}

func animateview(vw1 : UIView,vw2:UIView)
{
    UIView.animate(withDuration: 0.1,
                   delay: 0.1,
                   options: UIViewAnimationOptions.curveEaseIn,
                   animations: { () -> Void in
                    vw1.alpha = 0;
                    vw2.alpha = 1;
    }, completion: { (finished) -> Void in
        vw1.isHidden = true;
    })
}



func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
    
    let size = image.size
    let widthRatio  = targetSize.width  / image.size.width
    let heightRatio = targetSize.height / image.size.height
    
    // Figure out what our orientation is, and use that to form the rectangle
    var newSize: CGSize
    if(widthRatio > heightRatio) {
        
        newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
    } else {
        
        newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
    }
    
    // This is the rect that we've calculated out and this is what is actually used below
    let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
    // Actually do the resizing to the rect using the ImageContext stuff
    UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
    image.draw(in: rect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage!
}




