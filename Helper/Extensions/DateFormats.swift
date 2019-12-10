//
//  DateFormats.swift
//  SwiftDemo
//


import Foundation

public let GLOBAL_DATE_FORMAT: String = "yyyy-MM-dd HH:mm:ss"
public let ONLY_DATE_FORMAT: String = "yyyy-MM-dd"
public let ONLY_TIME_FORMAT: String = "HH:mm:00"
public let ONLY_DATE_TIME_FORMAT: String = "yyyy-MM-dd HH:mm:00"
public let BIRTH_DATE_FORMAT: String = "yyyy-MM-dd"
public let ONLY_DATE_MONTH_FORMAT: String = "dd/MM"
public let FULL_DATE_FORMAT: String = "dd MMM yyyy hh:mm a"
public let FB_BIRTH_DATE_FORMAT: String = "MM/dd/yyyy"
public let DIFF_DATE_FORMAT: String = "EEE d MMM yyyy"
public let ONLY_TIME_FORMAT_12HRS: String = "hh:mm a"
public let ONLY_MinTIME_FORMAT_12HRS: String = "mm"
public let DATE_FOR_CHAT: String = "MMM dd, yyyy"

class DateFormater {
    
    private static let sharedInstance = DateFormater()
    private var gameScore: Int = 0
    
    var sharedDateFormat : DateFormatter? = nil
    
    // METHODS
    private init() {
        self.sharedDateFormat = DateFormatter()
        self.sharedDateFormat!.timeZone = NSTimeZone.system
        let enUSPOSIXLocale: NSLocale = NSLocale(localeIdentifier: "en_US_POSIX")
        self.sharedDateFormat!.locale = enUSPOSIXLocale as Locale?
    }

  //MARK: Convert To Local TimeZone
  
   class func convertDateToLocalTimeZone(givenDate: String) -> String {
        var final_date: String
        self.sharedInstance.sharedDateFormat!.dateFormat = GLOBAL_DATE_FORMAT
    self.sharedInstance.sharedDateFormat!.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        //SET TIME ZONE FORMAT OF SERVER HERE
        let ts_utc: NSDate = self.sharedInstance.sharedDateFormat!.date(from: givenDate)! as NSDate
        self.sharedInstance.sharedDateFormat!.timeZone = NSTimeZone.system
        self.sharedInstance.sharedDateFormat!.dateFormat = GLOBAL_DATE_FORMAT
        final_date = self.sharedInstance.sharedDateFormat!.string(from: ts_utc as Date)
        return final_date
    }
    
    class func convertDateToLocalTimeZoneForDate(givenDate: NSDate) -> NSDate {
        self.sharedInstance.sharedDateFormat!.dateFormat = GLOBAL_DATE_FORMAT
        self.sharedInstance.sharedDateFormat!.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        //SET TIME ZONE FORMAT OF SERVER HERE
        let strDate: String = self.sharedInstance.sharedDateFormat!.string(from: givenDate as Date)
        self.sharedInstance.sharedDateFormat!.timeZone = NSTimeZone.local
        self.sharedInstance.sharedDateFormat!.dateFormat = GLOBAL_DATE_FORMAT
        return self.sharedInstance.sharedDateFormat!.date(from: strDate)! as NSDate
    }
    
    class func convertDateToLocalTimeZoneForDateFromString(givenDate: String) -> NSDate {
        self.sharedInstance.sharedDateFormat!.dateFormat = GLOBAL_DATE_FORMAT
        self.sharedInstance.sharedDateFormat!.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        //SET TIME ZONE FORMAT OF SERVER HERE
        return self.sharedInstance.sharedDateFormat!.date(from: givenDate)! as NSDate
    }
    
    class func convertLocalDateTimeToServerTimeZone(givenDate: String) -> String {
        let final_date: String
        self.sharedInstance.sharedDateFormat!.dateFormat = GLOBAL_DATE_FORMAT
        self.sharedInstance.sharedDateFormat!.timeZone = NSTimeZone.system
        let ts_utc: NSDate = self.sharedInstance.sharedDateFormat!.date(from: givenDate)! as NSDate
        self.sharedInstance.sharedDateFormat!.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        self.sharedInstance.sharedDateFormat!.dateFormat = GLOBAL_DATE_FORMAT
        final_date = self.sharedInstance.sharedDateFormat!.string(from: ts_utc as Date)
        return final_date
    }
    
    class func generateDateForGivenDateToServerTimeZone(givenDate: NSDate) -> String {
        self.sharedInstance.sharedDateFormat!.dateFormat = ONLY_DATE_TIME_FORMAT
        self.sharedInstance.sharedDateFormat!.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        //SET TIME ZONE FORMAT OF SERVER HERE
        return self.sharedInstance.sharedDateFormat!.string(from: givenDate as Date)
    }
    
    class func getUTCDateFromUTCString(givenDate: String) -> NSDate {
        self.sharedInstance.sharedDateFormat!.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        self.sharedInstance.sharedDateFormat!.dateFormat = GLOBAL_DATE_FORMAT
        return self.sharedInstance.sharedDateFormat!.date(from: givenDate)! as NSDate
    }
    
    //MARK: Common Formats
    class func getStringFromDateString(givenDate: String) -> String {
        self.sharedInstance.sharedDateFormat!.timeZone = NSTimeZone.system
        self.sharedInstance.sharedDateFormat!.dateFormat = GLOBAL_DATE_FORMAT
        let date: NSDate = self.sharedInstance.sharedDateFormat!.date(from: givenDate)! as NSDate
        self.sharedInstance.sharedDateFormat!.dateFormat = GLOBAL_DATE_FORMAT
        return self.sharedInstance.sharedDateFormat!.string(from: date as Date)
    }
    
    class func getStringFromDate(givenDate: NSDate) -> String {
        self.sharedInstance.sharedDateFormat!.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        self.sharedInstance.sharedDateFormat!.dateFormat = ONLY_DATE_FORMAT
        return self.sharedInstance.sharedDateFormat!.string(from: givenDate as Date)
    }
    
   
    
    class func getFullDateStringFromDate(givenDate: NSDate) -> String {
        self.sharedInstance.sharedDateFormat!.timeZone = NSTimeZone.system
        self.sharedInstance.sharedDateFormat!.dateFormat = FULL_DATE_FORMAT
        return self.sharedInstance.sharedDateFormat!.string(from: givenDate as Date)
    }
    
    class func getFullDateStringFromString(givenDate: String) -> String {
        self.sharedInstance.sharedDateFormat!.timeZone = NSTimeZone.system
        self.sharedInstance.sharedDateFormat!.dateFormat = GLOBAL_DATE_FORMAT
        let date: NSDate = self.sharedInstance.sharedDateFormat!.date(from: givenDate)! as NSDate
        self.sharedInstance.sharedDateFormat!.dateFormat = FULL_DATE_FORMAT
        return self.sharedInstance.sharedDateFormat!.string(from: date as Date)
    }
    
    class func getDateFromStringInLocalTimeZone(givenDate: String) -> NSDate
    {
        self.sharedInstance.sharedDateFormat!.dateFormat = GLOBAL_DATE_FORMAT
        return self.sharedInstance.sharedDateFormat!.date(from: givenDate)! as NSDate
    }
    
    class func getDateFromString(givenDate: String) -> NSDate
    {
        self.sharedInstance.sharedDateFormat!.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        self.sharedInstance.sharedDateFormat!.dateFormat = GLOBAL_DATE_FORMAT
        return self.sharedInstance.sharedDateFormat!.date(from: givenDate)! as NSDate
    }
    
    class func getDateFromDate(givenDate: NSDate) -> NSDate {
        self.sharedInstance.sharedDateFormat!.timeZone = NSTimeZone.system
        self.sharedInstance.sharedDateFormat!.dateFormat = GLOBAL_DATE_FORMAT
        let strDate: String = self.sharedInstance.sharedDateFormat!.string(from: givenDate as Date)
        self.sharedInstance.sharedDateFormat!.dateFormat = GLOBAL_DATE_FORMAT
        return self.sharedInstance.sharedDateFormat!.date(from: strDate)! as NSDate
    }
    
    //MARK: Timestamp Formats
    class func getTimestampUTC() -> String {
        self.sharedInstance.sharedDateFormat!.timeZone = NSTimeZone(name:"UTC") as TimeZone?
        self.sharedInstance.sharedDateFormat!.dateFormat = GLOBAL_DATE_FORMAT
        return self.sharedInstance.sharedDateFormat!.string(from: NSDate() as Date)
    }
    
    class func getTimestampFromGivenDate(givenDate: String) -> NSDate {
        self.sharedInstance.sharedDateFormat!.timeZone = NSTimeZone(name:"UTC") as TimeZone?
        self.sharedInstance.sharedDateFormat!.dateFormat = GLOBAL_DATE_FORMAT
        return self.sharedInstance.sharedDateFormat!.date(from: givenDate)! as NSDate
    }
    
    //MARK: Generate Date
    class func generateDateForGivenDate(strDate: NSDate, andTime strTime: NSDate) -> String {
        self.sharedInstance.sharedDateFormat!.timeZone = NSTimeZone.system
        self.sharedInstance.sharedDateFormat!.dateFormat = ONLY_DATE_FORMAT
        let dt: String = self.sharedInstance.sharedDateFormat!.string(from: strDate as Date)
        self.sharedInstance.sharedDateFormat!.dateFormat = ONLY_TIME_FORMAT
        let tm: String = self.sharedInstance.sharedDateFormat!.string(from: strTime as Date)
        return "\(dt) \(tm)"
    }
    
    //MARK: Generate Date
    class func generateTimeForGivenDate(strDate: String) -> String {
        self.sharedInstance.sharedDateFormat!.timeZone = NSTimeZone.system
        self.sharedInstance.sharedDateFormat!.dateFormat = BIRTH_DATE_FORMAT
        return  self.sharedInstance.sharedDateFormat!.string(from: (self.sharedInstance.sharedDateFormat?.date(from: strDate))!)
    }
    
    //MARK: Generate Minutes
    
    class func generateMinutesTimeForGivenDate(strDate: NSDate) -> String {
        self.sharedInstance.sharedDateFormat!.timeZone = NSTimeZone.system
        self.sharedInstance.sharedDateFormat!.dateFormat = ONLY_MinTIME_FORMAT_12HRS
        let tm: String = self.sharedInstance.sharedDateFormat!.string(from: strDate as Date)
        return "\(tm) Minute"
    }
    class func generateDateForGivenDate(strDate: NSDate) -> String {
        self.sharedInstance.sharedDateFormat!.timeZone = NSTimeZone.system
        self.sharedInstance.sharedDateFormat!.dateFormat = ONLY_DATE_TIME_FORMAT
        return self.sharedInstance.sharedDateFormat!.string(from: strDate as Date)
    }
    
    
    
    class func generateProfileDateForGivenString(strDate: String) -> Date {
        self.sharedInstance.sharedDateFormat!.timeZone = NSTimeZone.system
        self.sharedInstance.sharedDateFormat!.dateFormat = BIRTH_DATE_FORMAT
        return self.sharedInstance.sharedDateFormat!.date(from: strDate)!
    }
    
    //MARK: Birth Date
    class func getBirthDateFromString(givenDate: String) -> NSDate {
        self.sharedInstance.sharedDateFormat!.timeZone = NSTimeZone.system
        self.sharedInstance.sharedDateFormat!.dateFormat = ONLY_DATE_FORMAT
        return self.sharedInstance.sharedDateFormat!.date(from: givenDate)! as NSDate
    }
    
    class func getBirthDateStringFromDateString(givenDate: String) -> String {
        self.sharedInstance.sharedDateFormat!.timeZone = NSTimeZone.system
        self.sharedInstance.sharedDateFormat!.dateFormat = ONLY_DATE_FORMAT
        let date: NSDate = self.sharedInstance.sharedDateFormat!.date(from: givenDate)! as NSDate
        self.sharedInstance.sharedDateFormat!.dateFormat = DIFF_DATE_FORMAT
        return self.sharedInstance.sharedDateFormat!.string(from: date as Date)
    }
    
    
    class func birthdayConstraintForUser(givenDate: NSDate) -> NSDate {
        
        let dateComponents: NSDateComponents = NSDateComponents()
        dateComponents.year = -2
        
        let expirationDate = NSCalendar.current.date(byAdding: dateComponents as DateComponents, to: givenDate as Date)
        return expirationDate! as NSDate
    }
    
    class func minBirthdayConstraintForUser(givenDate: NSDate) -> NSDate {
        let dateComponents: NSDateComponents = NSDateComponents()
        dateComponents.year = -100
        let expirationDate = NSCalendar.current.date(byAdding: dateComponents as DateComponents, to: givenDate as Date)
        return expirationDate! as NSDate
    }
    
    class func minViolationDateConstraintForUser(givenDate: NSDate) -> NSDate {
        let dateComponents: NSDateComponents = NSDateComponents()
        dateComponents.year = -1
        let expirationDate = NSCalendar.current.date(byAdding: dateComponents as DateComponents, to: givenDate as Date)
        return expirationDate! as NSDate
    }
    
    class func generateBirthDateForGivenDate(strDate: NSDate) -> String {
        self.sharedInstance.sharedDateFormat!.timeZone = NSTimeZone.system
        self.sharedInstance.sharedDateFormat!.dateFormat = BIRTH_DATE_FORMAT
        return self.sharedInstance.sharedDateFormat!.string(from: strDate as Date)
    }
    
    class func generateBirthDateForGivenFacebookDate(strDate: String) -> NSDate {
        self.sharedInstance.sharedDateFormat!.timeZone = NSTimeZone.system
        self.sharedInstance.sharedDateFormat!.dateFormat = FB_BIRTH_DATE_FORMAT
        return self.sharedInstance.sharedDateFormat!.date(from: strDate)! as NSDate
    }
    
    class func getStringDateWithSuffix(givenDate: String) -> String {
        //Convert EEE dd MMM yyyy formate
        self.sharedInstance.sharedDateFormat!.timeZone = NSTimeZone.system
        self.sharedInstance.sharedDateFormat!.dateFormat = GLOBAL_DATE_FORMAT
        let date: NSDate = self.sharedInstance.sharedDateFormat!.date(from: givenDate)! as NSDate
        self.sharedInstance.sharedDateFormat!.dateFormat = DIFF_DATE_FORMAT
        var strDate: String = self.sharedInstance.sharedDateFormat!.string(from: date as Date)
        //To get only date from string
        let monthDayFormatter: DateFormatter = DateFormatter()
        monthDayFormatter.formatterBehavior = .behavior10_4
        
        monthDayFormatter.dateFormat = "d"
        let date_day: Int = Int(monthDayFormatter.string(from: date as Date))!
        monthDayFormatter.dateFormat = "yyyy"
        let date_year: Int = Int(monthDayFormatter.string(from: date as Date))!
        strDate = strDate.replacingOccurrences(of: "\(date_year)", with: "")
        //Add suffix
        var suffix: NSString?
        let ones: Int = date_day % 10
        let tens: Int = (date_day / 10) % 10
        if tens == 1 {
            suffix = "th"
        }
        else if ones == 1 {
            suffix = "st"
        }
        else if ones == 2 {
            suffix = "nd"
        }
        else if ones == 3 {
            suffix = "rd"
        }
        else {
            suffix = "th"
        }
        
        strDate = strDate.replacingOccurrences(of: "\(date_day)", with: "\(date_day)\(suffix ?? "th")")
        strDate = "\(strDate)\(date_year)"
        return strDate
        
    }
    
    class func convertFaceBookDateIntoString(givenDate: String) -> String {
        
        self.sharedInstance.sharedDateFormat!.timeZone = NSTimeZone.system
        self.sharedInstance.sharedDateFormat!.dateFormat = FB_BIRTH_DATE_FORMAT
        let date: NSDate = self.sharedInstance.sharedDateFormat!.date(from: givenDate)! as NSDate
        self.sharedInstance.sharedDateFormat!.dateFormat = ONLY_DATE_FORMAT
        return self.sharedInstance.sharedDateFormat!.string(from: date as Date)
    }
    
    class func convertdateIntoArabic(givenDate: String) -> String {
        
        self.sharedInstance.sharedDateFormat!.timeZone = NSTimeZone.system
        
        // initialize formatter and set input date format
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        // read input date string as NSDate instance
        let date = DateFormater.getDateFromString(givenDate: givenDate)
        
        // set locale to "ar_DZ" and format as per your specifications
        formatter.locale = NSLocale(localeIdentifier: "ar_DZ") as Locale?
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let outputDate = formatter.string(from: date as Date)
        
        return outputDate
    }
    
    func timeAgoSinceDate(_ dateStr:String, numericDates:Bool) -> String
    {
        let calendar = Calendar.current
        let now = NSDate()
        let currentDate = calendar.date(byAdding: .second, value: 3, to: now as Date)
        
        let date = DateFormater.getDateFromString(givenDate: dateStr)
        let earliest = (now as NSDate).earlierDate(date as Date)
        let latest = (earliest == now as Date) ? date : now
        let components:DateComponents = (calendar as NSCalendar).components([NSCalendar.Unit.minute , NSCalendar.Unit.hour , NSCalendar.Unit.day , NSCalendar.Unit.weekOfYear , NSCalendar.Unit.month , NSCalendar.Unit.year , NSCalendar.Unit.second], from: earliest, to: latest as Date, options: NSCalendar.Options())
        
        
        if(date.compare(currentDate! as Date) == .orderedDescending)
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMMM"
            return dateFormatter.string(from: date as Date)
        }
        else if(date.compare(currentDate! as Date) == .orderedSame)
        {
            return "Just now"
        }
        else
        {
            //        print("date is smaller than current date ")
            //        print("Compoments year: \(components.year)")
            //        print("Compoments month: \(components.month)")
            //        print("Compoments weekOfYear: \(components.weekOfYear)")
            //        print("Compoments day: \(components.day)")
            //        print("Compoments hour: \(components.hour)")
            //        print("Compoments minute: \(components.minute)")
            //        print("Compoments second: \(components.second)")
            
            if (components.year! >= 2)
            {
                return "\(components.year!) yrs ago"
            }
            else if (components.year! >= 1)
            {
                if (numericDates)
                {
                    return "1 yr ago"
                }
                else
                {
                    return "Last year"
                }
            }
            else if (components.month! >= 2)
            {
                return "\(components.month!) mnths ago"
            }
            else if (components.month! >= 1)
            {
                if (numericDates)
                {
                    return "1 month ago"
                }
                else
                {
                    return "Last month"
                }
            }
            else if (components.weekOfYear! >= 2)
            {
                return "\(components.weekOfYear!) weeks ago"
            }
            else if (components.weekOfYear! >= 1)
            {
                if (numericDates)
                {
                    return "1 week ago"
                }
                else
                {
                    return "Last week"
                }
            }
            else if (components.day! >= 2)
            {
                return "\(components.day!) days ago"
            }
            else if (components.day! >= 1)
            {
                if (numericDates)
                {
                    return "1 day ago"
                }
                else
                {
                    return "Yesterday"
                }
            }
            else if (components.hour! >= 2)
            {
                return "\(components.hour!) hrs ago"
            }
            else if (components.hour! >= 1)
            {
                if (numericDates)
                {
                    return "1 hr ago"
                } else {
                    return "An hr ago"
                }
            }
            else if (components.minute! >= 2)
            {
                return "\(components.minute!) mins ago"
            }
            else if (components.minute! >= 1)
            {
                if (numericDates)
                {
                    return "1 min ago"
                } else {
                    return "A min ago"
                }
            }
            else if (components.second! >= 3)
            {
                return "\(components.second!) secs ago"
            }
            else
            {
                return "Just now"
            }
        }
    }
}
