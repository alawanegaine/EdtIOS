//
//  DepartementFetcher.m
//  FormaIOS
//
//  Created by Jean-Baptiste Martin on 13/12/12.
//  Copyright (c) 2012 Jean-Baptiste Martin. All rights reserved.
//

#import "DepartementFetcher.h"
#import "Departement.h"

@implementation DepartementFetcher

+ (NSDictionary*)fetch  {
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] ;
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"depts.txt"] ;

    
    NSError *err ;
    NSString *deptsFile = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&err] ;
    NSLog(@"Erreur : %@",err) ;
    NSLog(@"Contenu fichier dept stocké : %@", deptsFile) ;
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init] ;
    NSMutableString *content = [[NSMutableString alloc] init] ;
    Departement *dept = [[Departement alloc] init] ;
    
    int iDebut = 0 ;
    NSRange rg ;
    for (int i = 0; i < deptsFile.length; i++) {
        char c = [deptsFile characterAtIndex:i] ;
        rg.location = iDebut ;
        rg.length = i-iDebut ;
        
        if (c == ';') {
            dept.nom = [deptsFile substringWithRange:rg] ;
            iDebut = i+1 ;
        }else if (c == '\n') {
            dept.ID = [deptsFile substringWithRange:rg] ;
            iDebut = i+1 ;
            [dict setObject:dept forKey:dept.nom] ;
            dept = [[Departement alloc] init] ;
        }else {
            [content appendFormat:@"%c", c] ;
        }
    }
    NSLog(@"contenu dictionnaire départements : %@",dict) ;
    return [NSDictionary dictionaryWithDictionary:dict] ;
}

@end
