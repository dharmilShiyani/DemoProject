//
//  KeyNamesConstants.swift
//  Parth Hirpara
//

import Foundation
import UIKit



let APP_DELEGATE                =   UIApplication.shared.delegate as! AppDelegate
let kAppDelegate                =   UIApplication.shared.delegate as! AppDelegate

let kMainStoryBoard             =   UIStoryboard(name: "Main", bundle: nil)
let kLoginStoryBoard            =   UIStoryboard(name: "Login", bundle: nil)
let USERDEFAULTS                =   UserDefaults.standard

let NotificationGoToDashBoard = NSNotification.Name(rawValue: "dashboard")
let NotificationGoToLogIn     = NSNotification.Name(rawValue: "login")

public let userRole             :   String      =   "2"
public let appLengType          :   String      =   "1"

var kLat_Curr   = "latitute"
var kLong_Curr  =   "Logintute"
let kGoogleAPIKey                =   "AIzaSyC5NFJNqFQhNlC17dpJ6kXI4RXQecXJgOo"





//MARK:- Model
public  let kModelUserData          :   String      =   "kModelUserData"
public  let kModelUserExtraData     :   String      =   "kModelUserExtraData"
public  let kModelCommanData        :   String      =   "kModelCommanData"
public  let kModelGalleryData       :   String      =   "kModelGalleryData"

public let defaultShimmerValue  :   Int = 10

//MARK:- User Defaut
public  let UD_Device_Token         :   String      =   "DeviceToken"
public  let ORDER_DATA              :   String      =   "ORDERDATA"


//MARK:- Alert Button
public let kOK                      :   String  =   "Ok"
public let kCancel                  :   String  =   "Cancel"

public let datePickerDone           :   String  =   "Done"
public let datePickerCancel         :   String  =   "Cancel"


//MARK:- APP NAME
public let APPNAME :String = "KNT"

//MARK:-
public let kImgPlaceHolder  :   String  =   "PlaceHolder"

//MARK:- STORY BOARD NAMES
public let SB_MAIN              :   String  =   "Main"
public let SB_LOGIN             :   String  =   "Login"
public let SB_PostJob           :   String  =   "PostJob"
public let SB_Job               :   String  =   "Job"
public let SB_CareGiver         :   String  =   "CareGiver"

//MARK:- Notification Center
public let kNotificationMenuSelect  :   String  =   "kNotificationMenuSelect"
public let kSocketConnect           :   String  =   "kSocketConnect"
public let kAppFirstOpen            :   String  =   "AppFirstOpen"

//MARK:- ViewControl
public let idTutorialVC                       :   String  =   "TutorialVC"
public let idLogInVC                          :   String  =   "LogInVC"
public let idForgotPasswordVC                 :   String  =   "ForgotPasswordVC"
public let idSignUpVC                         :   String  =   "SignUpVC"
public let idCompleteProfileVC                :   String  =   "CompleteProfileVC"
public let idDashBoardVC                      :   String  =   "DashBoardVC"
public let idHomeVC                           :   String  =   "HomeVC"
public let idJobVC                            :   String  =   "JobVC"
public let idChatVC                           :   String  =   "ChatVC"
public let idChatDetailVC                     :   String  =   "ChatDetailVC"
public let idPostedJobVC                      :   String  =   "PostedJobVC"
public let idJobGivenVC                       :   String  =   "JobGivenVC"
public let idSupportVC                        :   String  =   "SupportVC"
public let idVerificationVC                   :   String  =   "VerificationVC"
public let idCompleteProfile2                 :   String  =   "CompleteProfile2"
public let idEnterAvailabilityVC              :   String  =   "EnterAvailabilityVC"


public let idAboutUSVC                        :   String  =   "AboutUSVC"
public let idCMSYVC                           :   String  =   "CMSYVC"
public let idFAQVC                            :   String  =   "FAQVC"
public let idCommunityVC                      :   String  =   "CommunityVC"
public let idNotificationVC                   :   String  =   "NotificationVC"

public let idPostJob1VC                       :   String  =   "PostJob1VC"
public let idPostJob2VC                       :   String  =   "PostJob2VC"
public let idPostJob3VC                       :   String  =   "PostJob3VC"
public let idPostJob4VC                       :   String  =   "PostJob4VC"
public let idPostJob5VC                       :   String  =   "PostJob5VC"
public let idPostJob6VC                       :   String  =   "PostJob6VC"
public let idPostJob7VC                       :   String  =   "PostJob7VC"
public let idFeedBackVC                       :   String  =   "FeedBackVC"
public let idCandidateVC                      :   String  =   "CandidateVC"
public let idProfileVC                        :   String  =   "ProfileVC"
public let idChangePasswordVC                 :   String  =   "ChangePasswordVC"
public let idMyBookingVC                      :   String  =   "MyBookingVC"
public let idPackagesVC                       :   String  =   "PackagesVC"
public let idPackagesFinalVC                  :   String  =   "PackagesFinalVC"
public let idCareGiverProfile                 :   String  =   "CareGiverProfile"


public let idSelectDateVC                     :   String  =   "SelectDateVC"
public let idMapVC                            :   String  =   "MapVC"


public let idPostedJobDetailVC                :   String  =   "PostedJobDetailVC"
public let idPaymentVC                        :   String  =   "PaymentVC"
public let idAddNewCardVC                     :   String  =   "AddNewCardVC"
public let idInviteVC                         :   String  =   "InviteVC"

public let idFounderMsgVC                     :   String  =   "FounderMsgVC"
public let idAddNewTicketVC                   :   String  =   "AddNewTicketVC"

public let idUserRoleSelectionVC              :   String  =   "UserRoleSelectionVC"
public let idCareGiverHomeVC                  :   String  =   "CareGiverHomeVC"
public let idCareGiverJobVC                   :   String  =   "CareGiverJobVC"
public let idCareGiverMyReview                :   String  =   "CareGiverMyReview"
public let idJobNearMeDetail                  :   String  =   "JobNearMeDetail"
public let idCareGiverSearchVC                :   String  =   "CareGiverSearchVC"
public let idCareGiverMyJobDetailVC           :   String  =   "CareGiverMyJobDetailVC"
public let idCareGiverWithdrawalVC            :   String  =   "CareGiverWithdrawalVC"
public let idCareGiverMyProfile               :   String  =   "CareGiverMyProfile"
public let idFilterSearchVC                   :   String  =   "FilterSearchVC"

public let idAddCommunityVC                   :   String  =   "AddCommunityVC"
public let idFilterCareGiverVC                :   String  =   "FilterCareGiverVC"
public let idCareGiverAllJobList              :   String  =   "CareGiverAllJobList"
public let idCareGiverRecentTaskVC            :   String  =   "CareGiverRecentTaskVC"

public let idSupportChatVC                    :   String  =   "SupportChatVC"
public let idJobPaymentVC                     :   String  =   "JobPaymentVC"
public let idJobPaymentSuccessVC              :   String  =   "JobPaymentSuccessVC"
public let idAllJobListVC                     :   String  =   "AllJobListVC"

//MARK:- Message

public let kMsgLoginSuccessfull             :   String  =   "LogIn successfull"


//MARK:- Message
public let logOutConformation               :   String  =   "Are you sure to logout ?"
public let InternetNotAvailable             :   String  =   "Please connect internet."
public let RetryMessage                     :   String  =   "Something went wrong please try again..."

public let kEmptyFirstName                  :   String  =   "Please enter your first name."
public let kEmptyLastName                   :   String  =   "Please enter your last name."
public let kEmptyEmail                      :   String  =   "Please enter your email."
public let kInvalidEmail                    :   String  =   "Please enter valid email address."
public let kEmptyPassword                   :   String  =   "Please enter your password."
public let kInvalidPassword                 :   String  =   "Password length must be 8-15 chacater."
public let kAcceptTerms                     :   String  =   "Please acceprt terms & conditions."
public let kmsgValidationCodeEmpty          :   String  =   "Please enter verification code."
public let kEmptyConfirmPassword            :   String  =   "Please enter valid confirm password."
public let kPasswordAndConfirmNotSame       :   String  =   "Confirm password not match."
public let kEmptyOldPassword                :   String  =   "Please enter old password."

public let kEmptyProfileImage               :   String  =   "Please select profile image."
public let kEmptyMobile                     :   String  =   "Please enter mobile number."
public let kEmptyEmergencyNumber            :   String  =   "Please select emergency number."
public let kEmptyGender                     :   String  =   "Please select gender."
public let kEmptyDOB                        :   String  =   "Please enter your date of birth."


//Post Job
public let kEmptyJobTitle                   :   String  =   "Please enter job name."
public let kEmptyJobCategory                :   String  =   "Please select job category."
public let kEmptyJobPrice                   :   String  =   "Please enter job price."
public let kEmptyJobDescription             :   String  =   "Please enter Description."
public let kEmptyJobImage                   :   String  =   "Please select job photos."
public let kEmptyJobQuestion                :   String  =   "Please enter question."
public let kEmptySearchType                 :   String  =   "Please select search type."
public let kEmptyJobType                    :   String  =   "Please select job type."
public let kEmptyStartDate                  :   String  =   "Please select job start date."
public let kEmptyEndDate                    :   String  =   "Please select job end date."
public let kEmptyStartTime                  :   String  =   "Please select job start time."
public let kEmptyEndTime                    :   String  =   "Please select job end time."
public let kEmptySelectDay                  :   String  =   "Please select job days."
public let kEmptyPaymentType                :   String  =   "Please select payment type."
public let kEmptyJobLocation                :   String  =   "Please select Job location."

public let kEmptyFeedEmpty                  :   String  =   "Please enter something."
public let kFeedDeleteConformation          :   String  =   "Are you sure to delete this feed?"
public let kEmptyJobRepeat                  :   String  =   "Please select job repeat type."
public let kEmptySkill                      :   String  =   "Please select skills."
public let kEmptyAvaibility                 :   String  =   "Please select Avaibility."

public let kEmptySupportTitle               :   String  =   "Please enter support title."
public let kEmptySupportDescription         :   String  =   "Please enter support description."


//JOB
public let kJobCancelConformation           :   String  =   "Are you sure to cancel this job?"
public let kMsgAcceptJobInvitation          :   String  =   "Are you sure to accept this job invitation?"
public let kMsgRejectJobInvitation          :   String  =   "Are you sure to reject this job invitation?"
public let kJobStartConformation            :   String  =   "Are you sure to start this job?"
public let kJobFinishConformation           :   String  =   "Are you sure to finish this job?"

//CMS
public let kEmptyFeedBackRating             :   String  =   "Please select your experience"
public let kEmptyFeedBackDescription        :   String  =   "Please enter feedback"

//CHAT
public let kChatAcceptConformation          :   String  =   "Are you sure to accept message request?"
public let kChatDeclineConformation         :   String  =   "Are you sure to decline message request?"

