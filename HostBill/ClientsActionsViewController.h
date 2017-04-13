//
//  ClientsActionsViewController.h
//  HostBill
//
//  Created by Sazzad Tushar Khan on 2/10/13.
//  Copyright (c) 2013 AppBoxNZ Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClientsActionsViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationItemPOD;
@property (strong, nonatomic) id detailItem;//Comes from the parent view
@property (nonatomic, strong, readwrite) NSString           *   string;
@property (nonatomic, strong, readwrite) NSString           *   stringAction;
@property (nonatomic, strong, readwrite) NSString           *   stringActiveAction;

@end
