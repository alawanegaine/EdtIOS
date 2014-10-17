//
//  CellView.h
//  FormaIOS
//
//  Created by Jean-Baptiste Martin on 13/12/12.
//  Copyright (c) 2012 Jean-Baptiste Martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellView : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *labelNom ;
@property (nonatomic, weak) IBOutlet UILabel *labelHeureDebut ;
@property (nonatomic, weak) IBOutlet UILabel *labelHeureFin ;
@property (nonatomic, weak) IBOutlet UILabel *labelGroupe ;
@property (nonatomic, weak) IBOutlet UILabel *labelTiret ;
@property (weak, nonatomic) IBOutlet UILabel *labelSalle;
@property (weak, nonatomic) IBOutlet UILabel *labelProf;
@end
