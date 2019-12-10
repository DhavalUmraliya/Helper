

import UIKit

protocol ImagePickerDelegate {
    func pickImageComplete(_ imageData: UIImage,sender:String)
}

class ImagePicker: NSObject,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    var delegate: ImagePickerDelegate?
    var senderName = String()
    let imagePicker = UIImagePickerController()
    var alertVC = UIAlertController()
    static let sharedInstance: ImagePicker = {
        let instance = ImagePicker()
        return instance
    }()
    
    override init() {
        super.init()
        
    }
    
    func selectImage(sender:String)
    {
        alertVC = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        
        //views.tapHandler = { _ in SwiftMessages.hide() }
        
        // alertVC.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
        senderName = sender
        let lblTitle:UILabel = UILabel(frame: CGRect(x: 0, y: 15.0, width: SCREENWIDTH() - 20, height: 25))
        lblTitle.font = FontWithSize(FT_Regular, 15)
        lblTitle.textAlignment = .center
        lblTitle.text = "Select Image"
        alertVC.view.addSubview(lblTitle)
     
        let btnGalleryImage:UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 70, height: 70))
        btnGalleryImage.setBackgroundImage(UIImage(named: "galleryicon"), for: .normal)
        btnGalleryImage.addTarget(self, action: #selector(ImagePicker.btnGalleryImage), for: UIControlEvents.touchUpInside)
        
        let btnCameraImage:UIButton = UIButton(frame: CGRect(x: 90, y: 0, width: 70, height: 70))
        btnCameraImage.setBackgroundImage(UIImage(named: "cameraicon"), for: .normal)
        btnCameraImage.addTarget(self, action: #selector(ImagePicker.btnCameraImage), for: UIControlEvents.touchUpInside)
        
        let view = UIView(frame: CGRect(x: (SCREENWIDTH() / 2) - 90, y: 60, width: 190, height: 100))
        view.addSubview(btnGalleryImage)
        view.addSubview(btnCameraImage)
        alertVC.view.addSubview(view)
        
        let close  = UIAlertAction(title: "Close", style: .cancel, handler: nil)
        alertVC.addAction(close)
        
        let alertControllerHeight:NSLayoutConstraint = NSLayoutConstraint(item: alertVC.view, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 200)
        alertVC.view.addConstraint(alertControllerHeight);
        alertVC.view.superview?.isUserInteractionEnabled = true
        alertVC.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(alertClose)))
      mostTopViewController?.present(alertVC, animated: true)
    
    }
    
    @objc func alertClose(gesture: UITapGestureRecognizer) {
        alertVC.dismiss(animated: true)
    }
    
     @objc func btnGalleryImage() {
        alertVC.dismiss(animated: true) {
            self.imagePicker.delegate = self
            self.imagePicker.allowsEditing = false
            self.imagePicker.sourceType = .photoLibrary
            mostTopViewController?.present(self.imagePicker, animated: true, completion: nil)
        }
    }
    
    @objc func btnCameraImage() {
        alertVC.dismiss(animated: true) {
            self.imagePicker.delegate = self
            self.imagePicker.allowsEditing = false
            self.imagePicker.sourceType = .camera
            mostTopViewController?.present(self.imagePicker, animated: true, completion: nil)
        }
    }

    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            let imgData : NSData = UIImageJPEGRepresentation(pickedImage,0.5)! as NSData
            delegate?.pickImageComplete(UIImage.init(data: (imgData as Data?)!)!,sender: senderName)
        }
        
        mostTopViewController?.dismiss(animated: true, completion: nil)
        
    }
}
