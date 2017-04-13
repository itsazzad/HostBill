//
//  ClientsDetailsViewController.m
//  HostBill
//
//  Created by Sazzad Tushar Khan on 1/15/13.
//  Copyright (c) 2013 AppBoxNZ Limited. All rights reserved.
//

#import "AppDelegate.h"
#import "ClientsDetailsViewController.h"

@interface ClientsDetailsViewController (){
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

@implementation ClientsDetailsViewController
@synthesize string;//http://url_to_your_hostbill.com/admin/api.php?api_id=API_ID&api_key=API_KEY&call=FUNCTION
@synthesize string1;
@synthesize stringAction;
@synthesize tableView;
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
        self.stringAction = [NSString stringWithFormat:@"%@&call=setClientDetails&id=%@&%@=%@", string, self.detailItem, self->editedParameterName, self->editedParameterValue];
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
    //NSLog(@"viewDidAppear");
    self.string1 = [NSString stringWithFormat:@"%@&call=getClientDetails&id=%@", string, self.detailItem];
    NSLog(@"%@",self.string1);
    [self getData];
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
        
        _tempobject = [jsonObjects valueForKey:@"client"];
        NSLog(@"getClientDetails: %@", _tempobject);
        
        
        //NSLog(@"%@", [_tempobject valueForKey:@"id"]);

        [self.labelid setText:[NSString stringWithFormat:@"%@",[_tempobject valueForKey:@"id"]]];
        
        [self.labelfirstname setText:[NSString stringWithFormat:@"%@",[_tempobject valueForKey:@"firstname"]]];
        [self.labellastname setText:[NSString stringWithFormat:@"%@",[_tempobject valueForKey:@"lastname"]]];
        [self.labelcompanyname setText:[NSString stringWithFormat:@"%@",[_tempobject valueForKey:@"companyname"]]];
        [self.labeladdress1 setText:[NSString stringWithFormat:@"%@",[_tempobject valueForKey:@"address1"]]];
        [self.labeladdress2 setText:[NSString stringWithFormat:@"%@",[_tempobject valueForKey:@"address2"]]];
        [self.labelcity setText:[NSString stringWithFormat:@"%@",[_tempobject valueForKey:@"city"]]];
        [self.labelstate setText:[NSString stringWithFormat:@"%@",[_tempobject valueForKey:@"state"]]];
        [self.labelpostcode setText:[NSString stringWithFormat:@"%@",[_tempobject valueForKey:@"postcode"]]];
        [self.labelcountry setText:[NSString stringWithFormat:@"%@",[_tempobject valueForKey:@"country"]]];
        [self.labelphonenumber setText:[NSString stringWithFormat:@"%@",[_tempobject valueForKey:@"phonenumber"]]];
        
        [self.labelemail setText:[NSString stringWithFormat:@"%@",[_tempobject valueForKey:@"email"]]];
        [self.labelpassword setText:[NSString stringWithFormat:@"%@",[_tempobject valueForKey:@"password"]]];
        [self.labellastlogin setText:[NSString stringWithFormat:@"%@",[_tempobject valueForKey:@"lastlogin"]]];
        [self.labelip setText:[NSString stringWithFormat:@"%@",[_tempobject valueForKey:@"ip"]]];
        [self.labelhost setText:[NSString stringWithFormat:@"%@",[_tempobject valueForKey:@"host"]]];
        [self.labelstatus setText:[NSString stringWithFormat:@"%@",[_tempobject valueForKey:@"status"]]];
        [self.labelparent_id setText:[NSString stringWithFormat:@"%@",[_tempobject valueForKey:@"parent_id"]]];
        [self.labeldatecreated setText:[NSString stringWithFormat:@"%@",[_tempobject valueForKey:@"datecreated"]]];
        [self.labelnotes setText:[NSString stringWithFormat:@"%@",[_tempobject valueForKey:@"notes"]]];
        [self.labellanguage setText:[NSString stringWithFormat:@"%@",[_tempobject valueForKey:@"language"]]];
        [self.labelcompany setText:[NSString stringWithFormat:@"%@",[_tempobject valueForKey:@"company"]]];
        [self.labelcredit setText:[NSString stringWithFormat:@"%@",[_tempobject valueForKey:@"credit"]]];
        [self.labeltaxexempt setText:[NSString stringWithFormat:@"%@",[_tempobject valueForKey:@"taxexempt"]]];
        [self.labellatefeeoveride setText:[NSString stringWithFormat:@"%@",[_tempobject valueForKey:@"latefeeoveride"]]];
        [self.labelcardtype setText:[NSString stringWithFormat:@"%@",[_tempobject valueForKey:@"cardtype"]]];
        [self.labelcardnum setText:[NSString stringWithFormat:@"%@",[_tempobject valueForKey:@"cardnum"]]];
        [self.labelexpdate setText:[NSString stringWithFormat:@"%@",[_tempobject valueForKey:@"expdate"]]];
        [self.labeloverideduenotices setText:[NSString stringWithFormat:@"%@",[_tempobject valueForKey:@"overideduenotices"]]];
        [self.labelclient_id setText:[NSString stringWithFormat:@"%@",[_tempobject valueForKey:@"client_id"]]];
        [self.labelcurrency_id setText:[NSString stringWithFormat:@"%@",[_tempobject valueForKey:@"currency_id"]]];
        [self.labelcountryname setText:[NSString stringWithFormat:@"%@",[_tempobject valueForKey:@"countryname"]]];

    } else {
        // Handle Error
        NSLog(@"ERROR!!! NSData dataWithContentsOfURL:URLWithString");
        return;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view delegate


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
}
@end
