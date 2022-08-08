
import Foundation
import UIKit

protocol OTPDelegate: AnyObject {
    //always triggers when the OTP field is valid
    func didChangeValidity(isValid: Bool)
}

enum Measure {
    case inch
    case cm
    case lb
    case kg
}

class OTPStackView: UIStackView {
    
    //Customise the OTPField here
    private var numberOfFields : Int?
    private var measureStyle : Measure!
    var textFieldsCollection: [OTPTextField] = []
    weak var delegate: OTPDelegate?
    
    //Colors
    let inactiveFieldBorderColor = Color.borderGray
    let textBackgroundColor = Color.background
    var remainingStrStack: [String] = []
    
    init(frame : CGRect, numberOfFields : Int, style : Measure) {
        super.init(frame: frame)
        setupStackView()
        self.numberOfFields = numberOfFields
        self.measureStyle = style
        addOTPFields()
        
        addLabel(style: style)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Customisation and setting stackView
    private final func setupStackView() {
        self.backgroundColor = .clear
        self.isUserInteractionEnabled = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.distribution = .fill
        self.alignment = .bottom
        self.axis = .horizontal
        self.spacing = 5
    }
    
    //Adding each OTPfield to stack view
    private final func addOTPFields() {
        guard let numberOfFields = numberOfFields else {
            return
        }
        
        for index in 0..<numberOfFields{
            let field = OTPTextField()
            setupTextField(field)
            textFieldsCollection.append(field)
            if measureStyle == .inch, index == 0 {
                addLabel(style: nil)
            }
            //Adding a marker to previous field
            index != 0 ? (field.previousTextField = textFieldsCollection[safe: index-1]) : (field.previousTextField = nil)
            //Adding a marker to next field for the field at index-1
            index != 0 ? (textFieldsCollection[safe: index-1]!.nextTextField = field) : ()
        }
        textFieldsCollection[0].becomeFirstResponder()
    }
    
    //Customisation and setting OTPTextFields
    private final func setupTextField(_ textField: OTPTextField){
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        self.addArrangedSubview(textField)
        //textField.addDoneButtonOnKeyboard()
        textField.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        textField.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        textField.widthAnchor.constraint(equalToConstant: 70).isActive = true
        textField.backgroundColor = textBackgroundColor
        textField.textAlignment = .center
        textField.adjustsFontSizeToFitWidth = false
        textField.font = Font.number
        textField.textColor = .black
        textField.layer.cornerRadius = 20
        textField.layer.borderWidth = 1
        textField.layer.borderColor = inactiveFieldBorderColor?.cgColor
        textField.keyboardType = .numberPad
        textField.autocorrectionType = .yes
        textField.textContentType = .oneTimeCode
    }
    
    private final func addLabel(style : Measure?) {
        let label = UILabel()
        label.font = Font.normal
        switch style {
        case .inch:
            label.text = Text.inch
        case .cm:
            label.text = Text.cm
        case .kg:
            label.text = Text.kg
        case .lb:
            label.text = Text.lb
        default:
            label.text = Text.ft
        }
        
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addArrangedSubview(label)
        label.topAnchor.constraint(equalTo: self.topAnchor, constant: 60).isActive = true
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
    }
    //gives the OTP text
    final func getOTP(sytle: Measure) -> (text: String,count: Int) {
        var OTP = ""
        let count: Int
        for textField in textFieldsCollection {
            OTP += textField.text ?? ""
        }
        switch sytle {
        case .inch:
            count = 90
            return (text: OTP,count: count)
        case .cm:
            count = 300
            return (text: OTP,count: count)
        case .lb:
            count = 100
            return (text: OTP,count: count)
        case .kg:
            count = 100
            return (text: OTP,count: count)
        }
    }
}

//MARK: - TextField Handling
extension OTPStackView: UITextFieldDelegate {
    
    //switches between OTPTextfields
    func textField(_ textField: UITextField, shouldChangeCharactersIn range:NSRange,
                   replacementString string: String) -> Bool {
        delegate?.didChangeValidity(isValid: false)
        guard let textField = textField as? OTPTextField else { return true }
        if string.count > 1 {
            textField.resignFirstResponder()
            return false
        } else {
            if (range.length == 0){
                if textField.nextTextField == nil {
                    textField.text? = string
                    textField.resignFirstResponder()
                    textField.becomeFirstResponder()
                    let textCount = Int(getOTP(sytle: measureStyle).text)!
                    let bound = getOTP(sytle: measureStyle).count
                    if textCount < bound && textCount > 0 {
                        delegate?.didChangeValidity(isValid: true)
                    }
                }else{
                    textField.text? = string
                    textField.nextTextField?.becomeFirstResponder()
                }
                return false
            }
            return true
        }
    }
}



