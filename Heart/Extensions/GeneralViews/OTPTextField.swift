import UIKit

class OTPTextField: UITextField {
  weak var previousTextField: OTPTextField?
  weak var nextTextField: OTPTextField?
    
  override public func deleteBackward(){
    text = ""
    previousTextField?.becomeFirstResponder()
   }
}
