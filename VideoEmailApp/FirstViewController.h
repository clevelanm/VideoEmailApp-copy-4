//
//  FirstViewController.h
//  VideoEmailApp
//
//  Created by Matthew Sean Cleveland on 1/5/14.
//  Copyright (c) 2014 Matthew Sean Cleveland. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "SecondViewController.h"
#import "Singleton.h"

@interface FirstViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    UIViewController	*mainViewController;
}


@property (copy,   nonatomic) NSURL *movPath;
@property NSURL *movieURL;
@property (strong, nonatomic) MPMoviePlayerController *movieController;

- (IBAction)takeVideoBtn:(UIButton *)sender;

@end

