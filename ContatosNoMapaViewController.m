//
//  ContatosNoMapaViewController.m
//  CaelumIP67
//
//  Created by Caio Incau on 02/08/12.
//  Copyright (c) 2012 Caio Incau. All rights reserved.
//

#import "ContatosNoMapaViewController.h"

@interface ContatosNoMapaViewController ()

@end

@implementation ContatosNoMapaViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
