//
//  InvoiceDetailsViewController.m
//  HostBill
//
//  Created by Sazzad Tushar Khan on 2/18/13.
//  Copyright (c) 2013 AppBoxNZ Limited. All rights reserved.
//

#import "AppDelegate.h"
#import "InvoiceDetailsViewController.h"

@interface InvoiceDetailsViewController (){
    NSMutableArray *_objects;
    NSMutableArray *_objects2;
    NSMutableArray *_objectsID;
    NSMutableArray *_tempobject;
    UITextField *alertTextField;
    NSString * editedParameterName;
    NSString * editedParameterValue;
    UITableViewCell *activeCell;
}

@end

@implementation InvoiceDetailsViewController
@synthesize string;//http://url_to_your_hostbill.com/admin/api.php?api_id=API_ID&api_key=API_KEY&call=FUNCTION
@synthesize string1;
@synthesize stringAction;
-(void)doAction
{
    NSError *error = nil;
    NSData *jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:stringAction]];
    NSLog(@"%@",stringAction);
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
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"buttonIndex: %u",buttonIndex);
    self.stringActiveAction = [NSString stringWithFormat:@"%@", [actionSheet buttonTitleAtIndex:buttonIndex]];
    NSLog(@"stringActiveAction: %@", self.stringActiveAction);
    if ([self.stringActiveAction isEqualToString:@"Set status as Paid"]) {
        NSLog(@"Set status as Paid");
        self.stringAction = [NSString stringWithFormat:@"%@&call=setInvoiceStatus&id=%@&status=Paid", string, self.detailItem];
        NSLog(@"%@",self.stringAction);
        [self doAction];
    }else if ([self.stringActiveAction isEqualToString:@"Set status as Unpaid"]) {
        NSLog(@"Set status as Unpaid");
        self.stringAction = [NSString stringWithFormat:@"%@&call=setInvoiceStatus&id=%@&status=Unpaid", string, self.detailItem];
        NSLog(@"%@",self.stringAction);
        [self doAction];
    }else if ([self.stringActiveAction isEqualToString:@"Set status as Cancelled"]) {
        NSLog(@"Set status as Cancelled");
        self.stringAction = [NSString stringWithFormat:@"%@&call=setInvoiceStatus&id=%@&status=Cancelled", string, self.detailItem];
        NSLog(@"%@",self.stringAction);
        [self doAction];
    }else if ([self.stringActiveAction isEqualToString:@"Set status as Draft"]) {
        NSLog(@"Set status as Draft");
        self.stringAction = [NSString stringWithFormat:@"%@&call=setInvoiceStatus&id=%@&status=Draft", string, self.detailItem];
        NSLog(@"%@",self.stringAction);
        [self doAction];
    }else if ([self.stringActiveAction isEqualToString:@"Send invoice to customer"]) {
        NSLog(@"Send invoice to customer");
        self.stringAction = [NSString stringWithFormat:@"%@&call=sendInvoice&id=%@", string, self.detailItem];
        NSLog(@"%@",self.stringAction);
        [self doAction];
    }else if ([self.stringActiveAction isEqualToString:@"Charge Credit Card"]) {
        NSLog(@"Charge Credit Card");
        self.stringAction = [NSString stringWithFormat:@"%@&call=chargeCreditCard&id=%@", string, self.detailItem];
        NSLog(@"%@",self.stringAction);
        [self doAction];
    }else if ([self.stringActiveAction isEqualToString:@"Delete Invoice"]) {
        NSLog(@"Delete Invoice");
        self.stringAction = [NSString stringWithFormat:@"%@&call=deleteInvoice&id=%@", string, self.detailItem];
        NSLog(@"%@",self.stringAction);
        [self doAction];
    }else{
        NSLog(@"Cancel Action");
    }
    
}
- (IBAction)dialogOtherAction:(id)sender
{
	// open a dialog with two custom buttons
	UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"Invoice Actions"
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:@"Delete Invoice"
                                  otherButtonTitles:
                                  @"Set status as Paid",
                                  @"Set status as Unpaid",
                                  @"Set status as Cancelled",
                                  @"Set status as Draft",
                                  @"Send invoice to customer",
                                  @"Charge Credit Card",
                                  nil];
    
	actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
	[actionSheet showFromTabBar:self.tabBarController.tabBar];
}

-(void)setClientDetails
{
    NSError *error = nil;
    NSLog(@"%@",self.stringAction);
    NSString *encodedString = [self.stringAction stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    NSLog(@"encodedString: %@",encodedString);
    
    
    NSData *jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:encodedString]];
    
    if (jsonData) {
        
        NSDictionary *jsonObjects = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        
        if (error) {
            NSLog(@"ERROR!!!NSJSONSerialization %@ JSONObjectWithData:options:error is %@",encodedString, [error localizedDescription]);
            
            // Handle Error and return
            return;
            
        }
        
        
        NSLog(@"jsonObjects: %@", jsonObjects);
        
        NSString *info = [[jsonObjects objectForKey:@"info"] objectAtIndex:0];
        NSLog(@"Info: %@", info);
        
        if (info == (id)[NSNull null] || info.length == 0) {
            //NSLog(@"NULL");
            [self.navigationItemPOD setPrompt:[NSString stringWithFormat:@"Info: #%@ %@",self.detailItem, self->editedParameterName]];
            
        }else{
            //NSLog(@"Not NULL");
            [self.navigationItemPOD setPrompt:[NSString stringWithFormat:@"#%@ %@ %@", self.detailItem, info, self->editedParameterName]];
            self->activeCell.detailTextLabel.text = self->editedParameterValue;
        }
        
        
    } else {
        // Handle Error
        NSLog(@"ERROR!!! NSData dataWithContentsOfURL:URLWithString %@", encodedString);
        return;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"buttonIndex: %u",buttonIndex);
    
    self.stringActiveAction = [NSString stringWithFormat:@"%@", [alertView buttonTitleAtIndex:buttonIndex]];
    //NSLog(@"stringActiveAction: %@", self.stringActiveAction);
    if ([self.stringActiveAction isEqualToString:@"Save"]){
        NSLog(@"Updated Text: %@",self->alertTextField.text);
        self->editedParameterValue = [NSString stringWithFormat:@"%@", self->alertTextField.text];
        self.stringAction = [NSString stringWithFormat:@"%@&call=editInvoiceDetails&id=%@&%@=%@", string, self.detailItem, self->editedParameterName, self->editedParameterValue];
        NSLog(@"%@",self.stringAction);
        [self setClientDetails];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    self->activeCell = (UITableViewCell *)[(UITableView *)self.view cellForRowAtIndexPath:indexPath];
    
    NSString * message = [NSString stringWithFormat:@"%@:", self->activeCell.textLabel.text];
    NSString * edittext = [NSString stringWithFormat:@"%@", self->activeCell.detailTextLabel.text];
    self->editedParameterName = [NSString stringWithFormat:@"%@", [self->activeCell reuseIdentifier]];
    self->editedParameterValue = [NSString stringWithFormat:@"%@", edittext];
    
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Are you sure you want to update?"
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Save",
                          nil];
    
	alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    self->alertTextField = [alert textFieldAtIndex:0];
    self->alertTextField.text = edittext;
    
    [alert show];
    
}

-(void)getData
{
    NSError *error = nil;
    NSData *jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:string1]];
    
    if (jsonData) {
        
        NSDictionary *jsonObjects = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        
        if (error) {
            NSLog(@"ERROR!!!NSJSONSerialization JSONObjectWithData:options:error is %@", [error localizedDescription]);
            
            // Handle Error and return
            return;
            
        }
        
        _tempobject = [jsonObjects valueForKey:@"invoice"];
        NSLog(@"getInvoiceDetails: %@", _tempobject);
        
        /*
        {
            locked = 0;
            metadata = "<null>";

            items =     (
                         {
                             amount = "1.00";
                             description = "test $1 - Test $1  (2012-12-12 - 2013-01-12)";
                             id = 6;
                             "invoice_id" = 6;
                             "item_id" = 5;
                             linetotal = 1;
                             qty = 1;
                             taxed = 0;
                             type = Hosting;
                         }
                         );

        }
         */

        [self.labelid setText:[NSString stringWithFormat:@"%@",[_tempobject valueForKey:@"id"]]];//

        [self.labelcredit setText:[NSString stringWithFormat:@"%@",[_tempobject valueForKey:@"credit"]]];//
        [self.labeldate setText:[NSString stringWithFormat:@"%@",[_tempobject valueForKey:@"date"]]];//
        [self.labelduedate setText:[NSString stringWithFormat:@"%@",[_tempobject valueForKey:@"duedate"]]];//
        [self.labelpayment_module setText:[NSString stringWithFormat:@"%@",[_tempobject valueForKey:@"payment_module"]]];//
        [self.labeltaxrate setText:[NSString stringWithFormat:@"%@",[_tempobject valueForKey:@"taxrate"]]];//
        [self.labeltaxrate2 setText:[NSString stringWithFormat:@"%@",[_tempobject valueForKey:@"taxrate2"]]];//

        [self.labelpaid_id setText:[NSString stringWithFormat:@"%@",[_tempobject valueForKey:@"paid_id"]]];//
        [self.labelrecurring_id setText:[NSString stringWithFormat:@"%@",[_tempobject valueForKey:@"recurring_id"]]];//
        [self.labelstatus setText:[NSString stringWithFormat:@"%@",[_tempobject valueForKey:@"status"]]];//
        [self.labelclient_id setText:[NSString stringWithFormat:@"%@",[_tempobject valueForKey:@"client_id"]]];//
        [self.labeldatepaid setText:[NSString stringWithFormat:@"%@",[_tempobject valueForKey:@"datepaid"]]];//
        [self.labelsubtotal setText:[NSString stringWithFormat:@"%@",[_tempobject valueForKey:@"subtotal"]]];//
        [self.labeltax setText:[NSString stringWithFormat:@"%@",[_tempobject valueForKey:@"tax"]]];//
        [self.labeltax2 setText:[NSString stringWithFormat:@"%@",[_tempobject valueForKey:@"tax2"]]];//
        [self.labeltotal setText:[NSString stringWithFormat:@"%@",[_tempobject valueForKey:@"total"]]];//
        [self.labelcurrency_id setText:[NSString stringWithFormat:@"%@",[_tempobject valueForKey:@"currency_id"]]];//
        [self.labelrate setText:[NSString stringWithFormat:@"%@",[_tempobject valueForKey:@"rate"]]];//
        [self.labelnotes setText:[NSString stringWithFormat:@"%@",[_tempobject valueForKey:@"notes"]]];//
        [self.labelgateway setText:[NSString stringWithFormat:@"%@",[_tempobject valueForKey:@"gateway"]]];//

        
        [self.labelclientid setText:[NSString stringWithFormat:@"%@",[[_tempobject valueForKey:@"client"] valueForKey:@"id"]]];//
        [self.labelclientemail setText:[NSString stringWithFormat:@"%@",[[_tempobject valueForKey:@"client"] valueForKey:@"email"]]];//
        [self.labelclientpassword setText:[NSString stringWithFormat:@"%@",[[_tempobject valueForKey:@"client"] valueForKey:@"password"]]];//
        [self.labelclientlastlogin setText:[NSString stringWithFormat:@"%@",[[_tempobject valueForKey:@"client"] valueForKey:@"lastlogin"]]];//
        [self.labelclientip setText:[NSString stringWithFormat:@"%@",[[_tempobject valueForKey:@"client"] valueForKey:@"ip"]]];//
        [self.labelclienthost setText:[NSString stringWithFormat:@"%@",[[_tempobject valueForKey:@"client"] valueForKey:@"host"]]];//
        [self.labelclientstatus setText:[NSString stringWithFormat:@"%@",[[_tempobject valueForKey:@"client"] valueForKey:@"status"]]];//
        [self.labelclientparent_id setText:[NSString stringWithFormat:@"%@",[[_tempobject valueForKey:@"client"] valueForKey:@"parent_id"]]];//
        [self.labelclientfirstname setText:[NSString stringWithFormat:@"%@",[[_tempobject valueForKey:@"client"] valueForKey:@"firstname"]]];//
        [self.labelclientlastname setText:[NSString stringWithFormat:@"%@",[[_tempobject valueForKey:@"client"] valueForKey:@"lastname"]]];//
        [self.labelclientcompanyname setText:[NSString stringWithFormat:@"%@",[[_tempobject valueForKey:@"client"] valueForKey:@"companyname"]]];//
        [self.labelclientaddress1 setText:[NSString stringWithFormat:@"%@",[[_tempobject valueForKey:@"client"] valueForKey:@"address1"]]];//
        [self.labelclientaddress2 setText:[NSString stringWithFormat:@"%@",[[_tempobject valueForKey:@"client"] valueForKey:@"address2"]]];//
        [self.labelclientcity setText:[NSString stringWithFormat:@"%@",[[_tempobject valueForKey:@"client"] valueForKey:@"city"]]];//
        [self.labelclientstate setText:[NSString stringWithFormat:@"%@",[[_tempobject valueForKey:@"client"] valueForKey:@"state"]]];//
        [self.labelclientpostcode setText:[NSString stringWithFormat:@"%@",[[_tempobject valueForKey:@"client"] valueForKey:@"postcode"]]];//
        [self.labelclientcountry setText:[NSString stringWithFormat:@"%@",[[_tempobject valueForKey:@"client"] valueForKey:@"country"]]];//
        [self.labelclientphonenumber setText:[NSString stringWithFormat:@"%@",[[_tempobject valueForKey:@"client"] valueForKey:@"phonenumber"]]];//
        [self.labelclientdatecreated setText:[NSString stringWithFormat:@"%@",[[_tempobject valueForKey:@"client"] valueForKey:@"datecreated"]]];//
        [self.labelclientnotes setText:[NSString stringWithFormat:@"%@",[[_tempobject valueForKey:@"client"] valueForKey:@"notes"]]];//
        [self.labelclientlanguage setText:[NSString stringWithFormat:@"%@",[[_tempobject valueForKey:@"client"] valueForKey:@"language"]]];//
        [self.labelclientcompany setText:[NSString stringWithFormat:@"%@",[[_tempobject valueForKey:@"client"] valueForKey:@"company"]]];//
        [self.labelclientcredit setText:[NSString stringWithFormat:@"%@",[[_tempobject valueForKey:@"client"] valueForKey:@"credit"]]];//
        [self.labelclienttaxexempt setText:[NSString stringWithFormat:@"%@",[[_tempobject valueForKey:@"client"] valueForKey:@"taxexempt"]]];//
        [self.labelclientlatefeeoveride setText:[NSString stringWithFormat:@"%@",[[_tempobject valueForKey:@"client"] valueForKey:@"latefeeoveride"]]];//
        [self.labelclientoverideduenotices setText:[NSString stringWithFormat:@"%@",[[_tempobject valueForKey:@"client"] valueForKey:@"overideduenotices"]]];//
        [self.labelclientclient_id setText:[NSString stringWithFormat:@"%@",[[_tempobject valueForKey:@"client"] valueForKey:@"client_id"]]];
        [self.labelclientcardnum setText:[NSString stringWithFormat:@"%@",[[_tempobject valueForKey:@"client"] valueForKey:@"cardnum"]]];//
        [self.labelclientcurrency_id setText:[NSString stringWithFormat:@"%@",[[_tempobject valueForKey:@"client"] valueForKey:@"currency_id"]]];//
        [self.labelclientprivileges setText:[NSString stringWithFormat:@"%@",[[_tempobject valueForKey:@"client"] valueForKey:@"privileges"]]];//
        
        
        
        
    } else {
        // Handle Error
        NSLog(@"ERROR!!! NSData dataWithContentsOfURL:URLWithString");
        return;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    //NSLog(@"viewDidAppear");
    self.string1 = [NSString stringWithFormat:@"%@&call=getInvoiceDetails&id=%@", string, self.detailItem];
    NSLog(@"%@",self.string1);
    [self getData];
}
/*
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath");
    NSLog(@">>>%@ %u",[cell reuseIdentifier], indexPath.row);
}
*/
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
    NSLog(@"viewDidLoad");
    AppDelegate *AD = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.string = AD.URL;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
