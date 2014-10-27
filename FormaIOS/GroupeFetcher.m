//
//  GroupeFetcher.m
//  FormaIOS
//
//  Created by Jean-Baptiste Martin on 12/12/12.
//  Copyright (c) 2012 Jean-Baptiste Martin. All rights reserved.
//

#import "GroupeFetcher.h"
#import "Groupe.h"

@implementation GroupeFetcher

+ (NSArray*)fetch {
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://195.154.104.118/getGroupe.php"]];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    // Check errors
    if (!data) {
        NSLog(@"Error : %@", error);
    } else if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
        
        NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
        if (statusCode != 200) {
            NSLog(@"Error status code != 200: response = %@", response);
        }
    }
    
    NSError *parseError = nil;
    NSArray *groups = [[NSArray alloc] init];
    groups = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError]; // monArray étant un NSArray contenant une liste de NSDictionnary
    if (!groups) {
        NSLog(@"Error while parsing (malformed) JSON : %@ ", parseError);
    }
    return groups ;
}


@end
