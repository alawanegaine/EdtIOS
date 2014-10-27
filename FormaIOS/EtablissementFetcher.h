//
//  EtablissementFetcher.h
//  FormaIOS
//
//  Created by Jean-Baptiste Martin on 12/12/12.
//  Copyright (c) 2012 Jean-Baptiste Martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Etablissement.h"

@protocol EtablissementFetcherProtocol <NSObject>

- (void)itemsDownloaded:(NSArray *)items;

@end

@interface EtablissementFetcher : NSObject <NSURLConnectionDataDelegate>

@property (nonatomic, weak) id<EtablissementFetcherProtocol> delegate;

+ (NSArray *)fetch ;

@end