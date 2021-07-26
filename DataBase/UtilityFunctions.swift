//
//  constant.swift


//var spinner = RPLoadingAnimationView.init(frame: CGRect.zero)
var overlayView = UIView()

struct DIRECTORY_NAME
{
    public static let IMAGES = "Images"
    public static let VIDEOS = "Videos"
    public static let DOWNLOAD_VIDEOS = "Download_videos"
}

public func DegreesToRadians(degrees: Float) -> Float {
    return Float(Double(degrees) * .pi / 180)
}

public let isSimulator: Bool = {
    var isSim = false
    #if arch(i386) || arch(x86_64)
    isSim = true
    #endif
    return isSim
}()

//MARK:-  Get VC for navigation
//var banner = NotificationBanner(title: "", subtitle: "", style: .success)
public func getStoryboard(storyboardName: String) -> UIStoryboard {
    return UIStoryboard(name: storyboardName, bundle: nil)
}

public func loadVC(strStoryboardId: String, strVCId: String) -> UIViewController {
    
    let vc = getStoryboard(storyboardName: strStoryboardId).instantiateViewController(withIdentifier: strVCId)
    return vc
}

public var CurrentTimeStamp: String
{
    return "\(NSDate().timeIntervalSince1970 * 1000)"
}

func setTabbarController(vc:UITabBarController) {
    vc.tabBar.items![0].image = UIImage.init(named: "Me")
    vc.tabBar.items![0].title = "Me"
}
func randomString(length: Int) -> String
{
    let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    let len = UInt32(letters.length)
    var randomString = ""
    for _ in 0 ..< length {
        let rand = arc4random_uniform(len)
        var nextChar = letters.character(at: Int(rand))
        randomString += NSString(characters: &nextChar, length: 1) as String
    }
    return randomString
}

func covertTimeToLocalZone(time:String) -> NSDate
{
    let dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ"
    let inputTimeZone = NSTimeZone(abbreviation: "UTC")
    let inputDateFormatter = DateFormatter()
    inputDateFormatter.timeZone = inputTimeZone as TimeZone?
    inputDateFormatter.dateFormat = dateFormat
    let date = inputDateFormatter.date(from: time)
    let outputTimeZone = NSTimeZone.local
    let outputDateFormatter = DateFormatter()
    outputDateFormatter.timeZone = outputTimeZone
    outputDateFormatter.dateFormat = dateFormat
    let outputString = outputDateFormatter.string(from: date!)
    return outputDateFormatter.date(from: outputString)! as NSDate
}

func saveInUserDefault(obj: AnyObject, key: String) {
    UserDefaults.standard.set(obj, forKey: key)
    //    UserDefaults.standard.synchronize()
}


func randomString() -> String
{
    var text = ""
    text = text.appending(CurrentTimeStamp)
    text = text.replacingOccurrences(of: ".", with: "")
    return text
}

func setHashtagAndMention(_ stringWithTags: String?) -> NSMutableAttributedString? {
    var _: Error? = nil
    let regex = try? NSRegularExpression(pattern: "[#|@]+[A-Za-z0-9_^]+", options: [])
    let matches = regex?.matches(in: stringWithTags ?? "", options: [], range: NSRange(location: 0, length: stringWithTags?.count ?? 0))
    let attString = NSMutableAttributedString(string: stringWithTags ?? "")
    let stringLength: Int = stringWithTags?.count ?? 0
    for match in matches ?? [] {
        let wordRange: NSRange = match.range(at: 0)
        let word = (stringWithTags as NSString?)?.substring(with: wordRange)
        let font = UIFont(name: "Helvetica", size: 13.0)
        attString.addAttribute(.font, value: font, range: NSRange(location: 0, length: stringLength))
        let backgroundColor = #colorLiteral(red: 0, green: 0.8109871745, blue: 0.8282212019, alpha: 1)
        attString.addAttribute(.foregroundColor, value: backgroundColor, range: wordRange)
    }
    
    return attString
}

func dictionaryOfFilteredBy(dict: NSDictionary) -> NSDictionary {
    
    let replaced: NSMutableDictionary = NSMutableDictionary(dictionary : dict)
    let blank: String = ""
    
    for (key, _) in dict
    {
        let object = dict[key] as AnyObject
        
        if (object.isKind(of: NSNull.self))
        {
            replaced[key] = blank as AnyObject?
        }
        else if (object is [AnyHashable: AnyObject])
        {
            replaced[key] = dictionaryOfFilteredBy(dict: object as! NSDictionary)
        }
        else if (object is [AnyObject])
        {
            replaced[key] = arrayOfFilteredBy(arr: object as! NSArray)
        }
        else
        {
            replaced[key] = "\(object)" as AnyObject?
        }
    }
    return replaced
}

func arrayOfFilteredBy(arr: NSArray) -> NSArray {
    
    let replaced: NSMutableArray = NSMutableArray(array: arr)
    let blank: String = ""
    
    for i in 0..<arr.count
    {
        let object = arr[i] as AnyObject
        
        if (object.isKind(of: NSNull.self))
        {
            replaced[i] = blank as AnyObject
        }
        else if (object is [AnyHashable: AnyObject])
        {
            replaced[i] = dictionaryOfFilteredBy(dict: arr[i] as! NSDictionary)
        }
        else if (object is [AnyObject])
        {
            replaced[i] = arrayOfFilteredBy(arr: arr[i] as! NSArray)
        }
        else
        {
            replaced[i] = "\(object)" as AnyObject
        }
        
    }
    return replaced
}


//MARK:-  Check Device is iPad or not
public  var isPad: Bool {
    return UIDevice.current.userInterfaceIdiom == .pad
}

public var isPhone: Bool {
    return UIDevice.current.userInterfaceIdiom == .phone
}

public var isStatusBarHidden: Bool
{
    get {
        return UIApplication.shared.isStatusBarHidden
    }
    set {
        UIApplication.shared.isStatusBarHidden = newValue
    }
}

public var mostTopViewController: UIViewController? {
    get {
        return UIApplication.shared.keyWindow?.rootViewController
    }
    set {
        UIApplication.shared.keyWindow?.rootViewController = newValue
    }
}

//MARK:- iOS version checking Functions
public var appDisplayName: String? {
    return Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String
}
public var appBundleID: String? {
    return Bundle.main.bundleIdentifier
}
public func IOS_VERSION() -> String {
    return UIDevice.current.systemVersion
}
public var statusBarHeight: CGFloat {
    return UIApplication.shared.statusBarFrame.height
}
public var applicationIconBadgeNumber: Int {
    get {
        return UIApplication.shared.applicationIconBadgeNumber
    }
    set {
        UIApplication.shared.applicationIconBadgeNumber = newValue
    }
}
public var appVersion: String? {
    return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
}
public func SCREENWIDTH() -> CGFloat
{
    let screenSize = UIScreen.main.bounds
    return screenSize.width
}

public func SCREENHEIGHT() -> CGFloat
{
    let screenSize = UIScreen.main.bounds
    return screenSize.height
}

func getVideoThumbnail(videoURL:URL,withSeconds:Bool = false) -> UIImage?
{
    let timeSeconds = 2
    
    let asset = AVAsset(url: videoURL)
    let imageGenerator = AVAssetImageGenerator(asset: asset)
    imageGenerator.appliesPreferredTrackTransform = true
    
    var time = asset.duration
    
    if(withSeconds)
    {
        time.value = min(time.value, CMTimeValue(timeSeconds))
    }
    else
    {
        time = CMTimeMultiplyByFloat64(time, multiplier: 0.5)
    }
    
    do {
        let imageRef = try imageGenerator.copyCGImage(at: time, actualTime: nil)
        return UIImage(cgImage: imageRef)
    }
    catch _ as NSError
    {
        return nil
    }
}

//MARK:- SwiftMessage
public func showLoaderHUD(strMessage:String)
{
    SVProgressHUD.setDefaultMaskType(.gradient)
    SVProgressHUD.setForegroundColor(#colorLiteral(red: 0.2431372549, green: 0.4078431373, blue: 0.9960784314, alpha: 1))
    //    SVProgressHUD.setBackgroundColor(UIColor.clear)
    if strMessage == "" {
        SVProgressHUD.show()
    }else{
        SVProgressHUD.show(withStatus: strMessage)
    }
}

public func hideLoaderHUD()
{
    
    DispatchQueue.main.async {
        SVProgressHUD.dismiss()
    }
    //    LoadingHud.dismissHUD()
}

public func hideMessage()
{
    SwiftMessages.hide()
}

public func showMessageWithRetry(_ bodymsg:String ,_ msgtype:Int,buttonTapHandler: ((_ button: UIButton) -> Void)?)
{
    hideBanner()
    //let view: MessageView  = try! SwiftMessages.viewFromNib()
    let view = MessageView.viewFromNib(layout: .cardView)
    view.configureContent(title: "", body: bodymsg, iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: "Retry", buttonTapHandler: buttonTapHandler)
    view.configureDropShadow()
    var config = SwiftMessages.defaultConfig
    config.presentationContext = .window(windowLevel: UIWindow.Level.normal)
    config.duration = .seconds(seconds: 7)
    view.configureTheme(.warning, iconStyle:  .light)
    view.titleLabel?.isHidden = true
    view.button?.isHidden = false
    view.iconImageView?.isHidden = false
    view.iconLabel?.isHidden = false
    config.presentationStyle = .bottom
    SwiftMessages.show(config: config, view: view)
}

public func showMessage(_ bodymsg:String)
{
    DispatchQueue.main.async {
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureContent(title: "", body: bodymsg, iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: "Hide", buttonTapHandler: { _ in SwiftMessages.hide() })
        view.configureDropShadow()
        var config = SwiftMessages.defaultConfig
        config.presentationContext = .window(windowLevel: UIWindow.Level.normal)
        config.duration = .seconds(seconds: 7)
        view.configureTheme(.warning, iconStyle:  .light)
        view.titleLabel?.isHidden = true
        view.button?.isHidden = false
        view.iconImageView?.isHidden = false
        view.iconLabel?.isHidden = false
        config.presentationStyle = .bottom
        SwiftMessages.show(config: config, view: view)
    }
}

//MARK:- Network indicator
//public func ShowNetworkIndicator(xx :Bool)
//{
//    runOnMainThreadWithoutDeadlock {
//        UIApplication.shared.isNetworkActivityIndicatorVisible = xx
//    }
//}

//MARK : Length validation
public func TRIM(string: Any) -> String
{
    return (string as AnyObject).trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
}

public func emptyTextField(textField:UITextField) {
    textField.text = TRIM(string: textField.text ?? "")
}
public func validateMaxTxtFieldLength(_ txtVal: UITextField, lenght:Int,msg: String) -> Bool
{
    if TRIM(string: txtVal.text ?? "").count > lenght
    {
        showMessage(msg)
        return false
    }
    return true
}

public func validateTxtLength(_ txtVal: String, withMessage msg: String) -> Bool {
    if TRIM(string: txtVal).count == 0
    {
        showMessage(msg);
        return false
    }
    return true
}

public func passwordMismatch(_ txtVal: UITextField, _ txtVal1: UITextField, withMessage msg: String) -> Bool
{
    if TRIM(string: txtVal.text ?? "") != TRIM(string: txtVal1.text ?? "")
    {
        showMessage(msg);
        return false
    }
    return true
}

public func validateEmailAddress(_ txtVal: UITextField ,withMessage msg: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    if(emailTest.evaluate(with: txtVal.text) != true)
    {
        showMessage(msg);
        return false
    }
    return true
}

public func validatePhoneNo(_ txtVal: UITextField ,withMessage msg: String) -> Bool
{
    let PHONE_REGEX = "^[0-9]{6,}$"
    let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
    if(phoneTest.evaluate(with: txtVal.text) != true)
    {
        showMessage(msg);
        return false
    }
    return true
}

public func isBase64(stringBase64:String) -> Bool
{
    let regex = "([A-Za-z0-9+/]{4})*" + "([A-Za-z0-9+/]{4}|[A-Za-z0-9+/]{3}=|[A-Za-z0-9+/]{2}==)"
    let test = NSPredicate(format:"SELF MATCHES %@", regex)
    if(test.evaluate(with: stringBase64) != true)
    {
        return false
    }
    return true
}


public func validateImage(_ txtVal: String, withMessage msg: String) -> Bool {
    if txtVal == "0"
    {
        showMessage(msg);
        return false
    }
    return true
}

public func validateButtonLabel(_ txtVal: String,btnname:UIButton, withMessage msg: String) -> Bool {
    if btnname.titleLabel?.text == txtVal
    {
        showMessage(msg);
        return false
    }
    return true
}


//MARK:- - Get image from image name
public func Set_Local_Image(imageName :String) -> UIImage
{
    return UIImage(named:imageName)!
}

//MARK:- FONT
public func FontWithSize(_ fname: String,_ fsize: Int) -> UIFont
{
    return UIFont(name: fname, size: CGFloat(fsize))!
}

//MARK:- COLOR RGB
public func Color_RGBA(_ R: Int,_ G: Int,_ B: Int,_ A: Int) -> UIColor
{
    return UIColor(red: CGFloat(R)/255.0, green: CGFloat(G)/255.0, blue: CGFloat(B)/255.0, alpha :CGFloat(A))
}
public func RGBA(_ R: Int,_ G: Int,_ B: Int,_ A: CGFloat) -> UIColor
{
    return UIColor(red: CGFloat(R)/255.0, green: CGFloat(G)/255.0, blue: CGFloat(B)/255.0, alpha :A)
}

//MARK:- SET FRAME
public func Frame_XYWH(_ originx: CGFloat,_ originy: CGFloat,_ fwidth: CGFloat,_ fheight: CGFloat) -> CGRect
{
    return CGRect(x: originx, y:originy, width: fwidth, height: fheight)
}

public func randomColor() -> UIColor {
    let r: UInt32 = arc4random_uniform(255)
    let g: UInt32 = arc4random_uniform(255)
    let b: UInt32 = arc4random_uniform(255)
    
    return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1.0)
}

struct Platform
{
    static let isSimulator: Bool = {
        var isSim = false
        #if arch(i386) || arch(x86_64)
        isSim = true
        #endif
        return isSim
    }()
}

//MARK:- - Log trace
public func DLog<T>(message:T,  file: String = #file, function: String = #function, lineNumber: Int = #line ) {
    #if DEBUG
    if let text = message as? String {
        
        print("\((file as NSString).lastPathComponent) -> \(function) line: \(lineNumber): \(text)")
    }
    #endif
}

//Mark : string to dictionary
public func convertStringToDictionary(str:String) -> [String: Any]? {
    if let data = str.data(using: .utf8) {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch {
            print(error.localizedDescription)
        }
    }
    return nil
}

//MARK:- - Check string is available or not
public func isLike(source: String , compare: String) ->Bool
{
    var exists = true
    ((source).lowercased().range(of: compare) != nil) ? (exists = true) :  (exists = false)
    return exists
}

//MARK:- - Calculate heght of label
func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
    let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
    label.numberOfLines = 0
    label.lineBreakMode = NSLineBreakMode.byWordWrapping
    label.font = font
    label.text = text
    
    label.sizeToFit()
    return label.frame.height
}


//MARK:- Mile to Km
public func hideBanner()
{
    SwiftMessages.hide()
}

public func mileToKilometer(myDistance : Int) -> Float
{
    return Float(myDistance) * 1.60934
}

//MARK:- Kilometer to Mile
public func KilometerToMile(myDistance : Double) -> Double {
    return (myDistance) * 0.621371192
}

//MARK:- NULL to NIL
public func NULL_TO_NIL(value : AnyObject?) -> AnyObject? {
    
    if value is NSNull {
        return "" as AnyObject?
    } else {
        return value
    }
}

//MARK:- Time Ago Function
func timeAgoSinceDate(date:Date, numericDates:Bool) -> String?
{
    let calendar = NSCalendar.current
    let unitFlags: NSCalendar.Unit = [.second, .minute, .hour, .day, .weekOfYear, .month, .year]
    let now = NSDate()
    let components = (calendar as NSCalendar).components(unitFlags, from: date, to: now as Date, options: [])
    if (components.year! >= 2)
    {
        return "\(components.year!)" + "y ago"
    }
    else if (components.year! >= 1)
    {
        if (numericDates){
            return "1y ago"
        } else {
            return "Last year"
        }
    }
    else if (components.month! >= 2) {
        return "\(components.month!)" + "m ago"
    }
    else if (components.month! >= 1){
        if (numericDates){
            return "1m ago"
        } else {
            return "Last month"
        }
    }
    else if (components.weekOfYear! >= 2) {
        return "\(components.weekOfYear!)" + "w ago"
    }
    else if (components.weekOfYear! >= 1){
        if (numericDates){
            return "1w ago"
        } else {
            return "Last week"
        }
    }
    else if (components.day! >= 2) {
        return "\(components.day!)" + "d ago"
    }
    else if (components.day! >= 1){
        if (numericDates){
            return "1d ago"
        } else {
            return "Yesterday"
        }
    }
    else if (components.hour! >= 2) {
        return "\(components.hour!)" + "h ago"
    }
    else if (components.hour! >= 1){
        if (numericDates){
            return "1h ago"
        } else {
            return "An hour ago"
        }
    }
    else if (components.minute! >= 2)
    {
        return "\(components.minute!)" + "m ago"
    } else if (components.minute! > 1){
        if (numericDates){
            return "1m ago"
        } else {
            return "A minute ago"
        }
    }
    else if (components.second! >= 3) {
        return "\(components.second!)" + "s ago"
    } else {
        return "Just now"
    }
}


//MARK:-Check Internet connection
func isConnectedToNetwork() -> Bool
{
    var zeroAddress = sockaddr_in()
    zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)
    
    guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
            SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
        }
    })
        else
    {
        return false
    }
    
    var flags : SCNetworkReachabilityFlags = []
    if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
        return false
    }
    
    let isReachable = flags.contains(.reachable)
    let needsConnection = flags.contains(.connectionRequired)
    let available =  (isReachable && !needsConnection)
    if(available)
    {
        return true
    }
    else
    {
        //showMessage(InternetNotAvailable)
        return false
    }
}

//MARK:- Animation
func addActivityIndicatior(activityview:UIActivityIndicatorView,button:UIButton)
{
    activityview.isHidden = false
    activityview.startAnimating()
    button.isEnabled = false
    button.backgroundColor = RGBA(181, 131, 0, 0.4)
}
func hideActivityIndicatior(activityview:UIActivityIndicatorView,button:UIButton)
{
    activityview.isHidden = true
    activityview.stopAnimating()
    button.isEnabled = true
    button.backgroundColor = RGBA(181, 131, 0, 1.0)
}
func animateview(vw1 : UIView,vw2:UIView)
{
    UIView.animate(withDuration: 0.1,
                   delay: 0.1,
                   options: UIView.AnimationOptions.curveEaseIn ,//UIView.AnimationOptions.curveEaseIn,
        animations: { () -> Void in
            vw1.alpha = 0;
            vw2.alpha = 1;
    }, completion: { (finished) -> Void in
        vw1.isHidden = true;
    })
}

//MARK:- Country code
func setDefaultCountryCode() -> String
{
    let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String
    return "+" + getCountryPhonceCode(countryCode!)
}

func fixOrientationOfImage(image: UIImage) -> UIImage?
{
    if image.imageOrientation == .up
    {return image}
    var transform = CGAffineTransform.identity
    switch image.imageOrientation
    {
    case .down, .downMirrored:
        transform = transform.translatedBy(x: image.size.width, y: image.size.height)
        transform = transform.rotated(by: CGFloat(Double.pi))
    case .left, .leftMirrored:
        transform = transform.translatedBy(x: image.size.width, y: 0)
        transform = transform.rotated(by:  CGFloat(Double.pi / 2))
    case .right, .rightMirrored:
        transform = transform.translatedBy(x: 0, y: image.size.height)
        transform = transform.rotated(by:  -CGFloat(Double.pi / 2))
    default:
        break
    }
    switch image.imageOrientation
    {
    case .upMirrored, .downMirrored:
        transform = transform.translatedBy(x: image.size.width, y: 0)
        transform = transform.scaledBy(x: -1, y: 1)
    case .leftMirrored, .rightMirrored:
        transform = transform.translatedBy(x: image.size.height, y: 0)
        transform = transform.scaledBy(x: -1, y: 1)
    default:
        break
    }
    guard let context = CGContext(data: nil, width: Int(image.size.width), height: Int(image.size.height), bitsPerComponent: image.cgImage!.bitsPerComponent, bytesPerRow: 0, space: image.cgImage!.colorSpace!, bitmapInfo: image.cgImage!.bitmapInfo.rawValue) else {
        return nil
    }
    context.concatenate(transform)
    switch image.imageOrientation
    {
    case .left, .leftMirrored, .right, .rightMirrored:
        context.draw(image.cgImage!, in: CGRect(x: 0, y: 0, width: image.size.height, height: image.size.width))
    default:
        context.draw(image.cgImage!, in: CGRect(origin: .zero, size: image.size))
    }
    guard let CGImage = context.makeImage() else {
        return nil
    }
    return UIImage(cgImage: CGImage)
}

func compressVideo(inputURL: URL, outputURL: URL, handler:@escaping (_ session: AVAssetExportSession)-> Void)
{
    let urlAsset = AVURLAsset(url: inputURL, options: nil)
    let exportSession = AVAssetExportSession(asset: urlAsset, presetName:AVAssetExportPreset640x480)//AVAssetExportPresetMediumQuality
    exportSession!.outputURL = outputURL
    exportSession!.outputFileType = AVFileType.mp4
    exportSession!.shouldOptimizeForNetworkUse = true
    exportSession!.exportAsynchronously { () -> Void in
        handler(exportSession!)
    }
}

func getCountryPhonceCode (_ country : String) -> String
{
    var countryDictionary  = ["AF":"93",
                              "AL":"355",
                              "DZ":"213",
                              "AS":"1",
                              "AD":"376",
                              "AO":"244",
                              "AI":"1",
                              "AG":"1",
                              "AR":"54",
                              "AM":"374",
                              "AW":"297",
                              "AU":"61",
                              "AT":"43",
                              "AZ":"994",
                              "BS":"1",
                              "BH":"973",
                              "BD":"880",
                              "BB":"1",
                              "BY":"375",
                              "BE":"32",
                              "BZ":"501",
                              "BJ":"229",
                              "BM":"1",
                              "BT":"975",
                              "BA":"387",
                              "BW":"267",
                              "BR":"55",
                              "IO":"246",
                              "BG":"359",
                              "BF":"226",
                              "BI":"257",
                              "KH":"855",
                              "CM":"237",
                              "CA":"1",
                              "CV":"238",
                              "KY":"345",
                              "CF":"236",
                              "TD":"235",
                              "CL":"56",
                              "CN":"86",
                              "CX":"61",
                              "CO":"57",
                              "KM":"269",
                              "CG":"242",
                              "CK":"682",
                              "CR":"506",
                              "HR":"385",
                              "CU":"53",
                              "CY":"537",
                              "CZ":"420",
                              "DK":"45",
                              "DJ":"253",
                              "DM":"1",
                              "DO":"1",
                              "EC":"593",
                              "EG":"20",
                              "SV":"503",
                              "GQ":"240",
                              "ER":"291",
                              "EE":"372",
                              "ET":"251",
                              "FO":"298",
                              "FJ":"679",
                              "FI":"358",
                              "FR":"33",
                              "GF":"594",
                              "PF":"689",
                              "GA":"241",
                              "GM":"220",
                              "GE":"995",
                              "DE":"49",
                              "GH":"233",
                              "GI":"350",
                              "GR":"30",
                              "GL":"299",
                              "GD":"1",
                              "GP":"590",
                              "GU":"1",
                              "GT":"502",
                              "GN":"224",
                              "GW":"245",
                              "GY":"595",
                              "HT":"509",
                              "HN":"504",
                              "HU":"36",
                              "IS":"354",
                              "IN":"91",
                              "ID":"62",
                              "IQ":"964",
                              "IE":"353",
                              "IL":"972",
                              "IT":"39",
                              "JM":"1",
                              "JP":"81",
                              "JO":"962",
                              "KZ":"77",
                              "KE":"254",
                              "KI":"686",
                              "KW":"965",
                              "KG":"996",
                              "LV":"371",
                              "LB":"961",
                              "LS":"266",
                              "LR":"231",
                              "LI":"423",
                              "LT":"370",
                              "LU":"352",
                              "MG":"261",
                              "MW":"265",
                              "MY":"60",
                              "MV":"960",
                              "ML":"223",
                              "MT":"356",
                              "MH":"692",
                              "MQ":"596",
                              "MR":"222",
                              "MU":"230",
                              "YT":"262",
                              "MX":"52",
                              "MC":"377",
                              "MN":"976",
                              "ME":"382",
                              "MS":"1",
                              "MA":"212",
                              "MM":"95",
                              "NA":"264",
                              "NR":"674",
                              "NP":"977",
                              "NL":"31",
                              "AN":"599",
                              "NC":"687",
                              "NZ":"64",
                              "NI":"505",
                              "NE":"227",
                              "NG":"234",
                              "NU":"683",
                              "NF":"672",
                              "MP":"1",
                              "NO":"47",
                              "OM":"968",
                              "PK":"92",
                              "PW":"680",
                              "PA":"507",
                              "PG":"675",
                              "PY":"595",
                              "PE":"51",
                              "PH":"63",
                              "PL":"48",
                              "PT":"351",
                              "PR":"1",
                              "QA":"974",
                              "RO":"40",
                              "RW":"250",
                              "WS":"685",
                              "SM":"378",
                              "SA":"966",
                              "SN":"221",
                              "RS":"381",
                              "SC":"248",
                              "SL":"232",
                              "SG":"65",
                              "SK":"421",
                              "SI":"386",
                              "SB":"677",
                              "ZA":"27",
                              "GS":"500",
                              "ES":"34",
                              "LK":"94",
                              "SD":"249",
                              "SR":"597",
                              "SZ":"268",
                              "SE":"46",
                              "CH":"41",
                              "TJ":"992",
                              "TH":"66",
                              "TG":"228",
                              "TK":"690",
                              "TO":"676",
                              "TT":"1",
                              "TN":"216",
                              "TR":"90",
                              "TM":"993",
                              "TC":"1",
                              "TV":"688",
                              "UG":"256",
                              "UA":"380",
                              "AE":"971",
                              "GB":"44",
                              "US":"1",
                              "UY":"598",
                              "UZ":"998",
                              "VU":"678",
                              "WF":"681",
                              "YE":"967",
                              "ZM":"260",
                              "ZW":"263",
                              "BO":"591",
                              "BN":"673",
                              "CC":"61",
                              "CD":"243",
                              "CI":"225",
                              "FK":"500",
                              "GG":"44",
                              "VA":"379",
                              "HK":"852",
                              "IR":"98",
                              "IM":"44",
                              "JE":"44",
                              "KP":"850",
                              "KR":"82",
                              "LA":"856",
                              "LY":"218",
                              "MO":"853",
                              "MK":"389",
                              "FM":"691",
                              "MD":"373",
                              "MZ":"258",
                              "PS":"970",
                              "PN":"872",
                              "RE":"262",
                              "RU":"7",
                              "BL":"590",
                              "SH":"290",
                              "KN":"1",
                              "LC":"1",
                              "MF":"590",
                              "PM":"508",
                              "VC":"1",
                              "ST":"239",
                              "SO":"252",
                              "SJ":"47",
                              "SY":"963",
                              "TW":"886",
                              "TZ":"255",
                              "TL":"670",
                              "VE":"58",
                              "VN":"84",
                              "VG":"284",
                              "VI":"340"]
    let cname = country.uppercased()
    if countryDictionary[cname] != nil
    {
        return countryDictionary[cname]!
    }
    else
    {
        return cname
    }
    
}

func Color_Hex(hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

func viewSlideInFromBottom(toTop views: UIView)
{
    let transition = CATransition()
    transition.duration = 0.8
    transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    transition.type = CATransitionType.push
    transition.subtype = CATransitionSubtype.fromTop
    views.layer.add(transition, forKey: nil)
}

func dateCompareIsGrater(first:Date, secondDate:Date) -> Bool {
    let cal = Calendar.current.dateComponents([.day,.hour, .minute, .second], from: first, to: secondDate)
    if cal.day! < 0 || cal.hour! < 0 || cal.minute! < 0 || cal.second! < 0 {
        return false
    }
    return true
}

func dateCompare(firstDate:Date, secondDate:Date) -> DateComponents {
    return Calendar.current.dateComponents([.hour, .minute, .second], from: firstDate, to: secondDate)
}

func viewSlideInFromTop(toBottom views: UIView)
{
    let transition = CATransition()
    transition.duration = 0.5
    transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
    transition.type = CATransitionType.push//CATransitionType.push
    transition.subtype = CATransitionSubtype.fromBottom//CATransitionSubtype.fromBottom
    views.layer.add(transition, forKey: nil)
}

//MARK:- UIColor From Color Code
// Find Color From Hex Value
func UIColorFromHex(hex:String, alpha:Double = 1.0) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(alpha)
    )
}

//MARK:-  Ticket
public func getTicktStatusColor(status:String) -> UIColor {
    if status == "1" {
        return #colorLiteral(red: 0.07058823529, green: 0.6941176471, blue: 0, alpha: 1)
    }
    return #colorLiteral(red: 0.8943751454, green: 0.4074842632, blue: 0.3386890292, alpha: 1)
}
public func getTicktStatus(status:String) -> String {
    if status == "0" {
        return "Close"
    }
    else if status == "1" {
        return "Open"
    }
    return ""
}
func encodeToUtf8(_ s: String) -> String {
    let data = s.data(using: .nonLossyASCII, allowLossyConversion: true)!
    return String(data: data, encoding: .utf8)!
}

func decodeFromUtf8(_ s: String) -> String? {
    let data = s.data(using: .utf8)!
    return String(data: data, encoding: .nonLossyASCII)
}
func duration(for resource: String) -> Double {
    let asset = AVURLAsset(url: URL(fileURLWithPath: resource))
    return Double(CMTimeGetSeconds(asset.duration))
}
func image(with view: UIView?) -> UIImage? {
    UIGraphicsBeginImageContextWithOptions(view?.bounds.size ?? CGSize.zero, _: view?.isOpaque ?? false, _: 0.0)
    if let context = UIGraphicsGetCurrentContext() {
        view?.layer.render(in: context)
    }
    let img2: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return img2
}
func createImage(with view: UIView?) -> UIImage? {
    UIGraphicsBeginImageContextWithOptions(view?.bounds.size ?? CGSize.zero, _: view?.isOpaque ?? false, _: 0.0)
    if let context = UIGraphicsGetCurrentContext() {
        view?.layer.render(in: context)
    }
    let img2: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return img2
}
func createcopy()  {
    let arr = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    let path = arr[0]
    let finalpath = path.appending("/StickerAppDB.db")
    
    print(finalpath)

    let flm = FileManager()
    if !flm.fileExists(atPath: finalpath) {
        let localpath = Bundle.main.path(forResource: "StickerAppDB", ofType: "db")
        do{
            try flm.copyItem(atPath: localpath!, toPath: finalpath)
        }catch{
        }
    }
}
func databasePath() -> String{
    let arr = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    let path = arr[0]
    let finalpath = path.appending("/StickerAppDB.db")
    return finalpath
}
