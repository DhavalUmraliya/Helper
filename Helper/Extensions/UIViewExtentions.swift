import UIKit
import Foundation
//extension UIView
//{
//    func dropShadow()
//    {
//        self.layer.masksToBounds = true
//        self.layer.shadowColor = UIColor.lightGray.cgColor
//        self.layer.shadowOpacity = 1
//        self.layer.shadowOffset = CGSize.zero
//        self.layer.shadowRadius = 5
//    }
//    func startRotating(duration: Double = 1)
//    {
//        let rotation = CABasicAnimation(keyPath: "transform.rotation")
//        rotation.fromValue = 0
//        rotation.toValue = 3 * M_PI
//        rotation.duration = 1.1
//      //  rotation.repeatCount = Float.infinity
//        self.layer.add(rotation, forKey: "Spin")
//    }
//    func stopRotating() {
//        let kAnimationKey = "Spin"
//        
//        if self.layer.animation(forKey: kAnimationKey) != nil {
//            self.layer.removeAnimation(forKey: kAnimationKey)
//        }
//    }
//}

enum pushFrom: String  {
    case kCATransitionFromTop
    case kCATransitionFromBottom
    case kCATransitionFromRight
    case kCATransitionFromLeft
}

extension UIView {
    func takeScreenshot(_ btn : UIButton) -> UIImage {
  
        // Begin context
        btn.isHidden = true
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        
        // Draw view in that context
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        
        // And finally, get image
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if (image != nil)
        {
            btn.isHidden = false
            return image!
        }
       
        return UIImage()
    }
    
    func pushTransition(_ duration:CFTimeInterval) {
        let animation:CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            kCAMediaTimingFunctionEaseInEaseOut)
        animation.type = kCATransitionPush
        animation.subtype = kCATransitionFromTop
        animation.duration = duration
        layer.add(animation, forKey: kCATransitionPush)
    }
    
    func pushTransition(_ duration:CFTimeInterval, setAnimation: String ) {
        let animation:CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            kCAMediaTimingFunctionEaseInEaseOut)
        animation.type = kCATransitionPush
      
        animation.subtype = setAnimation as String
        animation.duration = duration
        layer.add(animation, forKey: kCATransitionPush)
    }
    
//    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
//        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
//        let mask = CAShapeLayer()
//        mask.path = path.cgPath
//        layer.mask = mask
//    }
}

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

extension UIViewController {
    
    
    func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "OpenSans-Regular", size: 10.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 50;
        toastLabel.clipsToBounds  =  true
        
            self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.5, options: .curveEaseOut, animations: {
        toastLabel.alpha = 0.0
        
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    func HIDE_Keyboard() {
        view.endEditing(true)
    }
}

