//
//  RotatableViewControler.m
//  Psychologist
//
//  Created by Thadeu Carmo on 5/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RotatableViewController.h"
#import "SplitViewBarButtonItemPresenter.h"

@interface RotatableViewController ()

@end

@implementation RotatableViewController

- (id<SplitViewBarButtonItemPresenter>) splitViewBarButtonItemPresenter
{
    id detailViewController = [self.splitViewController.viewControllers lastObject];
    if(![detailViewController conformsToProtocol:@protocol(SplitViewBarButtonItemPresenter)]){
        detailViewController = nil;
    }
    return detailViewController;
}

- (void) awakeFromNib 
{
    [super awakeFromNib];
    self.splitViewController.delegate = self;
}

- (BOOL) splitViewController:(UISplitViewController *)svc 
            shouldHideViewController:(UIViewController *)vc 
               inOrientation:(UIInterfaceOrientation)orientation
{
    return [self splitViewBarButtonItemPresenter] ? UIInterfaceOrientationIsPortrait(orientation) : NO;
}


- (void) splitViewController:(UISplitViewController *)svc 
            willHideViewController:(UIViewController *)aViewController 
                withBarButtonItem:(UIBarButtonItem *)barButtonItem 
                    forPopoverController:(UIPopoverController *)pc
{
    barButtonItem.title = self.navigationItem.title;
    [self splitViewBarButtonItemPresenter].splitViewBarButtonItem = barButtonItem;
}


- (void) splitViewController:(UISplitViewController *)svc 
            willShowViewController:(UIViewController *)aViewController 
                invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    [self splitViewBarButtonItemPresenter].splitViewBarButtonItem = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
