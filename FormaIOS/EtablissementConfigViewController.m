//
//  EtablissementConfigViewController.m
//  FormaIOS
//
//  Created by Jean-Baptiste Martin on 13/12/12.
//  Copyright (c) 2012 Jean-Baptiste Martin. All rights reserved.
//
//

#import "EtablissementConfigViewController.h"
#import "Etablissement.h"
#import "EtablissementFetcher.h"
#import "FormaIOSAppDelegate.h"
#import "ConfigViewController.h"

@interface EtablissementConfigViewController()
{
    EtablissementFetcher *_etabModel;
    NSArray *_feedItems;
}
@property (nonatomic, readonly) FormaIOSAppDelegate *appDelegate ;
@property (nonatomic, weak) UITableViewCell *selectedCell ;

@end

@implementation EtablissementConfigViewController

- (FormaIOSAppDelegate*)appDelegate {
    return [[UIApplication sharedApplication] delegate] ;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://195.154.104.118/getEtab.php"]];
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
    etabs = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError]; // monArray étant un NSArray contenant une liste de NSDictionnary
    if (!etabs) {
        NSLog(@"Error while parsing (malformed) JSON : %@ ", parseError);
        return;
    }
    //NSLog(@" index : %d", [self.navigationController.viewControllers indexOfObject:self]);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //NSLog(@"sender : %@",[segue identifier]);
    if([segue.identifier isEqualToString:@"onDoneClick_event"])
    {

    }
}


#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return etabs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellEtablissement";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    dictionary = [etabs objectAtIndex:indexPath.row]; // on va chercher le dictionnaire au bon index
    if ([[dictionary objectForKey:@"name"] isKindOfClass:[NSNull class]]) {
        cell.textLabel.text = @" " ;
    }
    else{
         cell.textLabel.text = [ dictionary objectForKey:@"name"];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath] ;
    cell.selected = NO ;
    if (cell != self.selectedCell) {
        self.selectedCell.accessoryType = UITableViewCellAccessoryNone ;
        cell.accessoryType = UITableViewCellAccessoryCheckmark ;
        self.selectedCell = cell ;
        cell.selected = NO ;
        self.appDelegate.prefsManager.etablissement = cell.textLabel.text ;
        [self.appDelegate.prefsManager sauvegarder] ;
        [self.navigationItem.rightBarButtonItem setTintColor:[UIColor blueColor]];
        [self.navigationItem.rightBarButtonItem setEnabled:true];
    }
}

@end
