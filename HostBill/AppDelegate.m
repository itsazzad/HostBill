//
//  AppDelegate.m
//  HostBill
//
//  Created by Sazzad Tushar Khan on 11/24/12.
//  Copyright (c) 2012 BaliaTech. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize URL;
@synthesize url_to_your_hostbill;
@synthesize API_ID;
@synthesize API_KEY;
@synthesize spinner;
@synthesize stringCurrencies;
@synthesize currenciesJSONObject;
@synthesize server_time_year;
@synthesize server_time_month;
@synthesize server_time_day;
@synthesize server_time_hour;
@synthesize server_time_minute;
@synthesize server_time_second;
@synthesize server_time_zone;
-(void)getServerTime:(int)server_time
{
    //NSDate *date = [NSDate dateWithTimeIntervalSince1970:1358173483];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:server_time];
    //NSLog(@"dateWithTimeIntervalSince1970: %@",date);
    server_time_year    = [self convertDateTime:[NSString stringWithFormat:@"%@", date] fromFormat:@"yyyy-MM-dd HH:mm:ss Z" toFormat:@"yyyy"];
    server_time_month   = [self convertDateTime:[NSString stringWithFormat:@"%@", date] fromFormat:@"yyyy-MM-dd HH:mm:ss Z" toFormat:@"MM"];
    server_time_day     = [self convertDateTime:[NSString stringWithFormat:@"%@", date] fromFormat:@"yyyy-MM-dd HH:mm:ss Z" toFormat:@"dd"];
    server_time_hour    = [self convertDateTime:[NSString stringWithFormat:@"%@", date] fromFormat:@"yyyy-MM-dd HH:mm:ss Z" toFormat:@"HH"];
    server_time_minute  = [self convertDateTime:[NSString stringWithFormat:@"%@", date] fromFormat:@"yyyy-MM-dd HH:mm:ss Z" toFormat:@"mm"];
    server_time_second  = [self convertDateTime:[NSString stringWithFormat:@"%@", date] fromFormat:@"yyyy-MM-dd HH:mm:ss Z" toFormat:@"ss"];
    server_time_zone    = [self convertDateTime:[NSString stringWithFormat:@"%@", date] fromFormat:@"yyyy-MM-dd HH:mm:ss Z" toFormat:@"Z"];
}

-(NSString *)convertDateTime:(NSString *)datetimeString fromFormat:(NSString *)fromFormat toFormat:(NSString *)toFormat
{
    
    //NSLog(@"currentDateString: %@", datetimeString);
    
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    
    [dateFormater setDateFormat:fromFormat];
    NSDate *currentDate = [dateFormater dateFromString:datetimeString];
    //NSLog(@"currentDate: %@", currentDate);
    
    [dateFormater setDateFormat:toFormat];
    NSString *convertedDateString = [dateFormater stringFromDate:currentDate];
    //NSLog(@"convertedDateString: %@", convertedDateString);
    
    return convertedDateString;
}

-(void)getCurrencies
{
    NSLog(@"getCurrencies");
    NSError *error = nil;
    self.stringCurrencies = [NSString stringWithFormat:@"%@&call=getCurrencies", URL];
    
    NSData *jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:stringCurrencies]];
    currenciesJSONObject = [[NSDictionary alloc] init];
    //NSLog(@"currenciesJSONObject: %@", currenciesJSONObject);
    if (jsonData) {
        
        currenciesJSONObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        //NSLog(@"currenciesJSONObject: %@", currenciesJSONObject);
        if (error) {
            NSLog(@"ERROR!!!NSJSONSerialization JSONObjectWithData:options:error is %@", [error localizedDescription]);
            
            // Handle Error and return
            return;
            
        }
    } else {
        // Handle Error
        NSLog(@"ERROR!!! NSData dataWithContentsOfURL:URLWithString");
        return;
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"AppDelegate.h- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions");
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self handleRegisterDefaultsFromSettingsBundle];
    [self getCurrencies];
    
    
    // Override point for customization after application launch.
    return YES;
}
- (void)registerDefaultsFromSettingsBundle {
    NSString *settingsBundle = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"bundle"];
    if(!settingsBundle) {
        NSLog(@"Could not find Settings.bundle");
        return;
    }
    
    NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile:[settingsBundle stringByAppendingPathComponent:@"Root.plist"]];
    NSArray *preferences = [settings objectForKey:@"PreferenceSpecifiers"];
    
    NSMutableDictionary *defaultsToRegister = [[NSMutableDictionary alloc] initWithCapacity:[preferences count]];
    for(NSDictionary *prefSpecification in preferences) {
        NSString *key = [prefSpecification objectForKey:@"Key"];
        if(key) {
            [defaultsToRegister setObject:[prefSpecification objectForKey:@"DefaultValue"] forKey:key];
        }
    }
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultsToRegister];
}
- (void)handleRegisterDefaultsFromSettingsBundle {
    url_to_your_hostbill = [[NSUserDefaults standardUserDefaults] stringForKey:@"url_to_your_hostbill"];
    API_ID = [[NSUserDefaults standardUserDefaults] stringForKey:@"API_ID"];
    API_KEY = [[NSUserDefaults standardUserDefaults] stringForKey:@"API_KEY"];
    //NSLog(@"name before is %@", name);
    // Note: this will not work for boolean values as noted by bpapa below.
    // If you use booleans, you should use objectForKey above and check for null
    if(!url_to_your_hostbill || !API_ID || !API_KEY) {
        [self registerDefaultsFromSettingsBundle];
    }
    if(!url_to_your_hostbill) {
        url_to_your_hostbill = [[NSUserDefaults standardUserDefaults] stringForKey:@"url_to_your_hostbill"];
    }
    if(!API_ID) {
        API_ID = [[NSUserDefaults standardUserDefaults] stringForKey:@"API_ID"];
    }
    if(!API_KEY) {
        API_KEY = [[NSUserDefaults standardUserDefaults] stringForKey:@"API_KEY"];
    }
    //NSLog(@"name after is %@", name);
    URL = [NSString stringWithFormat:@"%@/admin/api.php?api_id=%@&api_key=%@",url_to_your_hostbill, API_ID, API_KEY];
    NSLog(@"%@",URL);
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    NSLog(@"AppDelegate.h- (void)applicationWillResignActive:(UIApplication *)application");
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    NSLog(@"AppDelegate.h- (void)applicationDidEnterBackground:(UIApplication *)application");
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    NSLog(@"AppDelegate.h- (void)applicationWillEnterForeground:(UIApplication *)application");
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    [self handleRegisterDefaultsFromSettingsBundle];
    [self getCurrencies];
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    NSLog(@"AppDelegate.h- (void)applicationDidBecomeActive:(UIApplication *)application");
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    NSLog(@"AppDelegate.h- (void)applicationWillTerminate:(UIApplication *)application");
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
