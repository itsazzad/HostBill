//
//  OrdersListViewController.m
//  HostBill
//
//  Created by Sazzad Tushar Khan on 12/3/12.
//  Copyright (c) 2012 BaliaTech. All rights reserved.
//

#import "AppDelegate.h"
#import "OrdersListViewController.h"
#import "OrdersDetailsViewController.h"

@interface OrdersListViewController (){
    NSMutableArray *_objects;
    NSMutableArray *_objects2;
    NSMutableArray *_objectsID;
    NSMutableArray *_tempobject;
}


@end

@implementation OrdersListViewController
@synthesize string;//http://url_to_your_hostbill.com/admin/api.php?api_id=API_ID&api_key=API_KEY&call=FUNCTION
@synthesize string1;
@synthesize tableView;
- (void)setDetailItem:(id)newDetailItem
{
    NSLog(@"OrdersListViewController.h: %@", newDetailItem);
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"prepareForSegue: %@",[segue identifier]);
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];//2
        NSDate *object = _objectsID[indexPath.row];
        NSLog(@"object: %@", object);
        [[segue destinationViewController] setDetailItem:object];
    }
    
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
        
        _tempobject = [jsonObjects valueForKey:@"orders"];
        NSLog(@"Orders:%@",_tempobject);
        NSMutableDictionary  *dictionary;
        int count = [_tempobject count];
        for (int i=0; i < count; i++) {
            dictionary = [_tempobject objectAtIndex: i];
            if ([[NSString stringWithFormat:@"%@",self.detailItem] isEqualToString:@"Pending"]) {
                if ([[dictionary valueForKey:@"status"] isEqualToString:@"Pending"]) {
                    [_objectsID insertObject:[dictionary valueForKey:@"id"] atIndex:0];
                    NSString * title = [NSString stringWithFormat:@"%@: %@ %@",[dictionary valueForKey:@"id"], [dictionary valueForKey:@"firstname"], [dictionary valueForKey:@"lastname"]];
                    [_objects insertObject:title atIndex:0];
                    NSString * description = [NSString stringWithFormat:@"%@: %@",[dictionary valueForKey:@"number"],[dictionary valueForKey:@"total"]];
                    [_objects2 insertObject:description atIndex:0];
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                }

            }else{
                [_objectsID insertObject:[dictionary valueForKey:@"id"] atIndex:0];
                NSString * title = [NSString stringWithFormat:@"%@: %@ %@",[dictionary valueForKey:@"id"], [dictionary valueForKey:@"firstname"], [dictionary valueForKey:@"lastname"]];
                [_objects insertObject:title atIndex:0];
                NSString * description = [NSString stringWithFormat:@"%@: %@",[dictionary valueForKey:@"number"],[dictionary valueForKey:@"total"]];
                [_objects2 insertObject:description atIndex:0];
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            
            }
        }
        
        
    } else {
        // Handle Error
        NSLog(@"ERROR!!! NSData dataWithContentsOfURL:URLWithString");
        return;
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
    AppDelegate *AD = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.string = AD.URL;
    
    self.string1 = [NSString stringWithFormat:@"%@&call=getOrders&list=%@", string, self.detailItem];
    NSLog(@"%@", self.string1);
}

- (void)viewWillAppear:(BOOL)animated
{
    _objects = [[NSMutableArray alloc] init];
    _objects2 = [[NSMutableArray alloc] init];
    _objectsID = [[NSMutableArray alloc] init];
    [tableView reloadData];
}
- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"viewDidAppear");
    [self getData];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Pending Orders" forIndexPath:indexPath];
    
    cell.textLabel.text = _objects[indexPath.row];
    cell.detailTextLabel.text = _objects2[indexPath.row];
    return cell;
}

- (id)initWithStyle:(UITableViewStyle)style
{
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


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Number of rows is the number of time zones in the region for the specified section.
    
    return _objects.count;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}



@end
