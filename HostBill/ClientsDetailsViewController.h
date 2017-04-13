//
//  ClientsDetailsViewController.h
//  HostBill
//
//  Created by Sazzad Tushar Khan on 1/15/13.
//  Copyright (c) 2013 AppBoxNZ Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClientsDetailsViewController : UITableViewController <UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UINavigationItem *navigationItemPOD;
@property (strong, nonatomic) id detailItem;//Comes from the parent view

@property (weak, nonatomic) IBOutlet UILabel *labelid;
@property (weak, nonatomic) IBOutlet UILabel *labelfirstname;
@property (weak, nonatomic) IBOutlet UILabel *labellastname;
@property (weak, nonatomic) IBOutlet UILabel *labelcompanyname;
@property (weak, nonatomic) IBOutlet UILabel *labeladdress1;
@property (weak, nonatomic) IBOutlet UILabel *labeladdress2;
@property (weak, nonatomic) IBOutlet UILabel *labelcity;
@property (weak, nonatomic) IBOutlet UILabel *labelstate;
@property (weak, nonatomic) IBOutlet UILabel *labelpostcode;
@property (weak, nonatomic) IBOutlet UILabel *labelcountry;
@property (weak, nonatomic) IBOutlet UILabel *labelphonenumber;
@property (weak, nonatomic) IBOutlet UILabel *labelemail;
@property (weak, nonatomic) IBOutlet UILabel *labelpassword;
@property (weak, nonatomic) IBOutlet UILabel *labellastlogin;
@property (weak, nonatomic) IBOutlet UILabel *labelip;
@property (weak, nonatomic) IBOutlet UILabel *labelhost;
@property (weak, nonatomic) IBOutlet UILabel *labelstatus;
@property (weak, nonatomic) IBOutlet UILabel *labelparent_id;
@property (weak, nonatomic) IBOutlet UILabel *labeldatecreated;
@property (weak, nonatomic) IBOutlet UILabel *labelnotes;
@property (weak, nonatomic) IBOutlet UILabel *labellanguage;
@property (weak, nonatomic) IBOutlet UILabel *labelcompany;
@property (weak, nonatomic) IBOutlet UILabel *labelcredit;
@property (weak, nonatomic) IBOutlet UILabel *labeltaxexempt;
@property (weak, nonatomic) IBOutlet UILabel *labellatefeeoveride;
@property (weak, nonatomic) IBOutlet UILabel *labelcardtype;
@property (weak, nonatomic) IBOutlet UILabel *labelcardnum;
@property (weak, nonatomic) IBOutlet UILabel *labelexpdate;
@property (weak, nonatomic) IBOutlet UILabel *labeloverideduenotices;
@property (weak, nonatomic) IBOutlet UILabel *labelclient_id;
@property (weak, nonatomic) IBOutlet UILabel *labelcurrency_id;
@property (weak, nonatomic) IBOutlet UILabel *labelcountryname;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong, readwrite) NSString           *   string;
@property (nonatomic, strong, readwrite) NSString           *   string1;
@property (nonatomic, strong, readwrite) NSString           *   stringAction;
@property (nonatomic, strong, readwrite) NSString           *   stringActiveAction;


@end
