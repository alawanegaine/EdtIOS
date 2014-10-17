//
//  ConfigViewController.h
//  FormaIOS
//
//  Created by Jean-Baptiste Martin on 13/12/12.
//  Copyright (c) 2012 Jean-Baptiste Martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ConfigViewController;
@protocol ConfigViewControllerDelegate <NSObject>

-(void)chooseGroupeByDepartement:(ConfigViewController *)controller didFinishEnteringItem:(NSString*)item ;

@end

@interface ConfigViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,weak) id <ConfigViewControllerDelegate> delegate; 

@end
