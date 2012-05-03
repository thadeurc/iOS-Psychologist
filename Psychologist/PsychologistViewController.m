//
//  PsychologistViewController.m
//  Psychologist
//
//  Created by Thadeu Carmo on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PsychologistViewController.h"
#import "HappinessViewController.h"

@interface PsychologistViewController ()
@property (nonatomic) int diagnosis;
@end

@implementation PsychologistViewController

@synthesize diagnosis = _diagnosis;

- (void) setAndShowDiagnosis:(int) diagnosis
{
    self.diagnosis = diagnosis;
    [self performSegueWithIdentifier:@"showDiagnosis" sender:self];
}

- (IBAction)flying {
    [self setAndShowDiagnosis:85];
}

- (IBAction)apple {
    [self setAndShowDiagnosis:100];
}

- (IBAction)dragons {
    [self setAndShowDiagnosis:20];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"showDiagnosis"]) {
        [segue.destinationViewController setHappiness:self.diagnosis];
    } else if([segue.identifier isEqualToString:@"watchTV"]) {
        [segue.destinationViewController setHappiness:50];
    } else if([segue.identifier isEqualToString:@"problem"]) {
        [segue.destinationViewController setHappiness:20];
    } else if([segue.identifier isEqualToString:@"celebrity"]) {
        [segue.destinationViewController setHappiness:100];
    }
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
