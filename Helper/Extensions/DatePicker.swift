
import UIKit


class DatePicker:NSObject {
    
    static let sharedInstance: DatePicker = {
        let instance = DatePicker()
        return instance
    }()
    
    override init() {
        super.init()
    }
    
    let objDatePicker: UIDatePicker = UIDatePicker()
    public func showDateTimePicker(title:String,pickerMode:UIDatePickerMode,style:UIAlertControllerStyle,selectDate:@escaping (Date)->()) {
        
        let lblTitle:UILabel = UILabel(frame: CGRect(x: 0, y: 10.0, width: SCREENWIDTH() - 20, height: 25))
        let fd = UIFontDescriptor(name: "Helvetica Neue", size: 17)
        lblTitle.font = UIFont(descriptor: fd, size: 17)
        lblTitle.textColor = UIColor.darkText
       
        lblTitle.textAlignment = .center
        lblTitle.text = title
        objDatePicker.datePickerMode = pickerMode
        objDatePicker.timeZone = TimeZone.autoupdatingCurrent
        objDatePicker.frame = CGRect(x: 0, y: 38, width: SCREENWIDTH() - 20, height: 145)
        let alertController = UIAlertController(title: "", message: nil, preferredStyle: style)
   //     objDatePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        alertController.view.addSubview(lblTitle)
         alertController.view.addSubview(objDatePicker)
//        let btnOk = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(alert: UIAlertAction!) in
//            selectDate(self.objDatePicker.date)
//        })
        
        let okBtn = UIAlertAction(title: "Set Time", style: UIAlertActionStyle.cancel, handler: {(alert: UIAlertAction!) in
            selectDate(self.objDatePicker.date)
        })

      //  let btnCancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        
        alertController.addAction(okBtn)
       // alertController.addAction(btnCancel)
        
        let alertControllerHeight:NSLayoutConstraint = NSLayoutConstraint(item: alertController.view, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 250)
        alertController.view.addConstraint(alertControllerHeight);
        
        mostTopViewController?.present(alertController, animated: true)
    }
    
    let endtimePicker: UIDatePicker = UIDatePicker()
    func datePickerValueChanged(_ datePicker: UIDatePicker) {
        
        datePicker.minimumDate = Calendar.current.date(byAdding: .minute, value: 0, to: datePicker.date)
        // don't forget to add some checks (for example if your startPicker time is set to 23:59)
    }
    
    
    public func showEndTimePicker(title:String,pickerMode:UIDatePickerMode,style:UIAlertControllerStyle,selectDate:@escaping (Date)->()) {
        
        let lblTitle:UILabel = UILabel(frame: CGRect(x: 0, y: 10.0, width: SCREENWIDTH() - 20, height: 25))
        lblTitle.font = FontWithSize(FT_Regular, 17)
        lblTitle.textColor = UIColor.darkText
        
        lblTitle.textAlignment = .center
        lblTitle.text = title
        objDatePicker.datePickerMode = pickerMode
        //objDatePicker.timeZone = TimeZone.current
        objDatePicker.frame = CGRect(x: 0, y: 38, width: SCREENWIDTH() - 20, height: 145)
        let alertController = UIAlertController(title: "", message: nil, preferredStyle: style)
        alertController.view.addSubview(lblTitle)
        alertController.view.addSubview(objDatePicker)
        
        //        let btnOk = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(alert: UIAlertAction!) in
        //            selectDate(self.objDatePicker.date)
        //        })
        
        let okBtn = UIAlertAction(title: "Set Time", style: UIAlertActionStyle.cancel, handler: {(alert: UIAlertAction!) in
            selectDate(self.objDatePicker.date)
        })
       
        //  let btnCancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        alertController.addAction(okBtn)
        // alertController.addAction(btnCancel)
      
        let alertControllerHeight:NSLayoutConstraint = NSLayoutConstraint(item: alertController.view, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 250)
        alertController.view.addConstraint(alertControllerHeight);
        
        mostTopViewController?.present(alertController, animated: true)
    }
    
}
