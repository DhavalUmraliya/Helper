
import UIKit

public let ToastViewBackgroundColorAttributeName = "ToastViewBackgroundColorAttributeName"
public let ToastViewCornerRadiusAttributeName = "ToastViewCornerRadiusAttributeName"
public let ToastViewTextInsetsAttributeName = "ToastViewTextInsetsAttributeName"
public let ToastViewTextColorAttributeName = "ToastViewTextColorAttributeName"
public let ToastViewFontAttributeName = "ToastViewFontAttributeName"
public let ToastViewPortraitOffsetYAttributeName = "ToastViewPortraitOffsetYAttributeName"
public let ToastViewLandscapeOffsetYAttributeName = "ToastViewLandscapeOffsetYAttributeName"

@objc open class ToastView: UIView {
    
    var backgroundView: UIView!
    var textLabel: UILabel!
    var textInsets: UIEdgeInsets!
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let userInterfaceIdiom = UIDevice.current.userInterfaceIdiom
        self.isUserInteractionEnabled = false
        self.backgroundView = UIView()
        self.backgroundView.frame = self.bounds
        self.backgroundView.backgroundColor = type(of: self).defaultValueForAttributeName(
            ToastViewBackgroundColorAttributeName,
            forUserInterfaceIdiom: userInterfaceIdiom
            ) as? UIColor
        self.backgroundView.layer.cornerRadius = CGFloat(truncating: type(of: self).defaultValueForAttributeName(
            ToastViewCornerRadiusAttributeName,
            forUserInterfaceIdiom: userInterfaceIdiom
            ) as! NSNumber)
        self.backgroundView.clipsToBounds = true
        self.addSubview(self.backgroundView)
        
        self.textLabel = UILabel()
        self.textLabel.frame = self.bounds
        self.textLabel.textColor = type(of: self).defaultValueForAttributeName(
            ToastViewTextColorAttributeName,
            forUserInterfaceIdiom: userInterfaceIdiom
            ) as? UIColor
        self.textLabel.backgroundColor = UIColor.clear
        self.textLabel.font = type(of: self).defaultValueForAttributeName(
            ToastViewFontAttributeName,
            forUserInterfaceIdiom: userInterfaceIdiom
            ) as! UIFont
        self.textLabel.numberOfLines = 0
        self.textLabel.textAlignment = .center;
        self.addSubview(self.textLabel)
        self.textInsets = (type(of: self).defaultValueForAttributeName(
            ToastViewTextInsetsAttributeName,
            forUserInterfaceIdiom: userInterfaceIdiom
            ) as! NSValue).uiEdgeInsetsValue
    }
    
    required convenience public init?(coder aDecoder: NSCoder) {
        self.init()
    }
    func updateView() {
        let deviceWidth = UIScreen.main.bounds.width
        let constraintSize = CGSize(width: deviceWidth * (280.0 / 320.0), height: CGFloat.greatestFiniteMagnitude)
        let textLabelSize = self.textLabel.sizeThatFits(constraintSize)
        self.textLabel.frame = CGRect(
            x: self.textInsets.left,
            y: self.textInsets.top,
            width: textLabelSize.width,
            height: textLabelSize.height
        )
        self.backgroundView.frame = CGRect(
            x: 0,
            y: 0,
            width: self.textLabel.frame.size.width + self.textInsets.left + self.textInsets.right,
            height: self.textLabel.frame.size.height + self.textInsets.top + self.textInsets.bottom
        )
        
        var x: CGFloat
        var y: CGFloat
        var width:CGFloat
        var height:CGFloat
        
        let screenSize = UIScreen.main.bounds.size
        let backgroundViewSize = self.backgroundView.frame.size
        
        let orientation = UIApplication.shared.statusBarOrientation
        let systemVersion = (UIDevice.current.systemVersion as NSString).floatValue
        
        let userInterfaceIdiom = UIDevice.current.userInterfaceIdiom
        let portraitOffsetY = CGFloat(truncating: type(of: self).defaultValueForAttributeName(
            ToastViewPortraitOffsetYAttributeName,
            forUserInterfaceIdiom: userInterfaceIdiom
            ) as! NSNumber )
        let landscapeOffsetY = CGFloat(truncating: type(of: self).defaultValueForAttributeName(
            ToastViewLandscapeOffsetYAttributeName,
            forUserInterfaceIdiom: userInterfaceIdiom
            ) as! NSNumber )
        
        if UIInterfaceOrientationIsLandscape(orientation) && systemVersion < 8.0 {
            width = screenSize.height
            height = screenSize.width
            y = landscapeOffsetY
        } else {
            width = screenSize.width
            height = screenSize.height
            if UIInterfaceOrientationIsLandscape(orientation) {
                y = landscapeOffsetY
            } else {
                y = portraitOffsetY
            }
        }
        
        x = (width - backgroundViewSize.width) * 0.5
        y = height - (backgroundViewSize.height + y)
        self.frame = CGRect(x: x, y: y, width: backgroundViewSize.width, height: backgroundViewSize.height);
    }
    
    override open func hitTest(_ point: CGPoint, with event: UIEvent!) -> UIView? {
        if let superview = self.superview {
            let pointInWindow = self.convert(point, to: superview)
            let contains = self.frame.contains(pointInWindow)
            if contains && self.isUserInteractionEnabled {
                return self
            }
        }
        return nil
    }
}
public extension ToastView {
    fileprivate struct Singleton {
        static var defaultValues: [String: [UIUserInterfaceIdiom: AnyObject]] = [
            // backgroundView.color
            ToastViewBackgroundColorAttributeName: [
                .unspecified: UIColor(white: 0, alpha: 0.7)
            ],
            
            // backgroundView.layer.cornerRadius
            ToastViewCornerRadiusAttributeName: [
                .unspecified: 5 as AnyObject
            ],
            
            ToastViewTextInsetsAttributeName: [
                .unspecified: NSValue(uiEdgeInsets: UIEdgeInsets(top: 6, left: 10, bottom: 6, right: 10))
            ],
            
            // textLabel.textColor
            ToastViewTextColorAttributeName: [
                .unspecified: UIColor.white
            ],
            
            // textLabel.font
            ToastViewFontAttributeName: [
                .unspecified: UIFont.systemFont(ofSize: 12),
                .phone: UIFont.systemFont(ofSize: 12),
                .pad: UIFont.systemFont(ofSize: 16),
            ],
            
            ToastViewPortraitOffsetYAttributeName: [
                .unspecified: 30 as AnyObject,
                .phone: 30 as AnyObject,
                .pad: 60 as AnyObject,
            ],
            ToastViewLandscapeOffsetYAttributeName: [
                .unspecified: 20 as AnyObject,
                .phone: 20 as AnyObject,
                .pad: 40 as AnyObject,
            ],
            ]
    }
    
    class func defaultValueForAttributeName(_ attributeName: String,
                                            forUserInterfaceIdiom userInterfaceIdiom: UIUserInterfaceIdiom)
        -> AnyObject {
            let valueForAttributeName = Singleton.defaultValues[attributeName]!
            if let value: AnyObject = valueForAttributeName[userInterfaceIdiom] {
                return value
            }
            return valueForAttributeName[.unspecified]!
    }
    
    class func setDefaultValue(_ value: AnyObject,
                               forAttributeName attributeName: String,
                               userInterfaceIdiom: UIUserInterfaceIdiom) {
        var values = Singleton.defaultValues[attributeName]!
        values[userInterfaceIdiom] = value
        Singleton.defaultValues[attributeName] = values
    }
}
