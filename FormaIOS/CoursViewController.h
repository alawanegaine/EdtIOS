//
//  FormaIOSViewController.h
//  FormaIOS
//
//  Created by Jean-Baptiste Martin on 08/12/12.
//  Copyright (c) 2012 Jean-Baptiste Martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface CoursViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *roue;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *cours ;
@property NSCalendar *calendar ;
@property NSDate *currentDate ;

-(void) fillCours:(NSArray*)withArray;
@end
