//
//  Constants.swift
//
//  Created by Parth Hirpara
//

import Foundation
import UIKit

let GET = "GET"
let POST = "POST"
let MEDIA = "MEDIA"

let DEFAULT_TIMEOUT:TimeInterval = 60.0

let kLengType   =   "1"
let kDeviceType =   "1"
//let kRole   = "2"

//MARK: Response Keys
let kData       =   "data"
let kMessage    =   "message"
let kSuccess    =   "success"
let kToken      =   "token"
let kStatus     =   "status"


let kStatusFailure = "0"
let kStatusSuccess = "1"
let kStatusUserNotVeryfy = "3"
let kStatusNoRecord = "6"
let kStatusEmailNotAdded = "4"


let BASE_URL = "http://project.greatwisher.com/infalliblecare"
let WS_URL = "ws://project.greatwisher.com:9005"


//WEb Socket URl
let kUserSupportTicketMessageList                =   "userSupportTicketMessageList"
let kUserSupportTicketReply                      =   "userSupportTicketReply"
let kChatinbox                                   =   "chatinbox"
let kChatmessagelist                             =   "chatmessagelist"
let kUsermessagelist                             =   "usermessagelist"
let kmessage                                     =   "message"
let kAcceptRequest                               =   "acceptRequest"
let kDeclineRequest                              =   "declineRequest"

let kGetCountry_URL                 =   "https://geodata.solutions/api/api.php?type=getCountries&orderby=alpha"
let kGetState_URL                   =   "https://geodata.solutions/api/api.php?type=getStates&countryId="
let kGetCity_URL                    =   "https://geodata.solutions/api/api.php?type=getCities&countryId="
let kMap_URL                        =   "https://maps.googleapis.com/maps/api/geocode/json?"

let kFBURLScheme                    =   "fb541867916521815"
let kTWConsumerKey                  =   "bpt5YpbqqS173bYUPMMVDsVD1"
let kTWConsumerSecret               =   "8NjabEfk85HkQ4kLiKAVSWMNABCnZkwSBfXSlV07Op32PKSmlA"
let kTWURLScheme                    =   "twitterkit-" + kTWConsumerKey

// LogIn & SignUp
let kFileUpload_URL                 =   "/api/common/mediaUpload"

let kSignup_URL                     =   "/api/auth/signup"
let kVerification_URL               =   "/api/auth/verify"
let kResendVerification_URL         =   "/api/auth/resendVerification"
let kForfotPassord_URL              =   "/api/auth/forgotPassword"
let kForgotPasswordCheck_URL        =   "/api/auth/checkForgotCode"
let kResetPassword_URL              =   "/api/auth/resetPassword"
let kLogin_URL                      =   "/api/auth/login"
let kPrivacyPolicy_URL              =   "/api/Users/getPrivacyPolicy"
let kCompleteProfile_URL            =   "/api/Users/completeProfile"
let kUpdateProfile_URL              =   "/api/Users/updateProfile"
let kSocialLogin_URL                =   "/api/auth/socialLogin"
let kLogout_URL                     =   "/api/auth/logout"


let kGetAboutUs_URL                 =   "/api/getAboutUs"
let kSaveUserProfile_URL            =   "/api/users/saveUserProfile"
let kChangePassword_URL             =   "/api/auth/changePassword"
let kFaqDetails_URL                 =   "/api/common/faqDetails"
let kGetCMS_URL                     =   "/api/common/getCMS"
let kSetAppFeedback_URL             =   "/api/common/setAppFeedback"
let kGetMyAppFeedback_URL           =   "/api/common/getMyAppFeedback"

//HOME
let kCaregiverlist_URL              =   "/api/users/caregiverlist"


//JOB
let kPostedjob_URL                  =   "/api/users/postedjob"
let kHiredjoblist_URL               =   "/api/users/hiredjoblist"
let kGetJobDetail_URL               =   "/api/users/getJobDetail"
let kJobcaregiverlist_URL           =   "/api/users/jobcaregiverlist"
let kJobhiredcaregiverlist_URL      =   "/api/users/jobhiredcaregiverlist"
let kFinishJob_URL                  =   "/api/users/finishJob"


//POST JOB
let kGetCategoryList_URL            =   "/api/users/getCategoryList"
let kGetPreferencesList_URL         =   "/api/users/getPreferencesList"
let kSetJob_URL                     =   "/api/users/setJob"

//FEED
let kGetFeed_URL                    =   "/api/users/getFeed"
let kLikeFeed_URL                   =   "/api/users/likeFeed"
let kUnlikeFeed_URL                 =   "/api/users/unlikeFeed"
let kSetfeed_URL                    =   "/api/users/setfeed"
let kDeleteFeed_URL                 =   "/api/users/deleteFeed"
let kSetFeedReport_URL              =   "/api/users/setFeedReport"

//CAREGIVER
let kCaregiverdetail_URL            =   "/api/users/caregiverdetail"
let kCaregiverRatings_URL           =   "/api/users/caregiver_ratings"
let kFavouritecaregiver_URL         =   "/api/users/favouritecaregiver"
let kUnfavouritecaregiver_URL       =   "/api/users/unfavouritecaregiver"
let kInvitejob_URL                  =   "/api/users/invitejob"
let kMyjobs_URL                     =   "/api/caregiver/myjobs"
let kCaregiverRecentTask_URL        =   "/api/users/caregiver_recent_task"


//SKILL
let kGetSkillsList_URL              =   "/api/users/getSkillsList"
let kSetSkillAvailability_URL       =   "/api/users/setSkillAvailability"

//SUPPORT
let kSetTicket_URL                  =   "/api/common/setTicket"
let kGetTicket_URL                  =   "/api/common/getTicket"

//FAQ
let kFaqList_URL                    =   "/api/common/faq"

//USER REVIEW
let kGivenRatings_URL               =   "/api/users/given_ratings"

// CAREGIVER DASHBOARD
let kCareGiverDashboard_URL         =   "/api/caregiver/dashboard"
let kRequestjob_URL                 =   "/api/users/requestjob"
let kJobList_URL                    =   "/api/caregiver/jobList"
let kRatings_URL                    =   "/api/caregiver/ratings"

//CAREGIVER JOBDETAIL
let kAcceptJobInvitation_URL        =   "/api/users/acceptJobInvitation"
let kRejectJobInvitation_URL        =   "/api/users/rejectJobInvitation"

//USER
let kAcceptJobRequest_URL           =   "/api/users/acceptJobRequest"
let kCancelledJob_URL               =   "/api/users/cancelledJob"
let kStartJob_URL                   =   "/api/users/startJob"

//MY BOOKING
let kMybooking_URL                  =   "/api/users/mybooking"


//PAYMENT
let kSaveCard_URL                   =   "/api/payment/saveCard"
let kGetUserCards_URL               =   "/api/payment/getUserCards"
