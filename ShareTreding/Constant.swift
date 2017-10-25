//
//  Constant.swift

import Foundation
import UIKit


// Service Calling Base Url
var BASE_URL = ""
//var BASE_URL = "http://172.16.7.42:85/"
//var BASE_URL = "https://stg-api.softwiseonline.com/"

// regex for DL Number Validation
let characterSetAllowedInDLNumber = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789")

// regex for name validation
let characterSetAllowedInNameValidation = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 .")

// syncing Time
let syncAPICallTime : TimeInterval = 61
// api maximum request time
let webAPICallingInterval: TimeInterval = 180

var timer : Timer? = Timer()

let operationQueue = OperationQueue()

var isBackGroundAlerStatus = true
var startupAPICallingStatus = true
var isFirstTimeCallTokenAPI = false
var isLogout = false

var isBankUpdate = false

var isLoginStatus = false

var Shared_Notification_Count = 0
var SHARED_CUSTOMER_ID = ""
var Shared_BankAccount_Id = ""
var Shared_Reference_Id = ""
var Shared_Identification_Type = ""
var Shared_Employer_Id = ""
var Shared_UserName = ""
var Shared_ModuelIdentifier = ""
var Shared_ObjectKey = ""
var SHARED_MAIL_ID = ""
var Shared_User_FullName = ""
var shared_UserImage: UIImage? = UIImage(named: "userImage")!

var DELETE = "DELETE"
var CREATE = "CREATE"
var UPDATE = "UPDATE"
var INSERT = "INSERT"

let kINS = "INS"
let kINSTALLMENT_LOAN_ = "INSTALLMENT LOAN_"
let kCASH_ADVANCE_ = "CASH ADVANCE_"


// Singup and login
let kbaseurl = "baseurl"
let kemail = "email"
let kpassword = "password"
let kremberButtonStatus = "remberButtonStatus"
let kpushNotificationStatus = "pushNotificationStatus"
let kSignUp_Title = "CREATE ACCOUNT"

// Notification observar name
let kNotificationCounterIdentifier = "NotificationCounterIdentifier"


// Moduel Identifier
let kApply = "apply"
let kExtension = "extension"
let kRefinance = "refinance"


// Notification API keys
let kDeliverDate = "DeliverDate"
let kMessage = "Message"
let kNotification_Id = "Notification_Id"
let kObjectName = "ObjectName"
let kObject_Id = "Object_Id"
let kRead = "Read"
let kPriority = "Priority"


//Notification Priority
let kHigh = "High"
let kMedium = "Medium"
let kLow = "Low"

// Notification ObjectName
let kLoan = "Loan"
let kSettings = "Settings"
let kUrl = "Url"



// Font family and font size
let FONT_ROBOTO = "Roboto-Regular"
let FONT_ROBOTO_Medium = "Roboto-Medium"
let FONT_ROBOTO_Bold = "Roboto-Bold"
let FONT_ROBOTO_Light = "Roboto-Light"

let headerFontSize : CGFloat = 17

let navigationTitleFontSize : CGFloat = 23

let backgroungColorPreviousLoan = UIColor(red: 167/255.0, green: 171/255.0, blue: 174/255.0, alpha: 1.0)
let headerFontColor = UIColor(red: 158/255.0, green: 158/255.0, blue: 159/255.0, alpha: 1.0)
let backgroundColor = UIColor(red: 248/255.0, green: 248/255.0, blue: 249/255.0, alpha: 1.0)

let headerBackGroundColorWith62Hight = UIColor(patternImage: UIImage(named: "header-shadow")!)

let bottomShadowWith5High = UIColor(patternImage:UIImage(named: "bottom-shadow")!)

let orangeColor = UIColor(red: 243/255.0, green: 119/255.0, blue: 76/255.0, alpha: 1.0)
let greenColor = UIColor(red: 80/255.0, green: 201/255.0, blue: 193/255.0, alpha: 1.0)
let navigationBgColor =  UIColor(red: 15/255.0, green: 198/255.0, blue: 220/255.0, alpha: 1.0)
let statusBarBgColor =  UIColor(red: 57/255.0, green: 170/255.0, blue: 188/255.0, alpha: 1.0)
let navigationTitleColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0)


// TableViewCell color and size
let cellHeigh = 70
let headerCellHeigh = 70
let headCellBGColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0)
let footerCellBGColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0)
let tableViewBGColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0)
let cellBottomBorderColor = UIColor(red: 239/255.0, green: 239/255.0, blue: 244/255.0, alpha: 1.0)

// get the current screen size
let screenSize: CGRect = UIScreen.main.bounds
let screenWidth = screenSize.width
let screenHeight = screenSize.height


// common lenght validation fields
let max_address_length = 50
let min_address_length = 5
let max_phone_number = 20
let min_phone_number = 10
let max_zip_length = 10
let min_zip_length = 5
let max_state_length = 2
let min_state_length = 2
let min_city_length = 2
let max_city_length = 30
let max_type_length = 3
let min_type_length = 3
let max_email_length = 129
let min_email_length = 7
let min_default_lenght = 1


// bank info
let max_bank_account_number = 16
let min_bank_account_number = 8
let max_bank_name = 30
let min_bank_name = 5
let min_bank_routing_number = 8
let max_bank_routing_number = 9
let max_account_type_length = 3
let min_account_type_length = 3


//info
let max_ssn_length = 11
let min_ssn_length = 9
let max_password_length = 20
let min_password_length = 10
let max_name_length = 20
let min_name_length = 1

// ssn validation on signUp screen
let max_ssn_length_signup = 4
let min_ssn_length_signup = 4

//reference info
let max_full_name_length = 50
let min_full_name_length = 3

//income info
let max_income_length = 50
let max_job_tittle_length = 20
let min_supervisor_length = 5
let max_supervisor_length = 50
let max_grossIncome_length = 10
let max_netIncome_length = 10


//identification info
let max_id_number = 20
let min_id_number = 1
let max_identification_type_length = 3
let min_identification_type_length = 2


// Lookup Key
let kPhoneType = "PhoneType"
let kBankAccountType = "BankAccountType"
let kState = "State"
let kIdentificationType = "IdentificationType"
let kIncomeType = "IncomeType"
let kReferenceType = "ReferenceType"

let kLookupId = "Lookup_Id"
let kCategoryId = "CategoryId"
let kCategoryCode = "CategoryCode"
let kCategoryName = "CategoryName"
let kItemCode = "ItemCode"
let kItemName = "ItemName"


// segue
let kBankInfoVC = "SettingBankInfo"
let kIdentificatoinInfoVC = "SettingIdentificationInfo"
let kIncomeEmployerVC = "SettingIncomeInfo"
let kReferenceInfoVC = "SettingReferencesInfo"
let kSettingContactInformationVC = "SettingContactInformationVC"

let AllBankListVC = "AllBankListVC"
let AllIncomeListVC = "AllIncomeListVC"
let AllIdentificationListVC = "AllIdentificationListVC"
let AllReferenceListVC = "AllReferenceListVC"

// for option screen under apply module
let kBankInfo = "Bank Info Needed"
let kEmployerInfo = "Employer Info Needed"
let kProofInfo = "Proof Info Needed"
let kReferenceInfo = "Reference Info Needed"

// for loan type
let kPayDayLoan = "Payday Loan"
let kInstallmentLoan = "Installment Loan"


// For Getting Auth Token Responce
let username = "mobile_api@softwiseonline.com"
let password = "Softwise20!5"
let grant_type = "password"

let kUsername =  "username"
let kPassword = "password"
let kGrant_type = "grant_type"
let kSSN4 = "SSN4"
let kAccess_token = "access_token"
let kToken_type = "token_type"
let kAccess_token_Expire_Date_time = ".expires"
let kAccess_token_Issued_time = ".issued"
let kAccess_token_Expite_Time_Milisec = "expires_in"


// For User Info
let kUser_Exist = "userExist"
let kUser_Exist_by_Login = "userExistByLogin"
let kSuperBaseUrl = "SuperBaseUrl"
let kSharedMailId = "sharedMailId"
let  kEmail = "Email"
let  kFirstName = "FirstName"
let  kLastName = "LastName"
let kLocation_ID = "LocationId"
let kOptIn_Notification = "OptInNotifications"
let  kAddress = "Address"
let  kAddress2 = "Address2"
let  kCity = "City"
let  kZip = "Zip"

let kIdentifications = "Identifications"
let kIncomes  = "Incomes"
let kBankAccounts = "BankAccounts"
let kReferences = "References"
let kBankAccount = "BankAccount"


// For Loan Type
let kLoanTypeId = "LoanType_Id"
let kCode = "Code"
let kDescription = "Description"
let kMaxAmount = "MaxAmount"
let kMinAmount = "MinAmount"
let kName = "Name"


// For Loans Table
let kLoan_Id  = "Loan_Id"
let kApprovalStatus = "ApprovalStatus"
let kCustomer_Id  = "Customer_Id"
let kType_Id  = "Type_Id"
let kApr  = "Apr"
let kInterestAmount  = "InterestAmount"
let kMaintenanceFeeAmount  = "MaintenanceFeeAmount"
let kOriginationFeeAmount  = "OriginationFeeAmount"
let kPaymentDueDate  = "PaymentDueDate"
let kPrincipalAmount  = "PrincipalAmount"
let kTotalDueAmount  = "TotalDueAmount"
let kWebDocuments  = "WebDocuments"
let kOriginationDate = "OriginationDate"
let kCanExtend = "CanExtend"
let kCanRefinance = "CanRefinance"
let kCanExtendDefaultDate = "CanExtendDefaultDate"
let kCanExtendMaxDate = "CanExtendMaxDate"
let kCanExtendMinDate = "CanExtendMinDate"


// For AuthToken
let kDate = "Date"

// For Document Signature
let kWebDocumentGid = "WebDocumentGid"
let kHtml = "Html"
let kSignature = "Signature"

let kPending = "Pending"
let kActive  = "Active"
let kOutstanding  = "Outstanding"
let kPrevious  = "Previous"


// approved status
let kApproved = "Approved"
let kNotApproved = "Not Approved"
let kClosed = "Closed"

// Status
let kPastDue = "Past Due"
let kDue = "Due"
let kPaid = "Paid"

// For Banks table

let kBankAccount_Id = "BankAccount_Id"
let kAccountNumber = "AccountNumber"
let kRoutingNumber = "RoutingNumber"
let kType = "Type"



// Reference Table
let kReference_Id = "Reference_Id"
let kPhone = "Phone"
let kStatus = "Status"


// Identificatoin Table
let kIdentification_Id = "Identification_Id"
let kExpiration = "Expiration"
let kNumber = "Number"


// Income Table
let kIncome_Id = "Income_Id"
let kEmployer_Id = "Employer_Id"
let kGross = "Gross"
let kNet = "Net"
let kTitle = "Title"


// Locations API
let kLocation_Id = "Location_Id"
let kLatitude =   "Latitude"
let kLongitude =  "Longitude"
let kHours = "Hours"
let kImage = "Image"


// Payment Schedule
let kPayments = "Payments"
let kAmount = "Amount"
let kIsPaid = "IsPaid"
let kPayment_Id = "Payment_Id"


// Debts
let kDebt_Id = "Debt_Id";


// Dashboard
let kActiveLoans = "ActiveLoans"
let kOutstandingDebts = "OutstandingDebts"


//HELP
let kLoan_Processes = "Loan Processes"
let kGLOSSARY_OF_TERMS = "GLOSSARY OF TERMS"
let kFAQs = "FAQs"

//Request Type
let kPOST_TYPE = "POST"
let kGET_Type = "GET"
let kPUT_Type = "PUT"
let kDELETE_Type = "DELETE"

//Responce Code and Status
let kResponse_Code = "Code"
let kSuccess_Code = "200"
let kResponse_Data = "Data"
let kXAuth_Token = "X-Auth-Token"
let kResponse_Message = "Message"
let kStatus_Message = "StatusMessage"
let kResponse_Parse_Message = "ReasonPhrase"
let kToken_Type_Bearer = "Bearer "
let kAuthorization_Header = "Authorization"
let kJSONContentValue = "application/json"
let kContent_Type = "Content-Type"
let kAccept = "Accept"


//Notificaion
let kToken_Success_Identifire =  "token_Notify_Identifire"
let kLeft_Panel_Dashboard = "Dashboard"
let kLeft_Panel_Loans = "Loans"
let kLeft_Panel_Apply = "Apply"
let kLeft_Panel_Settings = "Settings"
let kLeft_Panel_Locations = "Locations"
let kLeft_Panel_Help = "Help"
let kLeft_Panel_Notifications = "Notifications"
let kLeft_Panel_LogOut = "Logout"

//Connection Errore Message
let kAlert_Title = "Alert"
let kAlert_Connection_TimeOut = "Connection timed out. Please try again."
let kAlert_Server_Error = "Internal server error. Please try again."
let kAlert_No_Network = "Network is not available please try again"
let kIndicator_Loading = "Loading..."
let kServer_Not_Responding =  "Server is not responding. Please check your internet connection or URL."


// Sync Table
let SYNC_CUSTOMER_IDENTIFIER = "SyncCustomer";
let SYNC_LOAN_IDENTIFIER = "SyncLoan";
let SYNC_LOOKUP_SETTING_IDENTIFIER = "SyncLookup";
let Action = "Action"
let ActionDate = "ActionDate"


// sync api constant
let kSyncCustomer = "Customer"
let kSyncBankAccount = "BankAccount"
let kSyncIdentification = "Identification"
let kSyncIncome = "Income"
let kSyncReference = "Reference"
let kSyncLoan = "Loan"
let kSetting = "Setting"
let kDebt = "Debt"
let kCustomer = "Customer"
let kNotification = "Notification"


// Final Submission API
let kContactByDate = "ContactByDate";
let kMessage1 = "Message1";
let kMessage2 = "Message2";
let kSupportPhone = "SupportPhone";
