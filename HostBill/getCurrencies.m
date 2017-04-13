//
//  getCurrencies.m
//  HostBill
//
//  Created by Sazzad Tushar Khan on 1/7/13.
//  Copyright (c) 2013 AppBoxNZ Limited. All rights reserved.
//

#import "getCurrencies.h"

@implementation getCurrencies
@synthesize string;//http://url_to_your_hostbill.com/admin/api.php?api_id=API_ID&api_key=API_KEY&call=FUNCTION
@synthesize string2;




-(NSDictionary *)getCurrencies
{
    NSLog(@"getCurrencies");
    NSError *error = nil;
    self.string2 = [NSString stringWithFormat:@"%@&call=getCurrencies", string];

    NSData *jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:string2]];
    NSDictionary *jsonObjects = [[NSDictionary alloc] init];
    if (jsonData) {
        
        jsonObjects = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        
        if (error) {
            NSLog(@"ERROR!!!NSJSONSerialization JSONObjectWithData:options:error is %@", [error localizedDescription]);
            
            // Handle Error and return
            return jsonObjects;
            
        }
        return jsonObjects;

    } else {
        // Handle Error
        NSLog(@"ERROR!!! NSData dataWithContentsOfURL:URLWithString");
        return jsonObjects;
    }
}

@end
