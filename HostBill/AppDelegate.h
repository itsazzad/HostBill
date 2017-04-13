//
//  AppDelegate.h
//  HostBill
//
//  Created by Sazzad Tushar Khan on 11/24/12.
//  Copyright (c) 2012 BaliaTech. All rights reserved.
//
//http://completedomains.co.nz/admin/api.php?api_id=736d79b800274547f6fc&api_key=b2e8e4eb4d181cdb0c51&call=getAPIMethods
/*
 TODO:
 -------------------------
 "getAPIMethods",
 "getHostBillversion",
 "getClientDetails",
 "setClientDetails",
 "getClients",
 "getClientOrders",
 "getClientStats",
 "getClientAccounts",
 "getClientTransactions",
 "getClientInvoices",
 "getClientDomains",
 "getClientEmails",
 "getInvoices",
 "getInvoicesPDF",
 "getInvoiceDetails",
 "getOrders",
 "getOrderDetails",
 "getAccounts",
 "getAccountDetails",
 "getAddons",
 "getAddonDetails",
 "getDomains",
 "getDomainDetails",
 "getTransactions",
 "getTransactionDetails",
 "getTickets",
 "getTicketDetails",
 "getNews",
 "getNewsItem",
 "getKBCategories",
 "getKBArticle",
 "getAppGroups",
 "getAppServers",
 "getServerDetails",
 "getOrderPages",
 "getProducts",
 "getProductDetails",
 "getProductApplicableAddons",
 "getProductUpgrades",
 "getEstimates",
 "getEstimateDetails",
 "getCurrencies",
 "getClientTickets",
 "getPopularPredefinedReplies",
 "getPredefinedReply",
 "getPredefinedReplies",
 "getTicketDepts",
 "getPaymentModules",
 "setTicketStatus",
 "setTicketPriority",
 "setInvoiceStatus",
 "setEstimateStatus",
 "setOrderPending",
 "setOrderActive",
 "setOrderCancel",
 "setOrderFraud",
 "accountCreate",
 "accountSuspend",
 "accountUnsuspend",
 "accountTerminate",
 "editAccountDetails",
 "editInvoiceDetails",
 "editEstimateDetails",
 "deleteTicket",
 "deleteInvoice",
 "deleteEstimate",
 "deleteClient",
 "deleteOrder",
 "sendMessage",
 "sendInvoice",
 "sendEstimate",
 "addTicketReply",
 "addTicketNotes",
 "addInvoice",
 "addEstimate",
 "addInvoiceItem",
 "addInvoicePayment",
 "addTicketDept",
 "addClient",
 "chargeCreditCard",
 "editClientCreditCard",
 "addOrder",
 "orderUpgrade",
 "orderConfigUpgrade",
 "verifyClientLogin",
 "addLanguageLines",
 "addTicket",
 "meteredAddUsage",
 "meteredGetUsage",
 "meteredGetVariables",
 "addClientCredit",
 "sendMobileClientNotify",
 "sendMobileStaffNotify",
 "getClientFiles",
 "addClientFile",
 "deleteClientFile",
 "tokenizeClientCard",
 "module"
 */
#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    NSString   *   URL;
    NSString   *   url_to_your_hostbill;
    NSString   *   API_ID;
    NSString   *   API_KEY;
    NSString   *   stringCurrencies;
    NSDictionary *currenciesJSONObject;
    UIActivityIndicatorView * spinner;
    NSString   *    server_time_year;
    NSString   *    server_time_month;
    NSString   *    server_time_day;
    NSString   *    server_time_hour;
    NSString   *    server_time_minute;
    NSString   *    server_time_second;
    NSString   *    server_time_zone;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIActivityIndicatorView * spinner;
@property (nonatomic, strong, readwrite) NSString   *   URL;
@property (nonatomic, strong, readwrite) NSString   *   url_to_your_hostbill;
@property (nonatomic, strong, readwrite) NSString   *   API_ID;
@property (nonatomic, strong, readwrite) NSString   *   API_KEY;
@property (nonatomic, strong, readwrite) NSString   *   stringCurrencies;
@property (nonatomic, strong, readwrite) NSDictionary *currenciesJSONObject;
@property (nonatomic, strong, readwrite) NSString   *    server_time_year;
@property (nonatomic, strong, readwrite) NSString   *    server_time_month;
@property (nonatomic, strong, readwrite) NSString   *    server_time_day;
@property (nonatomic, strong, readwrite) NSString   *    server_time_hour;
@property (nonatomic, strong, readwrite) NSString   *    server_time_minute;
@property (nonatomic, strong, readwrite) NSString   *    server_time_second;
@property (nonatomic, strong, readwrite) NSString   *    server_time_zone;
- (void)handleRegisterDefaultsFromSettingsBundle;
-(NSString *)convertDateTime:(NSString *)datetimeString fromFormat:(NSString *)fromFormat toFormat:(NSString *)toFormat;
-(void)getServerTime:(int)server_time;
@end
/*
DONE:
-------------------------------------
 
*/

