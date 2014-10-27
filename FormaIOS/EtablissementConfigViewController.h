//
//  EtablissementConfigViewController.h
//  FormaIOS
//
//  Created by Jean-Baptiste Martin on 13/12/12.
//  Copyright (c) 2012 Jean-Baptiste Martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EtablissementConfigViewController : UITableViewController


@property (strong, nonatomic) IBOutlet UITableView *roue;
@property NSArray *etabs ;
@property NSDictionary *dictionary ;



@end