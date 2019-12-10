 
import Foundation

/**
 Runs a block in the main thread
 **/
public func runOnMainThread(block: @escaping () -> ()) {
    DispatchQueue.main.async {
        block()
    }
}

/**
 Runs a block in background
 */
public func runInBackground(block: @escaping () -> ()) {
    
    DispatchQueue.global(qos: .userInitiated).async {
        block()
    }
}

public func runOnMainThreadWithoutDeadlock(block: @escaping () -> ()) {
    
    if(Thread.isMainThread)
    {
        block()
    }
    else
    {
        runOnMainThread {
            block()
        }
    }
    
    
}


