//
//  GroupeConfigViewController.h
//  FormaIOS
//
//  Created by Jean-Baptiste Martin on 14/12/12.
//  Copyright (c) 2012 Jean-Baptiste Martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupeConfigViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *roue;
@property NSMutableArray *groups ;
@property NSDictionary *dictionary ;


@end
