//
//  ConfigViewController.m
//  FormaIOS
//
//  Created by Jean-Baptiste Martin on 13/12/12.
//  Copyright (c) 2012 Jean-Baptiste Martin. All rights reserved.
//

#import "ConfigViewController.h"
#import "FormaIOSAppDelegate.h"

@interface ConfigViewController ()
@property (nonatomic, readonly) FormaIOSAppDelegate *appDelegate ;

@end

@implementation ConfigViewController

- (FormaIOSAppDelegate*)appDelegate {
    return [[UIApplication sharedApplication] delegate] ;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.tableView.delegate = self ;
    self.tableView.dataSource = self ;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(config_changed) name:@"prefsChanged" object:nil] ;
}

- (void)viewDidAppear:(BOOL)animated {
    if (!self.appDelegate.prefsManager.initOK) {
        self.navigationItem.hidesBackButton = YES ;
    }else {
        self.navigationItem.hidesBackButton = NO ;
    }
    [super viewDidAppear:animated] ;
    [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:YES] ;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Gestion TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3 ;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *mainText ;
    NSString *detailText ;
    NSString *cellID ;
    
    
    switch (indexPath.row) {
        case 0:
            mainText = @"Etablissement" ;
            detailText = self.appDelegate.prefsManager.etablissement;
            cellID = @"cellConfigEtablissement" ;
            break;
        case 1:
            mainText = @"Département" ;
            detailText = self.appDelegate.prefsManager.departement ;
            cellID = @"cellConfigDepartement" ;
            break ;
        default:
            mainText = @"Groupe" ;
            detailText = self.appDelegate.prefsManager.groupe ;
            cellID = @"cellConfigGroupe" ;
            break ;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID] ;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID] ;
    }
    cell.textLabel.text = mainText ;
    cell.detailTextLabel.text = detailText ;
    [cell setHidden:YES] ;
    
    if ([cellID isEqualToString:@"cellConfigEtablissement"]) {
        [cell setHidden:NO] ;
    }else if (([cellID isEqualToString:@"cellConfigDepartement"]) && ![self.appDelegate.prefsManager.etablissement isEqualToString:@""]) {
        [cell setHidden:NO] ;
    }else if ([cellID isEqualToString:@"cellConfigGroupe"] && ![self.appDelegate.prefsManager.departement isEqualToString:@""]) {
        [cell setHidden:NO] ;
    }

    return cell ;
}

- (void)config_changed {
    [self.tableView reloadData] ;
}
@end
