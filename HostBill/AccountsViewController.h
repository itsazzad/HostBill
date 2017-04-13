//
//  AccountsViewController.h
//  HostBill
//
//  Created by Sazzad Tushar Khan on 12/15/12.
//  Copyright (c) 2012 AppBoxNZ Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountsViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong, readwrite) NSString           *   string;
@property (nonatomic, strong, readwrite) NSString           *   string1;

@end
