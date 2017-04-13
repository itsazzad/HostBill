//
//  OrdersDetailsViewController.m
//  HostBill
//
//  Created by Sazzad Tushar Khan on 12/26/12.
//  Copyright (c) 2012 AppBoxNZ Limited. All rights reserved.
//

#import "AppDelegate.h"
#import "OrdersDetailsViewController.h"

@interface OrdersDetailsViewController (){
    NSMutableArray *_objects;
    NSMutableArray *_objects2;
    NSMutableArray *_objectsID;
    NSMutableArray *_tempobject;

}

@end

@implementation OrdersDetailsViewController
@synthesize string;//http://url_to_your_hostbill.com/admin/api.php?api_id=API_ID&api_key=API_KEY&call=FUNCTION
@synthesize string1;
@synthesize stringAction;
@synthesize stringActiveAction;
@synthesize tableView;


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"buttonIndex: %u",buttonIndex);

    self.stringActiveAction = [NSString stringWithFormat:@"%@", [actionSheet buttonTitleAtIndex:buttonIndex]];
    NSLog(@"stringActiveAction: %@", self.stringActiveAction);
    if ([self.stringActiveAction isEqualToString:@"Set to pending"]) {
        NSLog(@"Set to pending");
        self.stringAction = [NSString stringWithFormat:@"%@&call=setOrderPending&id=%@", string, self.detailItem];
        NSLog(@"%@",self.stringAction);
        [self doAction];
    }else if ([self.stringActiveAction isEqualToString:@"Activate order"]) {
        NSLog(@"Activate order");
        self.stringAction = [NSString stringWithFormat:@"%@&call=setOrderActive&id=%@", string, self.detailItem];
        NSLog(@"%@",self.stringAction);
        [self doAction];
    }else if ([self.stringActiveAction isEqualToString:@"Cancel order"]) {
        NSLog(@"Cancel order");
        self.stringAction = [NSString stringWithFormat:@"%@&call=setOrderCancel&id=%@", string, self.detailItem];
        NSLog(@"%@",self.stringAction);
        [self doAction];
    }else if ([self.stringActiveAction isEqualToString:@"Set to fraud"]) {
        NSLog(@"Set to fraud");
        self.stringAction = [NSString stringWithFormat:@"%@&call=setOrderFraud&id=%@", string, self.detailItem];
        NSLog(@"%@",self.stringAction);
        [self doAction];
    }else if ([self.stringActiveAction isEqualToString:@"Delete order"]) {
        NSLog(@"Delete order");
        self.stringAction = [NSString stringWithFormat:@"%@&call=deleteOrder&id=%@", string, self.detailItem];
        NSLog(@"%@",self.stringAction);
    }
    NSLog(@"Cancel Action");
    
}
- (IBAction)dialogOtherAction:(id)sender
{
	// open a dialog with two custom buttons
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Order Actions"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Set to pending", @"Activate order", @"Cancel order", @"Set to fraud", @"Delete order",
                                  nil];
    
	actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
	actionSheet.destructiveButtonIndex = 4;	// make the second button red (destructive)
    //-[UIActionSheet showFromTabBar:] or -[UIActionSheet showFromToolbar:]
	//[actionSheet showInView:self.view];
	[actionSheet showFromTabBar:self.tabBarController.tabBar];
	//[actionSheet showFromToolbar:self.navigationController.toolbar];
}
/*
- (IBAction)doSomething:(id)sender{
    
    //NSLog(@"sender: %@", [[sender titleLabel] text]);
    self.stringActiveAction = [NSString stringWithFormat:@"%@", [[sender titleLabel] text]];
    if ([[[sender titleLabel] text] isEqualToString:@"Activate order"]) {
        NSLog(@"Activate order");
        self.stringAction = [NSString stringWithFormat:@"%@&call=setOrderActive&id=%@", string, self.detailItem];
        NSLog(@"%@",self.stringAction);
        [self doAction];
    }else if ([[[sender titleLabel] text] isEqualToString:@"Set to pending"]) {
        NSLog(@"Set to pending");
        self.stringAction = [NSString stringWithFormat:@"%@&call=setOrderPending&id=%@", string, self.detailItem];
        NSLog(@"%@",self.stringAction);
        [self doAction];
    }else if ([[[sender titleLabel] text] isEqualToString:@"Set to fraud"]) {
        NSLog(@"Set to fraud");
        self.stringAction = [NSString stringWithFormat:@"%@&call=setOrderFraud&id=%@", string, self.detailItem];
        NSLog(@"%@",self.stringAction);
        [self doAction];
    }else if ([[[sender titleLabel] text] isEqualToString:@"Cancel order"]) {
        NSLog(@"Cancel order");
        self.stringAction = [NSString stringWithFormat:@"%@&call=setOrderCancel&id=%@", string, self.detailItem];
        NSLog(@"%@",self.stringAction);
        [self doAction];
    }else if ([[[sender titleLabel] text] isEqualToString:@"Delete order"]) {
        NSLog(@"Delete order");
        self.stringAction = [NSString stringWithFormat:@"%@&call=deleteOrder&id=%@", string, self.detailItem];
        NSLog(@"%@",self.stringAction);
        [self doAction];
    }else{
    
    }
    NSLog(@"Cancel Action");
}
 */
-(void)doAction
{
    NSError *error = nil;
    NSData *jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:stringAction]];
    
    if (jsonData) {
        NSDictionary *jsonObjects = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        
        NSLog(@"Obj: %@", jsonObjects);
        
        if (error) {
            NSLog(@"ERROR!!!NSJSONSerialization JSONObjectWithData:options:error is %@", [error localizedDescription]);
            
            // Handle Error and return
            return;
            
        }
        NSString *info = [[jsonObjects objectForKey:@"info"] objectAtIndex:0];
        NSLog(@"Info: %@", info);
        
        if (info == (id)[NSNull null] || info.length == 0) {
            //NSLog(@"NULL");
            [self.navigationItemPOD setPrompt:[NSString stringWithFormat:@"Order #%@ %@",self.detailItem, self.stringActiveAction]];

        }else{
            //NSLog(@"Not NULL");
            [self.navigationItemPOD setPrompt:[NSString stringWithFormat:@"%@ #%@",info,self.detailItem]];
        }
        [self getData];        
    } else {
        // Handle Error
        NSLog(@"doAction: ERROR!!! NSData dataWithContentsOfURL:URLWithString");
        return;
    }
}

- (void)setDetailItem:(id)newDetailItem
{
    NSLog(@"newDetailItem: %@", newDetailItem);
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
    
}
- (void)configureView
{
    // Update the user interface for the detail item.
    
    if (self.detailItem) {
        NSLog(@"Configure View");
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
    AppDelegate *AD = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.string = AD.URL;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"viewWillAppear");
    _objects = [[NSMutableArray alloc] init];
    _objects2 = [[NSMutableArray alloc] init];
    _objectsID = [[NSMutableArray alloc] init];
    [tableView reloadData];
}
- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"viewDidAppear");
    self.string1 = [NSString stringWithFormat:@"%@&call=getOrderDetails&id=%@", string, self.detailItem];
    NSLog(@"%@",self.string1);
    [self getData];
}

-(void)getData
{
    NSError *error = nil;
    NSData *jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:string1]];
    NSLog(@"getData from %@",self.string1);
    
    if (jsonData) {
        
        NSDictionary *jsonObjects = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        
        if (error) {
            NSLog(@"ERROR!!!NSJSONSerialization JSONObjectWithData:options:error is %@", [error localizedDescription]);
            
            // Handle Error and return
            return;
            
        }
        
        _tempobject = [jsonObjects valueForKey:@"details"];
        NSLog(@"%@", _tempobject);
        //NSLog(@"%@", [_tempobject valueForKey:@"id"]);
        [self.labelOrderNumber setText:[NSString stringWithFormat:@"Order # %@",[_tempobject valueForKey:@"number"]]];
        [self.labelPromotion setText:[NSString stringWithFormat:@"%@",[_tempobject valueForKey:@"balance"]]];
        [self.labelOrderStatus setText:[NSString stringWithFormat:@"%@",[_tempobject valueForKey:@"status"]]];
        [self.labelOrderID setText:[NSString stringWithFormat:@"ID: %@",[_tempobject valueForKey:@"id"]]];

        [self.labelOrderDate setText:[NSString stringWithFormat:@"%@",[_tempobject valueForKey:@"date_created"]]];
        [self.labelOrderIP setText:[NSString stringWithFormat:@"IP: %@",[_tempobject valueForKey:@"order_ip"]]];

        [self.labelOrderAmountPaid setText:[NSString stringWithFormat:@"Total: %@(%@)",[_tempobject valueForKey:@"total"], [_tempobject valueForKey:@"invstatus"]]];
        [self.labelOrderInvoiceMethod setText:[NSString stringWithFormat:@"Invoice # %@",[_tempobject valueForKey:@"invoice_id"]]];
        
    } else {
        // Handle Error
        NSLog(@"getData: ERROR!!! NSData dataWithContentsOfURL:URLWithString");
        return;
    }
}

- (id)initWithStyle:(UITableViewStyle)style
{
    //NSLog(@"initWithStyle");
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}




@end
