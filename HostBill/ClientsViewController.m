//
//  ClientsViewController.m
//  hostbill
//
//  Created by Sazzad Tushar Khan on 12/7/12.
//  Copyright (c) 2012 AppBoxNZ Limited. All rights reserved.
//

#import "AppDelegate.h"
#import "ClientsViewController.h"
#import "ClientsActionsViewController.h"

//#define kViewTag				1		//for tagging our embedded controls for removal at cell recycle time

@interface ClientsViewController (){
    NSMutableArray *_objects;
    NSMutableArray *_objects2;
    NSMutableArray *_tempobject;
    NSMutableArray *_objectsID;

    int numberOfPages;
    int currentPage;
   
}
@end

@implementation ClientsViewController
@synthesize string;//http://url_to_your_hostbill.com/admin/api.php?api_id=API_ID&api_key=API_KEY&call=FUNCTION
@synthesize string1;
@synthesize tableView;
@synthesize pageControl;

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"prepareForSegue: %@",[segue identifier]);
    if ([[segue identifier] isEqualToString:@"showClientActions"]) {
        NSLog(@"prepareForSegue: %@",[segue identifier]);
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSLog(@"indexPath.row: %u",indexPath.row);
        NSDate *object = _objectsID[indexPath.row];
        NSLog(@"object: %@", object);
        [[segue destinationViewController] setDetailItem:object];
    }
    
}

- (IBAction)doPageAction:(id)sender{
    NSLog(@"sender: %u", [sender currentPage]);
    currentPage = [sender currentPage];
    self.string1 = [NSString stringWithFormat:@"%@&call=getClients&page=%u", string, currentPage];
    [self getData];
}
- (UIPageControl *)pageControl
{
    NSLog(@"UIPageControl");
    pageControl.numberOfPages = numberOfPages;
    pageControl.currentPage = currentPage;
    return pageControl;
}
-(void)getData
{
    NSLog(@"%@",string1);
    NSError *error = nil;
    NSData *jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:string1]];
    
    if (jsonData) {
        
        NSDictionary *jsonObjects = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        
        if (error) {
            NSLog(@"ERROR!!!NSJSONSerialization JSONObjectWithData:options:error is %@", [error localizedDescription]);
            
            // Handle Error and return
            return;
            
        }
        /*
         affiliate = "<null>";
         companyname = "";
         datecreated = "2012-12-12";
         email = "support@completehost.co.nz";
         firstname = completehost;
         id = 4;
         lastname = support;
         services = 0;
         
         "clients": [
         {
         "id": "8",
         "firstname": "Jack",
         "lastname": "Black",
         "datecreated": "2011-11-12",
         "email": "jackblack@domain.us",
         "companyname": "",
         "services": 2
         },
         "id": "8",
         "firstname": "Jack",
         "lastname": "Black",
         "email": "jackblack@domain.us",
         */
        NSLog(@"jsonObjects: %@",jsonObjects);
        if([[jsonObjects valueForKey:@"success"] isEqual:[NSNumber numberWithInteger:1]]){
            if((currentPage+2)>numberOfPages){
                numberOfPages=currentPage+2;
            }
            //currentPage++;
            [self pageControl];
            
            _objects = [[NSMutableArray alloc] init];
            _objects2 = [[NSMutableArray alloc] init];
            [tableView reloadData];
            _tempobject = [jsonObjects valueForKey:@"clients"];
            NSMutableDictionary  *dictionary;
            int count = [_tempobject count];
            for (int i=0; i < count; i++) {
                dictionary = [_tempobject objectAtIndex: i];
                //NSLog (@"Each>>%u>: %@ ",i, dictionary);
                [_objectsID insertObject:[dictionary valueForKey:@"id"] atIndex:0];
                NSString * title = [NSString stringWithFormat:@"%@: %@ %@",[dictionary valueForKey:@"id"], [dictionary valueForKey:@"firstname"], [dictionary valueForKey:@"lastname"]];
                [_objects insertObject:title atIndex:0];
                NSString * description = [NSString stringWithFormat:@"%@",[dictionary valueForKey:@"email"]];
                [_objects2 insertObject:description atIndex:0];
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            }
            [self.navigationItemC setPrompt:NULL];
            
        }else{
            [self.navigationItemC setPrompt:[NSString stringWithFormat:@"The requested page is not available"]];
            if(currentPage>0)currentPage--;

            [self pageControl];
        }
        NSLog(@"getData: numberOfPages: %u",numberOfPages);
        NSLog(@"getData: currentPage: %u",currentPage);
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
    //self.string = [NSString stringWithFormat:@"http://www.completehost.co.nz/admin/api.php?api_id=49e8d06c5caa534f4f71&api_key=5856d74cf710cc699dbd"];
    numberOfPages=2;
    currentPage=0;
    self.string1 = [NSString stringWithFormat:@"%@&call=getClients&page=%u", string, currentPage];
    NSLog(@"%@", string1);
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
    NSLog(@"viewDidAppear>: numberOfPages: %u",numberOfPages);
    NSLog(@"viewDidAppear>: currentPage: %u",currentPage);
    //currentPage++;
    self.string1 = [NSString stringWithFormat:@"%@&call=getClients&page=%u", string, currentPage];
    [self pageControl];
    [self getData];
    NSLog(@"viewDidAppear<: numberOfPages: %u",numberOfPages);
    NSLog(@"viewDidAppear<: currentPage: %u",currentPage);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Clients" forIndexPath:indexPath];
    
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
