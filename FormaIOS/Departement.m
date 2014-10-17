//
//  Departement.m
//  FormaIOS
//
//  Created by Jean-Baptiste Martin on 13/12/12.
//  Copyright (c) 2012 Jean-Baptiste Martin. All rights reserved.
//

#import "Departement.h"

@implementation Departement

-(void) addDeps:(NSString *)nom
{
    self.nom = nom ;
    [self.deps addObject:nom];
}

-(NSMutableArray *) getDeps
{
    return self.deps ;
}


@end
