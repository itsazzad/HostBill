//
//  ClientsViewController.h
//  hostbill
//
//  Created by Sazzad Tushar Khan on 12/7/12.
//  Copyright (c) 2012 AppBoxNZ Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ClientsDetailsViewController;
@interface ClientsViewController : UITableViewController
@property (strong, nonatomic) ClientsDetailsViewController *detailViewController;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *buttonPage;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;


@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong, readwrite) NSString           *   string;
@property (nonatomic, strong, readwrite) NSString           *   string1;

- (IBAction)doPageAction:(id)sender;
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationItemC;

@property (nonatomic, readonly) id destinationViewController;
@end
