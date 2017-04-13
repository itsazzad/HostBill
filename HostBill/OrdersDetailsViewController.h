//
//  OrdersDetailsViewController.h
//  HostBill
//
//  Created by Sazzad Tushar Khan on 12/26/12.
//  Copyright (c) 2012 AppBoxNZ Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrdersDetailsViewController : UITableViewController <UIActionSheetDelegate>

@property (strong, nonatomic) id detailItem;//Comes from the parent view


@property (weak, nonatomic) IBOutlet UINavigationItem *navigationItemPOD;
@property (weak, nonatomic) IBOutlet UILabel *labelOrderNumber;
@property (weak, nonatomic) IBOutlet UILabel *labelPromotion;
@property (weak, nonatomic) IBOutlet UILabel *labelOrderStatus;
@property (weak, nonatomic) IBOutlet UILabel *labelOrderID;

@property (weak, nonatomic) IBOutlet UILabel *labelOrderDate;
@property (weak, nonatomic) IBOutlet UILabel *labelOrderIP;

@property (weak, nonatomic) IBOutlet UILabel *labelOrderAmountPaid;
@property (weak, nonatomic) IBOutlet UILabel *labelOrderInvoiceMethod;

@property (weak, nonatomic) IBOutlet UIButton *buttonAccept;
@property (weak, nonatomic) IBOutlet UIButton *buttonSetAsPending;
@property (weak, nonatomic) IBOutlet UIButton *buttonSetAsFraud;
@property (weak, nonatomic) IBOutlet UIButton *buttonCancel;
@property (weak, nonatomic) IBOutlet UIButton *buttonDelete;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButtonItemAction;



@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong, readwrite) NSString           *   string;
@property (nonatomic, strong, readwrite) NSString           *   string1;
@property (nonatomic, strong, readwrite) NSString           *   stringAction;
@property (nonatomic, strong, readwrite) NSString           *   stringActiveAction;
//- (IBAction)doSomething:(id)sender;
- (IBAction)dialogOtherAction:(id)sender;

//@property (strong, nonatomic) UIActionSheet *actionSheet;

@end
