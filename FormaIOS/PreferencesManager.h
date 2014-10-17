//
//  PreferencesManager.h
//  FormaIOS
//
//  Created by Jean-Baptiste Martin on 13/12/12.
//  Copyright (c) 2012 Jean-Baptiste Martin. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PreferencesManager : NSObject

@property (nonatomic, strong) NSString *etablissement ;
@property (nonatomic, strong) NSString *departement ;
@property (nonatomic, strong) NSString *classe ;
@property (nonatomic, strong) NSString *idGroupe ;
@property (nonatomic, strong) NSString *groupe ;
@property (nonatomic, strong) NSCalendar *calendar ;
@property  NSInteger itDay ;
@property (nonatomic, readonly) BOOL initOK ;

- (void)sauvegarder ;

- (id)init ;
@end
