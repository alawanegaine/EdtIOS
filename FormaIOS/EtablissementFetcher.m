//
//  EtablissementFetcher.m
//  FormaIOS
//
//  Created by Jean-Baptiste Martin on 12/12/12.
//  Copyright (c) 2012 Jean-Baptiste Martin. All rights reserved.
//

#import "EtablissementFetcher.h"
#import "Etablissement.h"

@interface EtablissementFetcher()
{
    NSMutableData *_downloadedData;
}
@end

@implementation EtablissementFetcher


+ (NSArray*)fetch {
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://195.154.104.118/getEtab.php"]];
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
    NSArray *etabs = [[NSArray alloc] init];
    etabs = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError]; // monArray étant un NSArray contenant une liste de NSDictionnary
    if (!etabs) {
        NSLog(@"Error while parsing (malformed) JSON : %@ ", parseError);
    }
    //NSLog(@" index : %d", [self.navigationController.viewControllers indexOfObject:self]);
    
    return etabs ;
}

@end
