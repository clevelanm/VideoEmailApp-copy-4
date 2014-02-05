//
//  Singleton.m
//  VideoEmailApp
//
//  Created by Matthew Sean Cleveland on 1/16/14.
//  Copyright (c) 2014 Matthew Sean Cleveland. All rights reserved.
//

#import "Singleton.h"

@interface Singleton ()

@end

@implementation Singleton

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (id)sharedInstance {
    static id sharedInstance = nil;
    if (sharedInstance == nil) {
        sharedInstance = [[self alloc] init];
    }
    return sharedInstance;
}

@end
