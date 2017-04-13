//
//  InvoicesViewController.m
//  HostBill
//
//  Created by Sazzad Tushar Khan on 2/19/13.
//  Copyright (c) 2013 AppBoxNZ Limited. All rights reserved.
//

#import "InvoicesViewController.h"
#import "InvoicesListViewController.h"

@interface InvoicesViewController (){
    NSMutableArray *_objectsID;
}

@end

@implementation InvoicesViewController
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"InvoicesViewController.h prepareForSegue[Actions]: %@",[segue identifier]);
    //if ([[segue identifier] isEqualToString:@"showClientDetails"]) {
    NSLog(@"prepareForSegue[Actions]: %@",[segue identifier]);
    _objectsID = [[NSMutableArray alloc] init];
    [_objectsID insertObject:[segue identifier] atIndex:0];
    NSLog(@"_objectsID[Actions]: %@",_objectsID);
    
    NSLog(@"object[Actions]: %@", _objectsID[0]);
    [[segue destinationViewController] setDetailItem:_objectsID[0]];
    //}
    
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
