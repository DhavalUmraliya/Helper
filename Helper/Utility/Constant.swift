//
//  Constant.swift
//  AQI
//
//  Created by Dhaval Umraliya on 20/06/18.
//  Copyright © 2018 wos. All rights reserved.
//

//BUNDLE ID - com.app.aqi

import Foundation
import UIKit
import CoreLocation
 
//MARK:- Application related variables
let APP_DELEGATE = UIApplication.shared.delegate as! AppDelegate
public let APP_NAME: String = Bundle.main.infoDictionary!["CFBundleName"] as! String
public let APP_VERSION: String = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String

let Server_URL = "https://api.aqi.in/webAPI/api/protected/"
let URL_GETToken = "https://auth.aqi.in/oauth2/token"
let URL_FAQ = "https://m.aqi.in/faq.php"
let URL_ABOUT = "https://www.aqi.in/about-us"
let URL_SHARE = "https://itunes.apple.com/tt/app/airqualityindex-aqi/id1439684571?mt=8"
let URL_BLOG = "https://aqi.in/blog/"
let URL_MONITOR = "https://www.aqi.in/monitor"
var isfromStream = "0"



//MARK:- Folder
var AQI_FolderName = ""

//MARK:- Compare Chart
var dd1ID = ""
var dd2ID = ""
var dd3ID = ""

//MARK: API Timer Count
var RELOAD_TIME_FOR_API = 30
var DEFAULT_LET = "28.7041"
var DEFAULT_LNG = "77.1025"
//for location service to set on or of
var first_time = ""

//MARK:- APP Token
let token_type = UserDefaultManager.getStringFromUserDefaults(key: UD_TokenType)
let ac_token = UserDefaultManager.getStringFromUserDefaults(key: UD_AccessToken)
let APP_TOKEN = token_type + " " + ac_token
var CALL_TIMER = 30 // API refresh time in seconds

//MARK:- all messages
let MSG_SAVE_LOCATION = "Would you like to save this location?"
let MSG_NEED_LOCATION = "AQI need to use location for get AQI information. For turn on location go to \nSettings > Privacy > Location Services."
let MSG_LOCATION_NOT_FOUND = "Location not determined or restricted or denied please try again"



var LAST_UPDATED_TIME = ""
//get state details
var parsDatafromState = ""
//get city details
var ParseCityName = ""

//Location id and searchType for RefreshData
var locId_4_Refresh = ""
var SrchTyp_4_Refresh = ""

//MARK:- Header constant
let HDR_USERNAME    = "Indoor Android API"
let HDR_PASSWORD    = "20dcd1bedf9444d6b0f099f06fd4d901"
let HDR_GRANTTYPE   = "password"
let HDR_CLIENT_ID   = "36df5fba0b0049a4861b34e6bc90db07"
let CONTENT_TYPE    = "application/json"

//MARK:- Color code of Card
let COLOR_OF_GOOD_CITY            = UIColor.init(red: 138/255, green: 170/255, blue: 31/255, alpha: 0.37)
let COLOR_OF_HAZARDOUSE	          = UIColor.init(red: 224/255, green: 42/255, blue: 58/255, alpha: 0.37)
let COLOR_OF_UNHEALTHY            = UIColor.init(red: 226/255, green: 52/255, blue: 138/255, alpha: 0.37)
let COLOR_OF_UNHEALTHY_GROUP      = UIColor.init(red: 275/255, green: 74/255, blue: 28/255, alpha: 0.37)
let COLOR_OF_VERY_UNHEALTHY       = UIColor.init(red: 98/255, green: 25/255, blue: 71/255, alpha: 0.37)
let COLOR_OF_MODERATE             = UIColor.init(red: 208/255, green: 156/255, blue: 40/255, alpha: 0.37)
let DARK_GRAY = UIColor.darkGray

//Navigation header color
let COLOR_NAV = hexStringToUIColor(hex: "#3D8697")
//let COLOR_NAV = UIColor.purple


//MARK:- Status Block Color
let GOOD_BLK_CLR                = "#34a12b"
let MDRT_MDRT_CLR               = "#d4cc0f"
let UNH4GRP_BLK_CLR             = "#FFA500"
let UNH_BLK_CLR                 = "#FF69B4"
let VUNH_BLK_CLR                = "#800080"
let HAZARDOUSE_BLK_CLR          = "#ec0000"

class CustomNAVBAR: UIView {
    
    let containerView = UIView()
   // let cornerRadius: CGFloat = 6.0
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
         setUI()
    }

    func setUI()
    { 
        // set the shadow of the view's layer
        layer.backgroundColor   = hexStringToUIColor(hex: "#EFEFF4").cgColor
        layer.shadowColor       =  hexStringToUIColor(hex: "#EFEFF4").cgColor
        layer.shadowOffset      = CGSize(width: 0, height: 1.0)
        layer.shadowOpacity     = 0.2
        layer.shadowRadius      = 4.0
        // set the cornerRadius of the containerView's layer
        //containerView.layer.cornerRadius = cornerRadius
        containerView.layer.masksToBounds = true
        
        addSubview(containerView)
        
        // add additional views to the containerView here
        
        // add constraints
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        // pin the containerView to the edges to the view
        containerView.isUserInteractionEnabled = true
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

func shareScreenShot(mainView: UIView, Button: UIButton, controllerName: UIViewController)
{
    let img = mainView.takeScreenshot(Button)
    let img2 = UIImage(named: "logoMark")
    let rect = CGRect(x: 0, y: 0, width: img.size.width, height: img.size.height)
    UIGraphicsBeginImageContextWithOptions(img.size, true, 0)
    let context = UIGraphicsGetCurrentContext()
    context!.setFillColor(UIColor.white.cgColor)
    context!.fill(rect)
    img.draw(in: rect, blendMode: .normal, alpha: 1)
    img2?.draw(in: CGRect(x: 0, y: 0, width: img.size.width, height: img.size.height))
    let result = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    let image = result!
    let shareURL = URL_SHARE
    let imageToShare = [image, shareURL] as [Any]
    let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
    
    activityViewController.popoverPresentationController?.sourceView = mainView // so that iPads won't crash
    activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
    controllerName.present(activityViewController, animated: true, completion: nil)
    
}



func getLineChartColor(sensorData:Float, sensorName: String) -> String
{
    if sensorName == "AQI IN"
    {
        if sensorData >= 0.0 && sensorData <= 50.0
        {
            return "#34a12b"
        }
        else if sensorData >= 51.0 && sensorData <= 100.0
        {
            return "#d4cc0f"
        }
        else if sensorData >= 101.0 && sensorData <= 200.0
        {
            return "#FFA500"
        }
        else if sensorData >= 201.0 && sensorData <= 300.0
        {
            return "#FF69B4"
        }
        else if sensorData >= 301.0 && sensorData <= 400.0
        {
            return "#800080"
        }
        else if sensorData >= 401.0 && sensorData <= 5000.0
        {
            return "#ec0000"
        }
        else
        {
            return "#ec0000"
        }
    }
    
    return String()
}

func getBarColors(sensorData:[CGFloat], sensorName: String) ->  [String]
{
    
    var ColorData = [String]()
    ColorData.removeAll()
    
    if sensorName == "AQI IN"
    {
        for i in sensorData
        {
            if i >= 0.0 && i <= 50.0
            {
                ColorData.append("#34a12b")
            }
            else if i >= 51.0 && i <= 100.0
            {
                ColorData.append("#d4cc0f")
            }
            else if i >= 101.0 && i <= 200.0
            {
                ColorData.append("#FFA500")
            }
            else if i >= 201.0 && i <= 300.0
            {
                ColorData.append("#FF69B4")
            }
            else if i >= 301.0 && i <= 400.0
            {
                ColorData.append("#800080")
            }
            else if i >= 401.0 && i <= 5000.0
            {
                ColorData.append("#ec0000")
            }
            else
            {
                ColorData.append("#ec0000")
            }
        }
        
        return ColorData
    }
    else if sensorName == "Noise"
    {
        
    }
    else if sensorName == "PM25"
    {
        
    }
    else if sensorName == "PM10"
    {
        
    }
    else if sensorName == "Temp"
    {
        
    }
    if sensorName == "Hum"
    {
        
    }
    return [String]()
}


struct AQIRange {
    let strGood : [String : AnyObject]!
    let strMod : [String : AnyObject]!
    let strPoor :[String : AnyObject]!
    let strServer :[String : AnyObject]!
    let strUnhealthy : [String : AnyObject]!
}

//MARK:- Get_rang for theme
func rangeDetailsData(sensorData:Float, sensorName: String) -> [String:AnyObject]
{
    //MARK: AQI IN
    var Aqi_data = [String:AnyObject]()
    var Noise_data = [String:String]()
    var PM25_data = [String:String]()
    var PM10_data = [String:String]()
    var Temp_data = [String:String]()
    
    if sensorName == "AQI IN"
    {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        let dates = date
        
        
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: dates)
        
        
        
        var backGround = UIImage()
        
        if sensorData < 0.0
        {
            
            if hour >= 5 && hour < 12
            {
                let img = UIImage(named: "morning-good" )
                backGround = img!
            }
            else if hour >= 12 && hour < 16
            {
                let img = UIImage(named: "afternoon-good")
                backGround = img!
            }
            else if hour >= 16 && hour < 21
            {
                let img = UIImage(named: "evening-good")
                backGround = img!
            }
            else if hour >= 21 && hour < 5
            {
                let img = UIImage(named: "night-good")
                backGround = img!
            }
            else
            {
                let img = UIImage(named: "morning-good")
                backGround = img!
            }
            
            Aqi_data = [
                "status":"Good",
                "bg_color": "#34a12b",
                "cartoon" : #imageLiteral(resourceName: "Good_Character"),
                "back_background": backGround,
                "bottom_image": #imageLiteral(resourceName: "Good_City"),
                "card_color" : COLOR_OF_GOOD_CITY,
                "health_advise" : ["outdoor_activity" : "Recommended", "mask" : "Not Required" , "AirPurifier" : "Not Required", "Open Windows" : "Open Windows", "CPC" : "Suitable for Outdoor Activites"]
                
                ] as [String : AnyObject]
            
        }
        else if sensorData >= 0.0 && sensorData <= 50.0
        {
            
            if hour >= 5 && hour < 12
            {
                let img = UIImage(named: "morning-good" )
                backGround = img!
            }
            else if hour >= 12 && hour < 16
            {
                let img = UIImage(named: "afternoon-good")
                backGround = img!
            }
            else if hour >= 16 && hour < 21
            {
                let img = UIImage(named: "evening-good")
                backGround = img!
            }
            else if hour >= 21 && hour < 5
            {
                let img = UIImage(named: "night-good")
                backGround = img!
            }
            else
            {
                let img = UIImage(named: "morning-good")
                backGround = img!
            }
            
            
            Aqi_data = [
                "status":"Good",
                "bg_color": "#34a12b",
                "cartoon" : #imageLiteral(resourceName: "Good_Character"),
                "back_background": backGround,
                "bottom_image": #imageLiteral(resourceName: "Good_City"),
                "card_color" : COLOR_OF_GOOD_CITY,
                "health_advise" : ["outdoor_activity" : "Recommended", "mask" : "Not Required" , "AirPurifier" : "Not Required", "Open Windows" : "Recommended", "CPC" : "Suitable for Outdoor Activites"]
                ] as [String : AnyObject]
        }
        else if sensorData >= 51.0 && sensorData <= 100.0
        {
            
            
            if hour >= 5 && hour < 12
            {
                let img = UIImage(named: "morning-moderate" )
                backGround = img!
            }
            else if hour >= 12 && hour < 16
            {
                let img = UIImage(named: "afternoon-moderate")
                backGround = img!
            }
            else if hour >= 16 && hour < 21
            {
                let img = UIImage(named: "evening-moderate")
                backGround = img!
            }
            else if hour >= 21 && hour < 5
            {
                let img = UIImage(named: "night-moderate")
                backGround = img!
            }
            else
            {
                let img = UIImage(named: "morning-moderate")
                backGround = img!
            }
            
            Aqi_data = [
                "status":"Moderate",
                "bg_color": "#d4cc0f",
                "cartoon" : #imageLiteral(resourceName: "Moderate_Character"),
                "back_background" : backGround,
                "bottom_image":#imageLiteral(resourceName: "Moderate_City"),
                "card_color" : COLOR_OF_MODERATE,
                "health_advise" : ["outdoor_activity" : "Recommended",
                                   "mask"           : "  Required",
                                   "AirPurifier"   : "Advised",
                                   "Open Windows"  : "Close Windows",
                                   "CPC"           : "Avoid Physical Exertion & Outdoor Activites"
                                ]
                ] as [String : AnyObject]
        }
        else if sensorData >= 101.0 && sensorData <= 200.0
        {
            if hour >= 5 && hour < 12
            {
                let img = UIImage(named: "morning-unhealthyforgroup" )
                backGround = img!
            }
            else if hour >= 12 && hour < 16
            {
                let img = UIImage(named: "afternoon-unhealthyforgroup")
                backGround = img!
            }
            else if hour >= 16 && hour < 21
            {
                let img = UIImage(named: "evening-unhealthyforgroup")
                backGround = img!
            }
            else if hour >= 21 && hour < 5
            {
                let img = UIImage(named: "night-unhealthyforgroup")
                backGround = img!
            }
            else
            {
                let img = UIImage(named: "morning-unhealthyforgroup")
                backGround = img!
            }
            
            
            Aqi_data = [
                        "status":"Poor",
                        "bg_color": "#FFA500",
                        "cartoon" : #imageLiteral(resourceName: "Unhealthy for Grop_Character"),
                        "back_background": backGround,
                        "bottom_image": #imageLiteral(resourceName: "Unhealthy for Groups_City"),
                        "card_color" : COLOR_OF_UNHEALTHY_GROUP,
                        "health_advise" : [  "outdoor_activity"     : "Not Recommended",
                                             "mask"              : "Required",
                                             "AirPurifier"       : "Required",
                                             "Open Windows"      : "Not Recommended",
                                             "CPC"               : "Avoid Being Outdoors"
                                          ]
                ] as [String : AnyObject]
            
        }
        else if sensorData >= 201.0 && sensorData <= 300.0
        {
            if hour < 12
            {
                let img = UIImage(named: "morning-unhealthy" )
                backGround = img!
            }
            else if hour >= 12 && hour < 16
            {
                let img = UIImage(named: "afternoon-unhealthy")
                backGround = img!
            }
            else if hour >= 16 && hour < 20
            {
                let img = UIImage(named: "evening-unhealthy")
                backGround = img!
            }
            else if hour >= 20 && hour <= 24
            {
                let img = UIImage(named: "night-unhealthy")
                backGround = img!
            }
            else
            {
                let img = UIImage(named: "morning-unhealthy")
                backGround = img!
            }
            
            Aqi_data = [
                "status":"Unhealthy",
                "bg_color": "#FF69B4",
                "cartoon" : #imageLiteral(resourceName: "Unhealthy_Character"),
                "back_background": backGround,
                "bottom_image": #imageLiteral(resourceName: "Unhealthy_City"),
                "card_color" : COLOR_OF_UNHEALTHY,
                "health_advise" : ["outdoor_activity" : "Not Recommended",
                                   "mask" : "  Required",
                                   "AirPurifier" : "Highly Advised",
                                   "Open Windows" : "Not Recommended",
                                   "CPC" : "Must Avoid Outdoor Activities"
                ]
                
                
                ] as [String : AnyObject]
        }
        else if sensorData >= 301.0 && sensorData <= 400.0
        {
            
            if hour >= 5 && hour < 12
            {
                let img = UIImage(named: "morning-veryunhealthy" )
                backGround = img!
            }
            else if hour >= 12 && hour < 16
            {
                let img = UIImage(named: "afternoon-veryunhealthy")
                backGround = img!
            }
            else if hour >= 16 && hour < 21
            {
                let img = UIImage(named: "evening-veryunhealthy")
                backGround = img!
            }
            else if hour >= 21 && hour < 5
            {
                let img = UIImage(named: "night-veryunhealthy")
                backGround = img!
            }
            else
            {
                let img = UIImage(named: "morning-veryunhealthy")
                backGround = img!
            }
            
            Aqi_data = [
                "status"            : "Severe",
                "bg_color"          : "#800080",
                "cartoon"           : #imageLiteral(resourceName: "Very unhealthy_Character"),
                "back_background"   : backGround,
                "bottom_image"      : #imageLiteral(resourceName: "Very Unhealthy_City"),
                "card_color"        : COLOR_OF_VERY_UNHEALTHY,
                "health_advise" : ["outdoor_activity" : "Not Recommended",
                                   "mask" : "Required",
                                   "AirPurifier" : "Highly Advised",
                                   "Open Windows" : "Not Recommended",
                                   "CPC" : "Spend More Time Indoors"
                ]
                
                ] as [String : AnyObject]
        }
        else if sensorData >= 401.0 && sensorData <= 5000.0
        {
            
            if hour >= 5 && hour < 12
            {
                let img = UIImage(named: "morning-hazardous" )
                backGround = img!
            }
            else if hour >= 12 && hour < 16
            {
                let img = UIImage(named: "afternoon-hazardous")
                backGround = img!
            }
            else if hour >= 16 && hour < 21
            {
                let img = UIImage(named: "evening-hazardous")
                backGround = img!
            }
            else if hour >= 21 && hour < 5
            {
                let img = UIImage(named: "night-hazardous")
                backGround = img!
            }
            else
            {
                let img = UIImage(named: "morning-hazardous")
                backGround = img!
            }
            
            Aqi_data = [
                "status"            : "Hazardous",
                "bg_color"          : "#ec0000",
                "cartoon"           : #imageLiteral(resourceName: "Hazardous_Character"),
                "back_background"   : backGround,
                "bottom_image"      : #imageLiteral(resourceName: "Hazardous_City"),
                "card_color"        : COLOR_OF_HAZARDOUSE,
                "health_advise" : ["outdoor_activity" : "Not Recommended",
                                   "mask" : "Highly Advisable",
                                   "AirPurifier" : "Highly Advised",
                                   "Open Windows" : "Not Recommended",
                                   "CPC" : "Remain Indoors, No Physical Exertion"
                ]] as [String : AnyObject]
        }
        else
        {
            
            if hour >= 5 && hour < 12
            {
                let img = UIImage(named: "morning-hazardous" )
                backGround = img!
            }
            else if hour >= 12 && hour < 16
            {
                let img = UIImage(named: "afternoon-hazardous")
                backGround = img!
            }
            else if hour >= 16 && hour < 21
            {
                let img = UIImage(named: "evening-hazardous")
                backGround = img!
            }
            else if hour >= 21 && hour < 5
            {
                let img = UIImage(named: "night-hazardous")
                backGround = img!
            }
            else
            {
                let img = UIImage(named: "morning-hazardous")
                backGround = img!
            }
            
            Aqi_data = [
                "status"            : "Hazardousy",
                "bg_color"          : "#ec0000",
                "cartoon"           : #imageLiteral(resourceName: "Hazardous_Character"),
                "back_background"   : backGround,
                "bottom_image"      : #imageLiteral(resourceName: "Hazardous_City"),
                "card_color"        : COLOR_OF_HAZARDOUSE,
                "health_advise" : ["outdoor_activity" : "Not Recommended",
                                   "mask" : "Highly Advisable",
                                   "AirPurifier" : "Highly Advised",
                                   "Open Windows" : "Not Recommended",
                                   "CPC" : "Remain Indoors, No Physical Exertion"
                ]
                ] as [String : AnyObject]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
        }
        
        
        return Aqi_data
        
    }
    else if sensorName == "Noise"
    {
        if sensorData < 0.0
        {
            Noise_data = [
                "status" : "Quite",
                "color" : "#006400"
            ]
        }
        else if sensorData >= 0.0 && sensorData <= 19.0
        {
            Noise_data = [
                "status" : "Quite",
                "color" : "#006400"
            ]
        }
        if sensorData >= 20.0 && sensorData <= 50.0
        {
            Noise_data = [
                "status" : "Quite",
                "color" : "#006400"
            ]
        }
        else if sensorData >= 51.0 && sensorData <= 70.0
        {
            Noise_data = [
                "status" : "Normal",
                "color" : "#d4cc0f"
            ]
        }
        else if sensorData >= 71.0 && sensorData <= 80.0
        {
            Noise_data = [
                "status" : "Loud",
                "color" : "#FFA500"
            ]
        }
        else if sensorData >= 81.0 && sensorData <= 90.0
        {
            Noise_data = [
                "status" : "Very loud",
                "color" : "#FF69B4"
            ]
        }
        else if sensorData >= 91.0 && sensorData <= 100.0
        {
            Noise_data = [
                "status" : "Harmful",
                "color" : "#800080"
            ]
        }
        else if sensorData >= 101.0 && sensorData <= 500000.0
        {
            Noise_data = [
                "status" : "Damaging",
                "color" : "#ec0000"
            ]
        }
        
        return Noise_data as [String : AnyObject]
    }
    else if sensorName == "PM25"
    {
        
        if sensorData < 0.0
        {
            PM25_data = [
                "status" : "Good",
                "color" : "#34a12b"
            ]
        }
        else if sensorData < 0.0
        {
            PM25_data = [
                "status" : "Good",
                "color" : "#34a12b"
            ]
        }
        else if sensorData >= 0.0 && sensorData <= 30.0
        {
            PM25_data = [
                "status" : "Good",
                "color" : "#34a12b"
            ]
        }
        else if sensorData >= 31.0 && sensorData <= 60.0
        {
            PM25_data = [
                "status" : "Satisfactory",
                "color" : "#d4cc0f"
            ]
        }
        else if sensorData >= 61.0 && sensorData <= 90.0
        {
            PM25_data = [
                "status" : "Moderately Polluted",
                "color" : "#FFA500"
            ]
        }
        else if sensorData >= 91.0 && sensorData <= 120.0
        {
            PM25_data = [
                "status" : "Poor",
                "color" : "#FF69B4"
            ]
        }
        else if sensorData >= 121.0 && sensorData <= 250.0
        {
            PM25_data = [
                "status" : "Very Poor",
                "color" : "#800080"
            ]
            
        }
        else if sensorData >= 250.0 && sensorData <= 50000.0
        {
            PM25_data = [
                "status" : "Severe",
                "color" : "#ec0000"
            ]
        }
        else
        {
            PM25_data = [
                "status" : "Severe",
                "color" : "#ec0000"
            ]
        }
        
        return PM25_data as [String : AnyObject]
        
    }
    else if sensorName == "PM10"
    {
        if sensorData < 0.0
        {
            PM10_data = [
                "status" : "Good",
                "color" : "#34a12b"
            ]
        }
        else if sensorData >= 0.0 && sensorData <= 50.0
        {
            PM10_data = [
                "status" : "Good",
                "color" : "#34a12b"
            ]
        }
        else if sensorData >= 51.0 && sensorData <= 100.0
        {
            PM10_data = [
                "status" : "Satisfactory",
                "color" : "#d4cc0f"
            ]
        }
        else if sensorData >= 101.0 && sensorData <= 250.0
        {
            PM10_data = [
                "status" : "Moderately Polluted",
                "color" : "#FFA500"
            ]
        }
        else if sensorData >= 251.0 && sensorData <= 350.0
        {
            PM10_data = [
                "status" : "Poor",
                "color" : "#FF69B4"
            ]
            
        }
        else if sensorData >= 351.0 && sensorData <= 430.0
        {
            PM10_data = [
                "status" : "Very Poor",
                "color" : "#800080"
            ]
        }
        else if sensorData >= 431.0 && sensorData <= 500000.0
        {
            PM10_data = [
                "status" : "Severe",
                "color" : "#ec0000"
            ]
        }
        else
        {
            PM10_data = [
                "status" : "Severe",
                "color" : "#ec0000"
            ]
        }
        
        return PM10_data as [String : AnyObject]
        
    }
    else if sensorName == "Temp"
    {
        
        if sensorData >= -100000 && sensorData <= 0
        {
            Temp_data = [
                "status" : "Freezing",
                "color" : "#003366"
            ]
        }
        else if sensorData >= 1 && sensorData <= 8
        {
            Temp_data = [
                "status" : "Very cold",
                "color" : "#0000FF"
            ]
        }
        else if sensorData >= 9 && sensorData <= 15
        {
            Temp_data = [
                "status" : "Cold",
                "color" : "#ADD8E6"
            ]
            
        }
        else if sensorData >= 16 && sensorData <= 20
        {
            Temp_data = [
                "status" : "cool",
                "color" : "#0d98ba"
            ]
        }
        else if sensorData >= 21 && sensorData <= 30
        {
            Temp_data = [
                "status" : "Normal",
                "color" : "#34a12b"
            ]
        }
        else if sensorData >= 31 && sensorData <= 35
        {
            Temp_data = [
                "status" : "Warm",
                "color" : "#FFA500"
            ]
        }
        else if sensorData >= 36 && sensorData <= 40
        {
            Temp_data = [
                "status" : "Hot",
                "color" : "#f49c9c"
            ]
        }
        else if sensorData >= 41 && sensorData <= 45
        {
            Temp_data = [
                "status" : "Very Hot",
                "color" : "#ec0000"
            ]
        }
        else if sensorData >= 46 && sensorData <= 50000
        {
            Temp_data = [
                "status" : "Extremely Hot",
                "color" : "#c11e2f"
            ]
        }
        else
        {
            Temp_data = [
                "status" : "Extremely Hot",
                "color" : "#c11e2f"
            ]
        }
        
        return Temp_data as [String : AnyObject]
    }
    else if sensorName == "Hum"
    {
        if sensorData < 0.0
        {
            Temp_data = [
                "status" : "Very Dry",
                "color" : "#FFFF00"
            ]
        }
        if sensorData >= 0 && sensorData <= 20
        {
            Temp_data = [
                "status" : "Very Dry",
                "color" : "#FFFF00"
            ]
        }
        else if sensorData >= 21.0 && sensorData <= 39.0
        {
            Temp_data = [
                "status" : "Dry",
                "color" : "#9ACD32"
            ]
            
        }
        else if sensorData >= 40 && sensorData <= 55
        {
            Temp_data = [
                "status" : "Normal",
                "color" : "#34a12b"
            ]
        }
        else if sensorData >= 56 && sensorData <= 65
        {
            Temp_data = [
                "status" : "Slightly Wet",
                "color" : "#FF69B4"
            ]
        }
        else if sensorData >= 66 && sensorData <= 75
        {
            Temp_data = [
                "status" : "Wet",
                "color" : "#0000FF"
            ]
        }
        else if sensorData >= 76 && sensorData <= 100
        {
            Temp_data = [
                "status" : "Very Wet",
                "color" : "#003366"
            ]
        }
        else if sensorData >= 101
        {
            Temp_data = [
                "status" : "Very Wet",
                "color" : "#003366"
            ]
        }
        else
        {
            Temp_data = [
                "status" : "Very Wet",
                "color" : "#003366"
            ]
        }
        
        return Temp_data as [String : AnyObject]
    }
    
    return [String: AnyObject]()
}

//Mark:- AQI pros and cons Details
func getAQIDetails(status: String) -> [String : String]
{
    var data = [String:String]()
    
    if status == "AQI_GOOD"
    {
        data = [
            "details" : "When the AQI level (air quality index) is below 50, people are breathing fresh, clean air. People are no longer exposed to any health risk because the quality of air is pure.",
            "pros1" : "Be highly active outside and spend more time.",
            "pros2" : "Breathe as much fresh air as you can.",
            "pros3" : "Get involved in prolonged and heavy exertion.",
            "pros4" : "Try to use eco- friendly modes of transportation.",
            "imgPros1" : "icon_hint_a",
            "imgPros2" : "icon_hint_b",
            "imgPros3" : "icon_hint_d",
            "imgPros4" : "icon_hint_c",
            
            "cartoon" : "Good_Character",
            
            "cons1" : "Do not contaminate the ambient air.",
            "cons2" : "Do not use pollution emitting vehicles too much.",
            "cons3" : "Limit the usage of insecticides in agricultural activities.",
            "cons4" : "Do not burn the garbage.",
            "imgCons1" : "icon_hint_e",
            "imgCons2" : "icon_hint_f",
            "imgCons3" : "icon_hint_g",
            "imgCons4" : "icon_hint_h"
            
        ]
        
        return data
        
    }
    else if status == "AQI_Moderate"
    {
        data = [
            "details" : "AQI level between 51-100 signifies an acceptable air quality for a healthy adult but may still pose a threat to a sensitive individual.",
            "pros1" : "Spend time outdoors but in moderation.",
            "pros2" : "Do less intense and heavy outdoor exercises",
            "pros3" : "Sensitive people should take more breaks often and carry their medicines along.",
            "pros4" : "People with heart and lung diseases should keep their outdoor activities in check.",
            "imgPros1" : "icon_hint_a",
            "imgPros2" : "icon_hint_i",
            "imgPros3" : "icon_hint_j",
            "imgPros4" : "icon_hint_d",
            "cartoon" : "Moderate_Character",
            "cons1" : "Avoid heavy exertion outdoors.",
            "cons2" : "Do not get involved in activities which make air dirty and polluted.",
            "cons3" : "Asthmatics should avoid being outdoors as they may experience breathing problems.",
            "cons4" : "Avoid burning garbage and residual agricultural crops",
            "imgCons1" : "icon_hint_e",
            "imgCons2" : "icon_hint_f",
            "imgCons3" : "icon_hint_k",
            "imgCons4" : "icon_hint_h"
        ]
        return data
    }
    else if status == "AQI_Poor"
    {
        data = [
            "details" : "With AQI levels between 101-200, the poor air quality can affect people’s health and cause discomfort to people with heart diseases.",
            
            "pros1" : "Reduce prolonged or heavy exertion outside.",
            "pros2" : "Take more breaks in between while performing outdoor activities.",
            "pros3" : "People who are sensitive should shift their activities indoors.",
            "pros4" : "People suffering from respiratory problems should spend time indoors.",
            "imgPros1" : "icon_hint_d",
            "imgPros2" : "icon_hint_l",
            "imgPros3" : "icon_hint_m",
            "imgPros4" : "icon_hint_n",
             "cartoon" : "Unhealthy for Grop_Character",
            "cons1" : "Do not get involved in strenuous physical activities outdoors.",
            "cons2" : "Do not step outside without taking precautionary measures.",
            "cons3" : "Sensitive people should avoid getting involved in prolonged or heavy exertion.",
            "cons4" : "People with respiratory problems should avoid being outdoors.",
            "imgCons1" : "icon_hint_i",
            "imgCons2" : "icon_hint_p",
            "imgCons3" : "icon_hint_k",
            "imgCons4" : "icon_hint_q"
        ]
        return data
    }
    else if status == "AQI_Unhealthy"
    {
        data = [
            "details" : "AQI level between 201-300 is a result to your constant health issues. Breathing unhealthy air causes various respiratory illness such as feeling nauseous, running temperature, cough & cold, etcetera.",
             "cartoon" : "Unhealthy_Character",
            "pros1" : "Reduce prolonged or heavy exertion outside.",
            "pros2" : "Take more breaks in between while performing outdoor activities.",
            "pros3" : "People who are sensitive should shift their activities indoors.",
            "pros4" : "People suffering from respiratory problems should spend time indoors.",
            "imgPros1" : "icon_hint_d",
            "imgPros2" : "icon_hint_l",
            "imgPros3" : "icon_hint_m",
            "imgPros4" : "icon_hint_n",
            
            "cons1" : "Do not get involved in strenuous physical activities outdoors.",
            "cons2" : "Do not step outside without taking precautionary measures.",
            "cons3" : "Sensitive people should avoid getting involved in prolonged or heavy exertion.",
            "cons4" : "People with respiratory problems should avoid being outdoors.",
            "imgCons1" : "icon_hint_i",
            "imgCons2" : "icon_hint_p",
            "imgCons3" : "icon_hint_k",
            "imgCons4" : "icon_hint_q"
        ]
        return data
    }
    else if status == "AQI_Severe"
    {
        data = [
            "details" : "With AQI levels reaching such a dangerous level, the deadly air pollutants are making their way in your lungs causing you severe discomfort and health issues.",
            
            "cartoon" : "Very unhealthy_Character",
            "pros1" : "Perform more indoor activities.",
            "pros2" : "Reschedule necessary outdoor activities to the time when air quality is comparatively better.",
            "pros3" : "People who are sensitive should shift their activities indoors.",
            "pros4" : "People suffering from respiratory problems should spend time indoors.",
            "imgPros1" : "icon_hint_s",
            "imgPros2" : "icon_hint_t",
            "imgPros3" : "icon_hint_m",
            "imgPros4" : "icon_hint_n",
            
            "cons1" : "Do not perform prolonged or heavy exertion at all.",
            "cons2" : "Do not step outside without taking precautionary measures.",
            "cons3" : "Sensitive people should avoid getting involved in prolonged or heavy exertion.",
            "cons4" : "Do not step outside without wearing air pollution protection mask.",
            "imgCons1" : "icon_hint_i",
            "imgCons2" : "icon_hint_p",
            "imgCons3" : "icon_hint_k",
            "imgCons4" : "icon_hint_r"
        ]
        return data
    }
    else if status == "AQI_Hazardous"
    {
        data = [
            "details" : "AQI level exceeding 401+ is highly unacceptable to the health. Lung cancer, chronic obstructive pulmonary disease, and emphysema are a few chronic health conditions caused by breathing poisonous air.",
            "cartoon" : "Hazardous_Character",
            "pros1" : "Try to stay indoors as much as possible.",
            "pros2" : "Keep medicines handy while going outside.",
            "pros3" : "Sensitive people should stay indoors and keep the level of their activities low.",
            "pros4" : "Take necessary measures to keep indoor air pollutants level low.",
            "imgPros1" : "icon_hint_s",
            "imgPros2" : "icon_hint_u",
            "imgPros3" : "icon_hint_m",
            "imgPros4" : "icon_hint_v",
            
            "cons1" : "Avoid all types of physical activities outside.",
            "cons2" : "Don’t indulge in any kind of exertion while being outdoors.",
            "cons3" : "Do not step outside the home without taking all precautionary measures.",
            "cons4" : "Do not step outside without wearing air pollution protection mask.",
            "imgCons1" : "icon_hint_i",
            "imgCons2" : "icon_hint_p",
            "imgCons3" : "icon_hint_w",
            "imgCons4" : "icon_hint_r"
        ]
        
        return data
    }
    else
    {
        data = [
            "details" : "When the AQI level (air quality index) is below 50, people are breathing fresh, clean air. People are no longer exposed to any health risk because the quality of air is pure.",
            "pros1" : "Be highly active outside and spend more time.",
            "pros2" : "Breathe as much fresh air as you can.",
            "pros3" : "Get involved in prolonged and heavy exertion.",
            "pros4" : "Try to use eco- friendly modes of transportation.",
            "imgPros1" : "icon_hint_a",
            "imgPros2" : "icon_hint_b",
            "imgPros3" : "icon_hint_d",
            "imgPros4" : "icon_hint_c",
            
            "cons1" : "Do not contaminate the ambient air.",
            "cons2" : "Do not use pollution emitting vehicles too much.",
            "cons3" : "Limit the usage of insecticides in agricultural activities.",
            "cons4" : "Do not burn the garbage.",
            "imgCons1" : "icon_hint_e",
            "imgCons2" : "icon_hint_f",
            "imgCons3" : "icon_hint_g",
            "imgCons4" : "icon_hint_h"
        ]
        
        return data
    }
}
