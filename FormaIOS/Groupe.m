//
//  Groupe.m
//  FormaIOS
//
//  Created by Jean-Baptiste Martin on 08/12/12.
//  Copyright (c) 2012 Jean-Baptiste Martin. All rights reserved.
//

#import "Groupe.h"

@implementation Groupe

@synthesize nom = _nom ;
@synthesize type = _type ;
@synthesize ID = _ID ;


- (NSString *)description {
    return [[NSString alloc] initWithFormat:@"Groupe : %@ | id : %d", self.nom, self.ID] ;
}
@end
