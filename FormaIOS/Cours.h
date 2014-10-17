//
//  Cours.h
//  FormaIOS
//
//  Created by Jean-Baptiste Martin on 08/12/12.
//  Copyright (c) 2012 Jean-Baptiste Martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "Annee.h"
#import "Groupe.h"
#import "Jour.h"

@interface Cours : NSObject

@property (nonatomic, strong) NSString *nom ;
@property (nonatomic, strong) NSString *professeur ;
@property (nonatomic, strong) NSDate *date ;
@property (nonatomic, strong) NSString *heureDebut ;
@property (nonatomic, strong) NSString *heureFin ;
@property (nonatomic, strong) NSString *grpTP ;

- (NSDate*)dateHeureFin ;

@end
