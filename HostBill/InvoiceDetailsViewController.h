//
//  InvoiceDetailsViewController.h
//  HostBill
//
//  Created by Sazzad Tushar Khan on 2/18/13.
//  Copyright (c) 2013 AppBoxNZ Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InvoiceDetailsViewController : UITableViewController <UIActionSheetDelegate>

@property (strong, nonatomic) id detailItem;//Comes from the parent view
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationItemPOD;
- (IBAction)dialogOtherAction:(id)sender;

@property (nonatomic, strong, readwrite) NSString           *   string;
@property (nonatomic, strong, readwrite) NSString           *   string1;
@property (nonatomic, strong, readwrite) NSString           *   stringAction;
@property (nonatomic, strong, readwrite) NSString           *   stringActiveAction;

@property (weak, nonatomic) IBOutlet UILabel *labelid;

@property (weak, nonatomic) IBOutlet UILabel *labelcredit;
@property (weak, nonatomic) IBOutlet UILabel *labeldate;
@property (weak, nonatomic) IBOutlet UILabel *labelduedate;
@property (weak, nonatomic) IBOutlet UILabel *labelpayment_module;
@property (weak, nonatomic) IBOutlet UILabel *labeltaxrate;
@property (weak, nonatomic) IBOutlet UILabel *labeltaxrate2;

@property (weak, nonatomic) IBOutlet UILabel *labelpaid_id;
@property (weak, nonatomic) IBOutlet UILabel *labelrecurring_id;
@property (weak, nonatomic) IBOutlet UILabel *labelstatus;
@property (weak, nonatomic) IBOutlet UILabel *labelclient_id;
@property (weak, nonatomic) IBOutlet UILabel *labeldatepaid;
@property (weak, nonatomic) IBOutlet UILabel *labelsubtotal;
@property (weak, nonatomic) IBOutlet UILabel *labeltax;
@property (weak, nonatomic) IBOutlet UILabel *labeltax2;
@property (weak, nonatomic) IBOutlet UILabel *labeltotal;
@property (weak, nonatomic) IBOutlet UILabel *labelcurrency_id;
@property (weak, nonatomic) IBOutlet UILabel *labelrate;
@property (weak, nonatomic) IBOutlet UILabel *labelnotes;
@property (weak, nonatomic) IBOutlet UILabel *labelgateway;

@property (weak, nonatomic) IBOutlet UILabel *labelclientid;
@property (weak, nonatomic) IBOutlet UILabel *labelclientemail;
@property (weak, nonatomic) IBOutlet UILabel *labelclientpassword;
@property (weak, nonatomic) IBOutlet UILabel *labelclientlastlogin;
@property (weak, nonatomic) IBOutlet UILabel *labelclientip;
@property (weak, nonatomic) IBOutlet UILabel *labelclienthost;
@property (weak, nonatomic) IBOutlet UILabel *labelclientstatus;
@property (weak, nonatomic) IBOutlet UILabel *labelclientparent_id;
@property (weak, nonatomic) IBOutlet UILabel *labelclientfirstname;
@property (weak, nonatomic) IBOutlet UILabel *labelclientlastname;
@property (weak, nonatomic) IBOutlet UILabel *labelclientcompanyname;
@property (weak, nonatomic) IBOutlet UILabel *labelclientaddress1;
@property (weak, nonatomic) IBOutlet UILabel *labelclientaddress2;
@property (weak, nonatomic) IBOutlet UILabel *labelclientcity;
@property (weak, nonatomic) IBOutlet UILabel *labelclientstate;
@property (weak, nonatomic) IBOutlet UILabel *labelclientpostcode;
@property (weak, nonatomic) IBOutlet UILabel *labelclientcountry;
@property (weak, nonatomic) IBOutlet UILabel *labelclientphonenumber;
@property (weak, nonatomic) IBOutlet UILabel *labelclientdatecreated;
@property (weak, nonatomic) IBOutlet UILabel *labelclientnotes;
@property (weak, nonatomic) IBOutlet UILabel *labelclientlanguage;
@property (weak, nonatomic) IBOutlet UILabel *labelclientcompany;
@property (weak, nonatomic) IBOutlet UILabel *labelclientcredit;
@property (weak, nonatomic) IBOutlet UILabel *labelclienttaxexempt;
@property (weak, nonatomic) IBOutlet UILabel *labelclientlatefeeoveride;
@property (weak, nonatomic) IBOutlet UILabel *labelclientoverideduenotices;
@property (weak, nonatomic) IBOutlet UILabel *labelclientclient_id;
@property (weak, nonatomic) IBOutlet UILabel *labelclientcardnum;
@property (weak, nonatomic) IBOutlet UILabel *labelclientcurrency_id;
@property (weak, nonatomic) IBOutlet UILabel *labelclientprivileges;


@end














