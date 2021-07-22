//
//  ReusableInputView.swift
//  LTAP
//
//  Created by APPLE on 19/04/21.
//

import Foundation

protocol ReusableViewDelegate: class {
    func buttonClicked(_ sender : UIButton)
}

class ReusableInputView: UIView {
    
    //MARK: IBOutlets
   
    @IBOutlet weak var txtInput: UITextField!
    @IBOutlet weak var lblTopLabel: UILabel!
    @IBOutlet var btnRight: UIButton!
    @IBOutlet var btnDropDown: UIButton!
    
    var contentView:UIView?
    let nibName = "ReusableInputView"
    weak var reusableViewDelegate: ReusableViewDelegate?
    private var colorHeaderText = getColorFromAsset(name: "PlaceholderHeaderColor")
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
        
        initialConfig()
        self.txtInput.delegate = self
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    //MARK: - Helper Methods
    private func initialConfig() {
        
        self.txtInput.font = UIFont.RalewayRegular(ofSize: GetAppFontSize(size: 14.0))
        self.txtInput.setPlaceHolderColor(text: self.txtInput.placeholder?.localized() ?? "", color: UIColor(named: "PlaceholderHeaderColor")!)
        self.lblTopLabel.font = UIFont.RalewayMedium(ofSize: GetAppFontSize(size: 13.0))
        if self.keyboard == 7{
            self.txtInput.autocapitalizationType = .none
        }
        else{
            self.txtInput.autocapitalizationType = .sentences
        }
    }
    
    //MARK: IBInspectable
    /*0: default // Default type for the current input method.

    1: asciiCapable // Displays a keyboard which can enter ASCII characters

    2: numbersAndPunctuation // Numbers and assorted punctuation.

    3: URL // A type optimized for URL entry (shows . / .com prominently).

    4: numberPad // A number pad with locale-appropriate digits (0-9, ۰-۹, ०-९, etc.). Suitable for PIN entry.

    5: phonePad // A phone pad (1-9, *, 0, #, with letters under the numbers).

    6: namePhonePad // A type optimized for entering a person's name or phone number.

    7: emailAddress // A type optimized for multiple email address entry (shows space @ . prominently).

    8: decimalPad // A number pad with a decimal point.

    9: twitter // A type optimized for twitter text entry (easy access to @ #)*/

    @IBInspectable var keyboard:Int{
        get{
            //self.txtInput.returnKeyType.rawValue
            return self.txtInput.keyboardType.rawValue
        }
        set(keyboardIndex){
            if keyboard == 7 {
                self.txtInput.autocapitalizationType = .none
            }
            else{
                self.txtInput.autocapitalizationType = .sentences
            }
            self.txtInput.keyboardType = UIKeyboardType.init(rawValue: keyboardIndex)!
        }
    }

    @IBInspectable var isPassword : Bool = false {
        didSet {
            self.txtInput.isSecureTextEntry = isPassword
        }
    }
    
    @IBInspectable var placeholderText: String {
        get { return self.txtInput.placeholder ?? "" }
        set {
            self.txtInput.placeholder = newValue.localized()
        }
    }
    
    @IBInspectable var topHeaderLabelText: String = "" {
        didSet {
            self.lblTopLabel.text = topHeaderLabelText.localized()
        }
    }
    
    @IBInspectable var HeaderTextColor: UIColor{
        get { return self.lblTopLabel.textColor ?? .black }
        set {
            if isFieldMandatory {
                self.lblTopLabel.setFieldMandatoryAttributedTextLable(TextColor: newValue)
            }
            else{
                self.lblTopLabel.textColor = newValue
            }
        }
        /*didSet {
            self.colorHeaderText = HeaderTextColor
        }*/
    }
    
    @IBInspectable var isFieldMandatory: Bool = false {
        didSet {
            if isFieldMandatory {
                self.lblTopLabel.setFieldMandatoryAttributedTextLable(TextColor: self.colorHeaderText)
            }
            /*else{
                self.lblTopLabel.textColor = HeaderTextColor
            }*/
        }
    }
    
    @IBInspectable var rightImage : UIImage  {
        get {return self.btnRight.imageView?.image ?? UIImage()}
        set {
            self.btnRight.setImage(newValue, for: .normal)
        }
    }
    
    @IBInspectable var isShowDropDown : Bool = false {
        didSet {
            self.btnDropDown.isHidden = !isShowDropDown
            self.btnRight.isHidden = !isShowDropDown
        }
    }

    
}

//MARK:_ UIBUtton Action
extension ReusableInputView {
    
    @IBAction func btnDropDownAction(_ sender: UIButton) {
        reusableViewDelegate?.buttonClicked(sender)
    }
    
}
extension ReusableInputView : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.keyboardType == .phonePad {
            guard let text = textField.text else { return false }
            let newString = (text as NSString).replacingCharacters(in: range, with: string)
            textField.text = format(with: Masking.kPhoneNumberMasking, phone: newString)
            return false
        }
        return true
    }
}
