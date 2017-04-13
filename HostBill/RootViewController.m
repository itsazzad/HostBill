//
//  RootViewController.m
//  HostBill
//
//  Created by Sazzad Tushar Khan on 11/24/12.
//  Copyright (c) 2012 BaliaTech. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "OrdersDetailsViewController.h"

@interface RootViewController (){
    NSMutableArray *_objects;
    NSMutableArray *_tempobject;
    NSMutableArray *_tempobject2;
    int pendingCounter;
    AppDelegate *AD;
    int transactionsPage;
    float incomeThisYear;
    float incomeThisMonth;
    float incomeToday;
    NSMutableArray *_objectsID;
}

@end

@implementation RootViewController


@synthesize string;//http://url_to_your_hostbill.com/admin/api.php?api_id=API_ID&api_key=API_KEY&call=FUNCTION
@synthesize string1;
@synthesize string2;
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"prepareForSegue[RootView]: %@",[segue identifier]);
    if ([[segue identifier] isEqualToString:@"ordersPending"]) {
        NSLog(@"prepareForSegue[RootView]: %@",[segue identifier]);
        _objectsID = [[NSMutableArray alloc] init];
        [_objectsID insertObject:@"Pending" atIndex:0];
        NSDate *object = _objectsID[0];
        NSLog(@"object[RootView]: %@", object);
        [[segue destinationViewController] setDetailItem:object];
    }
    
}
-(void)getTransactions
{
    [AD.spinner startAnimating];
    incomeThisYear=0;
    incomeThisMonth=0;
    incomeToday=0;
    
    NSError *error = nil;
    NSData *jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:string2]];
    
    if (jsonData) {
        
        NSDictionary *jsonObjects = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        
        if (error) {
            NSLog(@"ERROR!!!NSJSONSerialization JSONObjectWithData:options:error is %@", [error localizedDescription]);
            
            // Handle Error and return
            [AD.spinner stopAnimating];
            return;
            
        }
        [AD getServerTime:[[jsonObjects valueForKey:@"server_time"] intValue]];
        
        NSLog(@"AD.server_time_year: %@", AD.server_time_year);
        
        //NSLog(@"jsonObjects: %@", jsonObjects);
        _tempobject2 = [jsonObjects valueForKey:@"transactions"];
        //NSLog(@"_tempobject2: %@", _tempobject2);
        NSMutableDictionary  *dictionary;
        //NSLog(@"XXX%u", [dictionary count]);
        int count = [_tempobject2 count];
        for (int i=0; i < count; i++) {
            dictionary = [_tempobject2 objectAtIndex: i];
            //NSLog (@"date: %@ ",[dictionary valueForKey:@"date"]);
            //NSLog (@"yyyy: %@ ",[AD convertDateTime:[NSString stringWithFormat:@"%@ +0000", [dictionary valueForKey:@"date"]] fromFormat:@"yyyy-MM-dd HH:mm:ss Z" toFormat:@"yyyy"]);
            
            //[AD convertDateTime:[NSString stringWithFormat:@"%@ +0000", [dictionary valueForKey:@"date"]] fromFormat:@"yyyy-MM-dd HH:mm:ss Z" toFormat:@"yyyy"];
            //[self convertDateTime:[NSString stringWithFormat:@"%@ +0000", [dictionary valueForKey:@"date"]] fromFormat:@"yyyy-MM-dd HH:mm:ss Z" toFormat:@"MM"];
            //[self convertDateTime:[NSString stringWithFormat:@"%@ +0000", [dictionary valueForKey:@"date"]] fromFormat:@"yyyy-MM-dd HH:mm:ss Z" toFormat:@"dd"];
            //NSLog(@"%@ vs %u vs %u",[AD convertDateTime:[NSString stringWithFormat:@"%@ %@", [dictionary valueForKey:@"date"], AD.server_time_zone] fromFormat:@"yyyy-MM-dd HH:mm:ss Z" toFormat:@"yyyy"], [[AD convertDateTime:[NSString stringWithFormat:@"%@ %@", [dictionary valueForKey:@"date"], AD.server_time_zone] fromFormat:@"yyyy-MM-dd HH:mm:ss Z" toFormat:@"yyyy"] intValue],[AD.server_time_year intValue]);
            if([[AD convertDateTime:[NSString stringWithFormat:@"%@ %@", [dictionary valueForKey:@"date"], AD.server_time_zone] fromFormat:@"yyyy-MM-dd HH:mm:ss Z" toFormat:@"yyyy"] intValue]==[AD.server_time_year intValue]){
                //NSLog(@"This Year:%@",dictionary);
                incomeThisYear = incomeThisYear + [[dictionary valueForKey:@"in"] floatValue];
                if([[AD convertDateTime:[NSString stringWithFormat:@"%@ %@", [dictionary valueForKey:@"date"], AD.server_time_zone] fromFormat:@"yyyy-MM-dd HH:mm:ss Z" toFormat:@"MM"] intValue]==[AD.server_time_month intValue]){
                    incomeThisMonth = incomeThisMonth + [[dictionary valueForKey:@"in"] floatValue];
                    if([[AD convertDateTime:[NSString stringWithFormat:@"%@ %@", [dictionary valueForKey:@"date"], AD.server_time_zone] fromFormat:@"yyyy-MM-dd HH:mm:ss Z" toFormat:@"dd"] intValue]==[AD.server_time_day intValue]){
                        incomeToday = incomeToday + [[dictionary valueForKey:@"in"] floatValue];
                    }else{
                    }
                }else{
                }
            }else{
                //NSLog(@"Not This Year:%@",dictionary);
            }
        }
        //Show Updated Income Statistics
        
        
    } else {
        // Handle Error
        NSLog(@"ERROR!!! NSData dataWithContentsOfURL:URLWithString");
        [AD.spinner stopAnimating];
        return;
    }
    
    [AD.spinner stopAnimating];
}



- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"RootViewController.h- (void)viewDidAppear:(BOOL)animated***");
    [self getData];
    self.labelIncomeToday.text = [NSString stringWithFormat:@"%@0.00 %@",[[AD.currenciesJSONObject valueForKey:@"main"] valueForKey:@"sign"], [[AD.currenciesJSONObject valueForKey:@"main"] valueForKey:@"code"]];
    self.labelIncomeThisMonth.text = [NSString stringWithFormat:@"%@0.00 %@",[[AD.currenciesJSONObject valueForKey:@"main"] valueForKey:@"sign"], [[AD.currenciesJSONObject valueForKey:@"main"] valueForKey:@"code"]];
    self.labelIncomeThisYear.text = [NSString stringWithFormat:@"%@0.00 %@",[[AD.currenciesJSONObject valueForKey:@"main"] valueForKey:@"sign"], [[AD.currenciesJSONObject valueForKey:@"main"] valueForKey:@"code"]];
    
    transactionsPage = 0;
    [self getTransactions];
    
    self.labelIncomeToday.text = [NSString stringWithFormat:@"%@%@ %@",[[AD.currenciesJSONObject valueForKey:@"main"] valueForKey:@"sign"], [NSString stringWithFormat:@"%.02f",incomeToday], [[AD.currenciesJSONObject valueForKey:@"main"] valueForKey:@"code"]];
    self.labelIncomeThisMonth.text = [NSString stringWithFormat:@"%@%@ %@",[[AD.currenciesJSONObject valueForKey:@"main"] valueForKey:@"sign"], [NSString stringWithFormat:@"%.02f",incomeThisMonth], [[AD.currenciesJSONObject valueForKey:@"main"] valueForKey:@"code"]];
    self.labelIncomeThisYear.text = [NSString stringWithFormat:@"%@%@ %@",[[AD.currenciesJSONObject valueForKey:@"main"] valueForKey:@"sign"], [NSString stringWithFormat:@"%.02f",incomeThisYear], [[AD.currenciesJSONObject valueForKey:@"main"] valueForKey:@"code"]];
}




-(void)getData
{
    NSLog(@"Root: getData");
    pendingCounter = 0;
    [AD.spinner startAnimating];
    NSError *error = nil;
    NSData *jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:string1]];
    
    if (jsonData) {
        
        NSDictionary *jsonObjects = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        
        if (error) {
            NSLog(@"ERROR!!!NSJSONSerialization JSONObjectWithData:options:error is %@", [error localizedDescription]);
            
            // Handle Error and return
            [AD.spinner stopAnimating];
            return;
            
        }
        
        _tempobject = [jsonObjects valueForKey:@"orders"];
        //NSLog(@"(((%@", array);
        NSMutableDictionary  *dictionary;
        //NSLog(@"XXX%u", [dictionary count]);
        int count = [_tempobject count];
        for (int i=0; i < count; i++) {
            dictionary = [_tempobject objectAtIndex: i];
            NSLog (@"Each>>%u>: %@ ",i, dictionary);
            //if ([[dictionary valueForKey:@"status"] isEqualToString:@"Pending"]) {
                pendingCounter++;
            //}
        }
        
        
    } else {
        // Handle Error
        NSLog(@"ERROR!!! NSData dataWithContentsOfURL:URLWithString");
        [AD.spinner stopAnimating];
        return;
    }
    NSLog(@"PO:%u",pendingCounter);
    //[self.buttonPendingOrders setTitle:[NSString stringWithFormat:@"%u",pendingCounter] forState:UIControlStateNormal];
    [self.buttonPendingOrders setAttributedTitle:[NSString stringWithFormat:@"%u",pendingCounter] forState:UIControlStateNormal];
    [self.buttonPendingOrders setAttributedTitle:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%u",pendingCounter]]  forState:UIControlStateNormal];
    [AD.spinner stopAnimating];
}

- (void)viewDidLoad
{
    NSLog(@"RootViewController.h- (void)viewDidLoad");
    [super viewDidLoad];
    
    AD = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.string = AD.URL;
    self.string1 = [NSString stringWithFormat:@"%@&call=getOrders&list=pending", string];
    self.string2 = [NSString stringWithFormat:@"%@&call=getTransactions", string];
    [self.view addSubview:AD.spinner];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(becomeActive:)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
}

- (void)becomeActive:(NSNotification *)notification {
    NSLog(@"becoming active");
    [AD handleRegisterDefaultsFromSettingsBundle];
    [self getData];
}

- (void)didReceiveMemoryWarning
{
    NSLog(@"RootViewController.h- (void)didReceiveMemoryWarning");
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"RootViewController.h- (void)viewWillAppear:(BOOL)animated");
    
    //AD.spinner.center = self.view.center;
    /*
     Register 'inspector' to receive change notifications for the "openingBalance" property of
     the 'account' object and specify that both the old and new values of "openingBalance"
     should be provided in the observe… method.
     */
}


- (void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"RootViewController.h- (void)viewWillDisappear:(BOOL)animated");
}

- (void)viewDidDisappear:(BOOL)animated
{
    NSLog(@"RootViewController.h- (void)viewDidDisappear:(BOOL)animated");
}





- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}



@end
