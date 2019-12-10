
import Foundation
import UIKit
import QuartzCore
import AVFoundation

let kPlaceholderRightPadding: CGFloat  = 10.0;

public extension UIActivity.ActivityType {
    
    /// SwifterSwift: AddToiCloudDrive
    public static let addToiCloudDrive = UIActivity.ActivityType("com.apple.CloudDocsUI.AddToiCloudDrive")
    
    /// SwifterSwift: WhatsApp share extension
    public static let postToWhatsApp = UIActivity.ActivityType("net.whatsapp.WhatsApp.ShareExtension")
    
    /// SwifterSwift: LinkedIn share extension
    public static let postToLinkedIn = UIActivity.ActivityType("com.linkedin.LinkedIn.ShareExtension")
    
    /// SwifterSwift: XING share extension
    public static let postToXing = UIActivity.ActivityType("com.xing.XING.Xing-Share")
    
}

public extension UITableView {
    

    func getLabel() -> UILabel {
        let lblEmpty: UILabel = UILabel(frame: CGRect(x:kPlaceholderRightPadding, y:kPlaceholderRightPadding, width:self.frame.width - kPlaceholderRightPadding - kPlaceholderRightPadding, height:self.frame.height - kPlaceholderRightPadding))
        lblEmpty.numberOfLines = 3
        lblEmpty.textAlignment = .center
        lblEmpty.lineBreakMode = .byWordWrapping
        lblEmpty.font = UIFont.systemFont(ofSize: 15.0)//THEME_FONT_MEDIUM(15.0)
        lblEmpty.sizeThatFits(lblEmpty.frame.size)
        return lblEmpty
    }
    
    func reloadDataWithPlaceholderImage(placeholderImage: UIImage?) {
        self.backgroundView = nil
        if self.numberOfSections == 0 || (self.numberOfRows(inSection: 0) == 0 || self.numberOfRows(inSection: 0) == NSNotFound) {
            if placeholderImage != nil {
                let img: UIImageView = UIImageView(frame: self.frame)
                img.image = placeholderImage
                img.backgroundColor = UIColor.clear
                img.contentMode = .scaleAspectFit
                self.backgroundView = img
            }
        }
        else
        {
            self.backgroundView = nil
        }
        self.reloadData()
    }
    
    func isLast(for indexPath: IndexPath) -> Bool {
        
        let indexOfLastSection = numberOfSections > 0 ? numberOfSections - 1 : 0
        let indexOfLastRowInLastSection = numberOfRows(inSection: indexOfLastSection) - 1
        return indexPath.section == indexOfLastSection && indexPath.row == indexOfLastRowInLastSection
    
    }
      
}


