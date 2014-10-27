//
//  FormaIOSViewController.m
//  FormaIOS
//
//  Created by Jean-Baptiste Martin on 08/12/12.
//  Copyright (c) 2012 Jean-Baptiste Martin. All rights reserved.
//

#import "CoursViewController.h"
#import "CellView.h"
#import "FormaIOSAppDelegate.h"
#import "ConfigViewController.h"
#import "Cours.h"
#import "CoursFetcher.h"

@interface CoursViewController () <UITableViewDelegate, UITableViewDataSource, ADBannerViewDelegate>

@property (nonatomic, readonly) FormaIOSAppDelegate *appDelegate ;
@property (nonatomic, strong) NSArray *jours ;
@property (nonatomic, strong) UIRefreshControl *refreshControl ;
@property (nonatomic) NSDateComponents *dateComponent;
@property (nonatomic, strong) NSArray *tempCours ;

@end

@implementation CoursViewController
@synthesize cours ;
@synthesize jours ;

- (FormaIOSAppDelegate*)appDelegate {
    return [[UIApplication sharedApplication] delegate] ;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.tableView.delegate = self ;
    self.tableView.dataSource = self ;
    
    // Create left swipe gesture
    UISwipeGestureRecognizer *gestureRecognizerLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandler:)];
    [gestureRecognizerLeft setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.view addGestureRecognizer:gestureRecognizerLeft];
    
    // Create right swipe gesture
    UISwipeGestureRecognizer *gestureRecognizerRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandler:)];
    [gestureRecognizerRight setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.view addGestureRecognizer:gestureRecognizerRight];
    
    self.refreshControl = [[UIRefreshControl alloc] init] ;
    [self.refreshControl addTarget:self action:@selector(MAJ) forControlEvents:UIControlEventValueChanged] ;
    [self.tableView addSubview:self.refreshControl] ;
    self.roue.hidesWhenStopped = YES ;
    if (!self.appDelegate.prefsManager.initOK) {
        [self performSegueWithIdentifier:@"configuration" sender:self] ;
    }
    
    //definition pull to refresh
    self.refreshControl.backgroundColor = [UIColor colorWithRed:0.18f green:0.40f blue:0.60f alpha:1.00f];;
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self action:@selector(refreshCours) forControlEvents:UIControlEventValueChanged];
    
    // all cours
    self.cours = [[NSMutableArray alloc] init] ;
    self.tempCours  = [CoursFetcher fetch] ;
    self.currentDate = [NSDate date];
    // get cours for the day of the groups or classe
    [self fillCours:self.tempCours];
    //NSLog(@"dico %@",self.cours);
    
    
    _dateComponent = [[NSDateComponents alloc] init];
    self.appDelegate.prefsManager.calendar = [NSCalendar currentCalendar];
    _dateComponent.day = 0 ;
}

- (void)viewDidAppear:(BOOL)animated {
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)swipeHandler:(UISwipeGestureRecognizer *)recognizer {
  
    if(recognizer.direction == UISwipeGestureRecognizerDirectionLeft)
    {
        _dateComponent.day += 1 ;
        self.currentDate = [self.appDelegate.prefsManager.calendar dateByAddingComponents:_dateComponent toDate:[NSDate date] options:0];
        [self fillCours:_tempCours];
        [_tableView reloadData];
        
    }
    else
    {
        if([[NSDate date] compare:self.currentDate] == NSOrderedAscending){
            _dateComponent.day -= 1 ;
            self.currentDate = [self.appDelegate.prefsManager.calendar dateByAddingComponents:_dateComponent toDate:[NSDate date] options:0];
            [self fillCours:_tempCours];
            [_tableView reloadData];
        }
    }
}

// when pull to refresh event
-(void) refreshCours{
    [self.tableView reloadData] ;
    
    if(self.refreshControl){        
        NSAttributedString *attributeString = [[NSAttributedString alloc] initWithString:@"Refreshing.." attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        self.refreshControl.attributedTitle = attributeString ;
        
        _tempCours = [CoursFetcher fetch];
        [self fillCours:_tempCours];
        
        [self.refreshControl endRefreshing];
    }
}

#pragma mark - Data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.cours count];
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd/MM/yyyy"];

    return [df stringFromDate:self.currentDate] ;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CellView *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[CellView alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell" ];
    }

    NSDictionary *cour = [self.cours objectAtIndex:indexPath.row];

    cell.labelNom.textColor = [UIColor colorWithRed:0.18f green:0.40f blue:0.60f alpha:1.00f];
    cell.labelHeureDebut.textColor = [UIColor darkTextColor] ;
    cell.labelHeureFin.textColor = [UIColor darkTextColor] ;
    cell.labelGroupe.textColor = [UIColor darkTextColor] ;
    cell.labelTiret.textColor = [UIColor darkTextColor] ;
    
    cell.labelNom.text = [cour objectForKey:@"name" ] ;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *datedebut  = [dateFormatter dateFromString:[cour objectForKey:@"datedebut"]];
    
    // Convert to new Date Format
    [dateFormatter setDateFormat:@"HH:mm"];
    cell.labelHeureDebut.text = [dateFormatter stringFromDate:datedebut] ;
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *datefin = [dateFormatter dateFromString:[cour objectForKey:@"datefin"]];
    [dateFormatter setDateFormat:@"HH:mm"];
    
    cell.labelHeureFin.text = [dateFormatter stringFromDate:datefin] ;
    cell.labelGroupe.text = self.appDelegate.prefsManager.groupe ;
    cell.labelSalle.text = [cour objectForKey:@"salle"];
    cell.labelProf.text = [cour objectForKey:@"prof"];
    
    return cell ;
}

#pragma mark - Bannière pub

-(void) fillCours:(NSArray *)withArray
{
    NSString *tempIdGroupe ;
    NSDictionary *tempDico ;
    NSInteger * i  = 0 ;
    [self.cours removeAllObjects];
    for(tempDico in withArray)
    {
        tempIdGroupe = [tempDico objectForKey:@"id_groupe"];
        if(tempIdGroupe != nil)
        {
            // NSLog(@"Current groupe: %@  classe : %@ INDEX : %@", self.appDelegate.prefsManager.groupe, self.appDelegate.prefsManager.classe, tempIdGroupe);
            //NSLog(@"classe : %@ Groupe : %@", self.appDelegate.prefsManager.classe, self.appDelegate.prefsManager.idGroupe);
            
            // if idClasse or idGroupe are matched
            if([tempIdGroupe isEqualToString:self.appDelegate.prefsManager.classe] || [tempIdGroupe isEqualToString:self.appDelegate.prefsManager.idGroupe] )
            {
                // parsing pour le cours pointé
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                NSDate *datecours  = [dateFormatter dateFromString:[tempDico objectForKey:@"datedebut"]];
                // Convert to new Date Format
                [dateFormatter setDateFormat:@"dd/MM/yyyy"];
                
                //NSLog(@"Date : %@ string : %@",[dateFormatter stringFromDate:datecours],[dateFormatter stringFromDate:self.currentDate]);
                if([[dateFormatter stringFromDate:datecours] isEqualToString:[dateFormatter stringFromDate:self.currentDate]]){
                    [self.cours addObject:tempDico];
                    NSSortDescriptor *ageSorter = [[NSSortDescriptor alloc] initWithKey:@"datedebut" ascending:YES];
                    [self.cours sortUsingDescriptors:[NSArray arrayWithObject:ageSorter]];
                }
            }
        }
        i++ ;
    }
}


@end
