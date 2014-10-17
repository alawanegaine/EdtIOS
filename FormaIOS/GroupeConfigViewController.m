//
//  GroupeConfigViewController.m
//  FormaIOS
//
//  Created by Jean-Baptiste Martin on 14/12/12.
//  Copyright (c) 2012 Jean-Baptiste Martin. All rights reserved.
//

#import "GroupeConfigViewController.h"
#import "FormaIOSAppDelegate.h"

@interface GroupeConfigViewController ()

@property (nonatomic, strong) FormaIOSAppDelegate *appDelegate ;
@property (nonatomic, weak) UITableViewCell *selectedCell ;
@property int nbCellules ;

@end

@implementation GroupeConfigViewController

@synthesize selectedCell ;
@synthesize nbCellules ; 

- (FormaIOSAppDelegate*)appDelegate {
    return [[UIApplication sharedApplication] delegate] ;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.roue.hidesWhenStopped = YES ;
    
   /* if (self.appDelegate.prefsManager.groupe == @"") {
        self.nbCellules = 0 ;
        if (self.appDelegate.networkStatus == NotReachable) {
            [self.appDelegate afficherErreurConnexion] ;
        }else {
            NSLog(@"-- Groupe vue rechargement des données ") ;
            dispatch_queue_t queue = dispatch_queue_create("téléchargement groupes", NULL) ;
            [self.roue startAnimating] ;
            dispatch_async(queue, ^{
                //[self.appDelegate.dataManager MAJ_groupes] ;
                //self.nbCellules = self.appDelegate.dataManager.getGroupes.count ;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData] ;
                    [self.roue stopAnimating] ;
                }) ;
            }) ;
        }
    }else {
        //self.nbCellules = self.appDelegate.dataManager.getGroupes.count ;
    }*/
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://195.154.104.118/getGroupe.php"]];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    // Check errors
    if (!data) {
        NSLog(@"Error : %@", error);
        return;
    } else if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
        
        NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
        if (statusCode != 200) {
            NSLog(@"Error status code != 200: response = %@", response);
            return;
        }
    }
    
    NSError *parseError = nil;
    NSArray *tempGroups= [[NSArray alloc] init];
    tempGroups = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError]; // monArray étant un NSArray contenant une liste de NSDictionnary
    if (!tempGroups) {
        NSLog(@"Error while parsing (malformed) JSON : %@ ", parseError);
        return;
    }
    
    self.groups = [[NSMutableArray alloc] init] ;
    
    NSString *tempName ;
    NSDictionary *tempDico ;
    NSInteger * i  = 0 ;
    for(tempDico in tempGroups)
    {
        tempName = [tempDico objectForKey:@"name"];
    
        if(tempName != nil)
        {
            if([tempName isEqualToString:self.appDelegate.prefsManager.departement])
            {
                self.appDelegate.prefsManager.classe = [tempDico objectForKey:@"id_groupe"];
            }
            else if ([tempName rangeOfString:self.appDelegate.prefsManager.departement].location != NSNotFound)
            {
                [self.groups addObject:tempDico];
            }
        }
        i++ ;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.groups.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cellGroupe";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier] ;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellAccessoryCheckmark reuseIdentifier:CellIdentifier] ;
    }
    
    self.dictionary = [self.groups objectAtIndex:indexPath.row]; // on va chercher le dictionnaire au bon index
    if ([[self.dictionary objectForKey:@"name"] isKindOfClass:[NSNull class]]) {
        cell.textLabel.text = @" " ;
    }
    else{
        cell.textLabel.text = [ self.dictionary objectForKey:@"name"];
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath] ;
    cell.selected = NO ;
    if (cell != self.selectedCell) {
        self.selectedCell.accessoryType = UITableViewCellAccessoryNone ;
        cell.accessoryType = UITableViewCellAccessoryCheckmark ;
        self.selectedCell = cell ;
        cell.selected = NO ;
        self.appDelegate.prefsManager.idGroupe = [[self.groups objectAtIndex:indexPath.row] objectForKey:@"id_groupe"] ;
        self.appDelegate.prefsManager.groupe = [[self.groups objectAtIndex:indexPath.row] objectForKey:@"name"] ;
        [self.appDelegate.prefsManager sauvegarder] ;
        [self.navigationItem.rightBarButtonItem setTintColor:[UIColor blueColor]];
        [self.navigationItem.rightBarButtonItem setEnabled:true];
    }
}

@end
