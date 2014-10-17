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

+ (NSDictionary*)fetch {
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] ;
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"groupes.txt"] ;
    
    
    NSError *err ;
    NSString *grpsFile = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&err] ;
    NSLog(@"Erreur : %@",err) ;
    NSLog(@"Contenu fichier groupes stocké : %@", grpsFile) ;
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init] ;
    Groupe *grp = [[Groupe alloc] init] ;
    int iDebut = 0 ;
    NSRange rg ;
    for (int i = 0; i < grpsFile.length; i++) {
        char c = [grpsFile characterAtIndex:i] ;
        rg.location = iDebut ;
        rg.length = i-iDebut ;
        
        if (c == ';') {
            grp.nom = [grpsFile substringWithRange:rg] ;
            iDebut = i+1 ;
        }else if (c == '\n') {
            grp.ID = [[grpsFile substringWithRange:rg] integerValue] ;
            iDebut = i+1 ;
            [dict setObject:grp forKey:grp.nom] ;
            grp = [[Groupe alloc] init] ;
        }
    }
    NSLog(@"contenu dictionnaire groups : %@",dict) ;
    return [NSDictionary dictionaryWithDictionary:dict] ;
}


@end
