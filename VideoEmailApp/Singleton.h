//
//  Singleton.h
//  VideoEmailApp
//
//  Created by Matthew Sean Cleveland on 1/16/14.
//  Copyright (c) 2014 Matthew Sean Cleveland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Singleton : UIViewController

@property NSURL *movieU;

+ (id)sharedInstance;

@end
