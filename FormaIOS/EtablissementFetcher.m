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

- (void)downloadItems
{
    // Download the json file
    NSURL *jsonFileUrl = [NSURL URLWithString:@"http://195.154.104.118/getGroupe.php"];
    
    // Create the request
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:jsonFileUrl];
    
    // Create the NSURLConnection
    [NSURLConnection connectionWithRequest:urlRequest delegate:self];
}
#pragma mark NSURLConnectionDataProtocol Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // Initialize the data object
    _downloadedData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the newly downloaded data
    [_downloadedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSMutableArray *_etablissement = [[NSMutableArray alloc] init];
    // Parse the JSON that came in
    NSError *error;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:_downloadedData options:NSJSONReadingAllowFragments error:&error];
    
    // Loop through Json objects, create question objects and add them to our questions array
    for (int i = 0; i < jsonArray.count; i++)
    {
        NSDictionary *jsonElement = jsonArray[i];
        
        // Create a new location object and set its props to JsonElement properties
        Etablissement *newEtab = [[Etablissement alloc] init];
        newEtab.nom = jsonElement[@"name"];
        newEtab.identifier = jsonElement[@"id_etab"];
        
        // Add this question to the locations array
        [_etablissement addObject:newEtab];
    }
    
    // Ready to notify delegate that data is ready and pass back items
    if (self.delegate)
    {
       [self.delegate itemsDownloaded:_etablissement];
    }
}


+ (NSDictionary*)fetch {
    /*NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] ;
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"etbs.txt"] ;
    NSError *err ;
    NSString *etbsFile = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&err] ;
    NSLog(@"erreur : %@", err) ;
    NSLog(@"%@", etbsFile) ;
    
    NSMutableDictionary *listeEtbs = [[NSMutableDictionary alloc] init] ;
    Etablissement *etb = [[Etablissement alloc] init] ;
    
    int iDebut = 0 ;
    NSRange rg ;
    for (int i = 0 ; i < etbsFile.length; i++) {
        char c = [etbsFile characterAtIndex:i] ;
        rg.location = iDebut ;
        rg.length = i-iDebut ;
        if (c == ';') {
            etb.nom = [etbsFile substringWithRange:rg] ;
            iDebut = i+1 ;
        }else if (c == '\n') {
            etb.codePostal = [etbsFile substringWithRange:rg] ;
            [listeEtbs setObject:etb forKey:etb.nom] ;
            etb = [[Etablissement alloc] init] ;
            iDebut = i+1 ;
        }
    }
    
    NSLog(@"listeEtbs %@", listeEtbs) ;
    return [NSDictionary dictionaryWithDictionary:listeEtbs] ;*/
}

@end
