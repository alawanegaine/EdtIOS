//
//  Groupe.h
//  FormaIOS
//
//  Created by Jean-Baptiste Martin on 08/12/12.
//  Copyright (c) 2012 Jean-Baptiste Martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "TypeGroupe.h"

@interface Groupe : NSObject

@property (nonatomic, strong) NSString *nom ;
@property (nonatomic) enum TypeGroupe type ;
@property (nonatomic) int ID ;

@end
