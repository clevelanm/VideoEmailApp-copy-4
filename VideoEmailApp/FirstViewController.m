//
//  FirstViewController.m
//  VideoEmailApp
//
//  Created by Matthew Sean Cleveland on 1/5/14.
//  Copyright (c) 2014 Matthew Sean Cleveland. All rights reserved.
//

#import "Singleton.h"
#import "FirstViewController.h"


@interface FirstViewController ()
@property (nonatomic, assign) id delegate;
@end

@implementation FirstViewController
@synthesize delegate;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    self.movieController = [[MPMoviePlayerController alloc] init];
    [self.movieController setContentURL:self.movieURL];
    
    [self.view addSubview:self.movieController.view];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayBackDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.movieController];
    
    Singleton* single = [Singleton sharedInstance];
    single.movieU = nil;
}

// create, configure and display the image picker
- (IBAction)takeVideoBtn:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
    [picker setVideoMaximumDuration:30];
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

//When the use button is pressed
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    Singleton* single = [Singleton sharedInstance];
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:@"public.movie"]){
        // Saving the video / // Get the new unique filename
        NSString *sourcePath = [[info objectForKey:@"UIImagePickerControllerMediaURL"]relativePath];
        UISaveVideoAtPathToSavedPhotosAlbum(sourcePath, self, /*@selector(video:didFinishSavingWithError:contextInfo:)*/nil, nil);
        self.movieURL = [[NSURL alloc] initFileURLWithPath: sourcePath];
        
        single.movieU = self.movieURL;
    }
    
    [self performSegueWithIdentifier: @"firstToSecond" sender: self];
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)moviePlayBackDidFinish:(NSNotification *)notification {
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    [self.movieController stop];
    [self.movieController.view removeFromSuperview];
    self.movieController = nil;
    
}

/*- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"firstToSecond"])
	{
		SecondViewController *destinationController = [segue destinationViewController];
		//thirdViewController.delegate = self;
	}
}*/

@end