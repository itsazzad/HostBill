//
//  ClientsActionsViewController.m
//  HostBill
//
//  Created by Sazzad Tushar Khan on 2/10/13.
//  Copyright (c) 2013 AppBoxNZ Limited. All rights reserved.
//

#import "AppDelegate.h"
#import "ClientsActionsViewController.h"
#import "ClientsDetailsViewController.h"

@interface ClientsActionsViewController (){
    NSMutableArray *_objectsID;
    UITableViewCell *activeCell;

}

@end

@implementation ClientsActionsViewController
@synthesize string;//http://url_to_your_hostbill.com/admin/api.php?api_id=API_ID&api_key=API_KEY&call=FUNCTION
@synthesize stringAction;

- (void)addInvoice
{
    NSLog(@"Add Invoice");
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
        
        NSNumber *success = [jsonObjects valueForKey:@"success"];
        NSLog(@"success: %@", success);
        NSString *invoice_id = [jsonObjects valueForKey:@"invoice_id"];
        NSLog(@"invoice_id: %@", invoice_id);
        
        if ([success boolValue]) {
            NSLog(@"Not NULL");
            [self.navigationItemPOD setPrompt:[NSString stringWithFormat:@"Invoice#%@ for the client#%@ created successfully",invoice_id, self.detailItem]];
        }else{
            NSLog(@"NULL");
            [self.navigationItemPOD setPrompt:[NSString stringWithFormat:@"Failed to create invoice for the client#%@",self.detailItem]];
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
    if ([self.stringActiveAction isEqualToString:@"Add"]){
        NSLog(@"%@",self.detailItem);
        self.stringAction = [NSString stringWithFormat:@"%@&call=addInvoice&client_id=%@", string, self.detailItem];
        [self addInvoice];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    self->activeCell = (UITableViewCell *)[(UITableView *)self.view cellForRowAtIndexPath:indexPath];
    if ([[self->activeCell reuseIdentifier] isEqualToString:@"addInvoice"]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Are you sure you want to create invoice?"
                                                        message:@"Note: New invoice status will be set to DRAFT, so customer wont be able to see it, after finishing work with invoice you can make it viewable by changing its status to Unpaid."
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Add",
                              nil];
        alert.alertViewStyle = UIAlertViewStyleDefault;
        [alert show];
    }
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"prepareForSegue[Actions]: %@",[segue identifier]);
    if ([[segue identifier] isEqualToString:@"showClientDetails"]) {
        NSLog(@"prepareForSegue[Actions]: %@",[segue identifier]);
        NSLog(@"object[Actions]: %@", _objectsID[0]);
        [[segue destinationViewController] setDetailItem:_objectsID[0]];
    }
    
}
- (void)setDetailItem:(id)newDetailItem
{
    NSLog(@"newDetailItem[Actions]: %@", newDetailItem);
    if (_detailItem != newDetailItem) {
        /*Get segue id*/
        _objectsID = [[NSMutableArray alloc] init];
        [_objectsID insertObject:newDetailItem atIndex:0];
        NSLog(@"_objectsID[Actions]: %@",_objectsID);
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
