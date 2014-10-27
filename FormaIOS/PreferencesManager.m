//
//  PreferencesManager.m
//  FormaIOS
//
//  Created by Jean-Baptiste Martin on 13/12/12.
//  Copyright (c) 2012 Jean-Baptiste Martin. All rights reserved.
//

#import "PreferencesManager.h"

@interface PreferencesManager ()
@property (nonatomic,readonly) NSString *filePath ;
@end

@implementation PreferencesManager

@synthesize etablissement = _etablissement ;
@synthesize departement = _departement ;
@synthesize groupe = _groupe ;
@synthesize classe = _classe ;
@synthesize idGroupe = _idGroupe ;

- (void)setEtablissement:(NSString *)etablissement {
    if (! [etablissement isEqualToString:_etablissement]) {
        _etablissement = etablissement ;
        self.departement = @"" ;
        self.groupe = @"" ;
        [self sendNotification] ;
    }
}

- (void)setDepartement:(NSString *)departement {
    if (! [departement isEqualToString:self.departement]) {
        _departement = departement ;
        self.groupe = @"" ;
        [self sendNotification] ;
    }
}

- (void)setGroupe:(NSString *)groupe {
    if (! [groupe isEqualToString:_groupe]) {
        _groupe = groupe ;
        [self sendNotification] ;
    }
}

- (void)setClasse:(NSString *)classe{
    if (! [classe isEqualToString:_classe]) {
        _classe = classe ;
        [self sendNotification] ;
    }
}

-(void) setIdGroupe:(NSString *)idGroupe{
    if (! [idGroupe isEqualToString:_idGroupe]) {
        _idGroupe = idGroupe ;
        [self sendNotification] ;
    }
}

- (BOOL)initOK {
    return !([self.etablissement isEqual:@""]
            || [self.departement isEqual:@""]
            || [self.groupe isEqual:@""]
            || [self.classe isEqual:@""]
            || [self.idGroupe isEqual:@""]
             ) ;
}

- (NSString*)filePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingString:@"/prefs.txt"] ;
}

- (void)sauvegarder {
    NSLog(@"-- Sauvegarde des préférences --") ;
    NSString *prefs = [NSString stringWithFormat:@"%@;%@;%@;%@;%@;",self.etablissement,self.departement,self.groupe,self.classe,self.idGroupe] ;
 
    NSError *err ;
    [prefs writeToFile:self.filePath atomically:YES encoding:NSUTF8StringEncoding error:&err] ;
    NSLog(@"erreur sauvegarde preference : %@", err) ;
}

- (id)init {
    self = [super init] ;
    
    NSLog(@"-- Initialisation des préférences --") ;
    NSError *err ;
    NSString *prefs = [NSString stringWithContentsOfFile:self.filePath encoding:NSUTF8StringEncoding error:&err] ;
    NSLog(@"erreur initialisation preferences : %@",err) ;
    
    if (!err) { // initialisation des préférences
        NSMutableArray *lignes = [[NSMutableArray alloc] init] ;
        int iDebut = 0 ;
        NSRange rg ;
        for (int i = 0; i < prefs.length; i++) {
            char c = [prefs characterAtIndex:i] ;
            rg.location = iDebut ;
            rg.length = i-iDebut ;
            if (c == ';') {
                [lignes addObject:[prefs substringWithRange:rg]] ;
                iDebut = i+1 ;
            }
        }
        self.etablissement = [lignes objectAtIndex:0] ;
        self.departement = [lignes objectAtIndex:1] ;
        self.groupe = [lignes objectAtIndex:2] ;
        self.classe = [lignes objectAtIndex:3];
        self.idGroupe = [lignes objectAtIndex:4];
    }else {
        self.etablissement = @"" ;
        self.departement = @"" ;
        self.groupe = @"" ;
        self.classe = @"" ;
        self.idGroupe = @"" ;
    }
    
    return self ;
}

- (void)sendNotification {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"prefsChanged" object:self] ;
    NSLog(@"-- send prefsChanged Notification") ;
    NSLog(@"%@",self) ;
}

- (NSString*)description {
    return [NSString stringWithFormat:@"PreferenceManager\nEtablissement : %@\nDepartement : %@\nGroupe : %@\nClasse : %@\nidGroupe : %@",self.etablissement, self.departement, self.groupe, self.classe,self.idGroupe] ;
}
@end
