//
//  RootViewController.h
//  HostBill
//
//  Created by Sazzad Tushar Khan on 11/24/12.
//  Copyright (c) 2012 BaliaTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UITableViewCell *cellPendingOrders;

@property (weak, nonatomic) IBOutlet UILabel *labelIncomeToday;
@property (weak, nonatomic) IBOutlet UILabel *labelIncomeThisMonth;
@property (weak, nonatomic) IBOutlet UILabel *labelIncomeThisYear;

@property (weak, nonatomic) IBOutlet UIButton *buttonPendingOrders;






@property (nonatomic, strong, readwrite) NSString           *   string;
@property (nonatomic, strong, readwrite) NSString           *   string1;
@property (nonatomic, strong, readwrite) NSString           *   string2;

@end