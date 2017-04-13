//
//  InvoicesListViewController.h
//  HostBill
//
//  Created by Sazzad Tushar Khan on 11/24/12.
//  Copyright (c) 2012 BaliaTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InvoicesListViewController : UITableViewController
@property (strong, nonatomic) id detailItem;//Comes from the parent view
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong, readwrite) NSString           *   string;
@property (nonatomic, strong, readwrite) NSString           *   string1;
@end
