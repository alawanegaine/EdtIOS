//
//  Departement.h
//  FormaIOS
//
//  Created by Jean-Baptiste Martin on 13/12/12.
//  Copyright (c) 2012 Jean-Baptiste Martin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Departement : NSObject

@property (nonatomic, strong) NSString *nom ;
@property (nonatomic, strong) NSString *ID ;
@property NSMutableArray *deps ;

-(void) addDeps:(NSString *)nom ;
-(NSMutableArray *) getDeps ;

@end
