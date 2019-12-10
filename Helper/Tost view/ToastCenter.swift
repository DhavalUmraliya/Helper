
import UIKit

@objc open class ToastCenter: NSObject {

    fileprivate var _queue: OperationQueue!

    fileprivate struct Singletone {
        static let defaultCenter = ToastCenter()
    }
    
    open class func defaultCenter() -> ToastCenter {
        return Singletone.defaultCenter
    }
    
    override init() {
        super.init()
        self._queue = OperationQueue()
        self._queue.maxConcurrentOperationCount = 1
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(ToastCenter.deviceOrientationDidChange(_:)),
            name: NSNotification.Name.UIDeviceOrientationDidChange,
            object: nil
        )
    }
    
    open func addToast(_ toast: Toast) {
        self._queue.addOperation(toast)
    }
    
    @objc func deviceOrientationDidChange(_ sender: AnyObject?) {
        if self._queue.operations.count > 0 {
            let lastToast: Toast = _queue.operations[0] as! Toast
            lastToast.view.updateView()
           
        }
    }
}
