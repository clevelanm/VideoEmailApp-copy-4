//
//  SecondViewController.h
//  VideoEmailApp
//
//  Created by Matthew Sean Cleveland on 1/5/14.
//  Copyright (c) 2014 Matthew Sean Cleveland. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "FirstViewController.h"
#import "ThirdViewController.h"
#import "Singleton.h"
#import "ALToastView.h"

@interface SecondViewController : UIViewController <UIScrollViewDelegate, MFMailComposeViewControllerDelegate, UITextFieldDelegate>
{
	IBOutlet UITextField	*toEmail;
	IBOutlet UITextField	*subject;
	IBOutlet UITextField	*body;
	
	//ThirdViewController	*confirmationViewController;
    
   
	
}

@property (weak, nonatomic) IBOutlet UITextField *activeField;

@property (weak, nonatomic) IBOutlet UITextField *textView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, retain) UINavigationController  *navigationController;
@property (nonatomic, assign) id delegate;


- (IBAction) sendEmail;
- (BOOL) textFieldShouldReturn: (UITextField *) theTextField;


@end