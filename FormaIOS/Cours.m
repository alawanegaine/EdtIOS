//
//  Cours.m
//  FormaIOS
//
//  Created by Jean-Baptiste Martin on 08/12/12.
//  Copyright (c) 2012 Jean-Baptiste Martin. All rights reserved.
//

#import "Cours.h"

@implementation Cours

@synthesize nom;
@synthesize professeur ;
@synthesize date ;
@synthesize heureDebut ;
@synthesize heureFin ;
@synthesize grpTP ;


- (NSString*)description {
    NSDateFormatter *df = [[NSDateFormatter alloc] init] ;
    df.dateFormat = @"EEEE dd MMMM yyyy" ;
    return [NSString stringWithFormat:@"Nom : %@ | date : %@ | HeureDebut : %@ | HeureFin : %@ | groupeTP : %@ | Prof : %@", self.nom, [df stringFromDate:self.date],self.heureDebut, self.heureFin, self.grpTP, self.professeur] ;
}

- (NSDate*)dateHeureFin {
    NSDateFormatter *dfDate = [[NSDateFormatter alloc] init] ;
    dfDate.dateFormat = @"EEEE dd MMMM yyyy" ;
    NSDateFormatter *dfHeureFin = [[NSDateFormatter alloc] init] ;
    dfHeureFin.dateFormat = @"EEEE dd MMMM yyyy HH:mm" ;
    return [dfHeureFin dateFromString:[NSString stringWithFormat:@"%@ %@", [dfDate stringFromDate:self.date], self.heureFin]] ;
}

@end
