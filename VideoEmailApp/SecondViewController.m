//
//  SecondViewController.m
//  VideoEmailApp
//
//  Created by Matthew Sean Cleveland on 1/5/14.
//  Copyright (c) 2014 Matthew Sean Cleveland. All rights reserved.
//

#import "Singleton.h"
#import "SecondViewController.h"


@interface SecondViewController ()

@end

@implementation SecondViewController

@synthesize scrollView;
@synthesize textView;
@synthesize activeField;
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated
{
    //[super viewWillAppear:animated];


    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.textView.delegate = self;
    toEmail.delegate = self;
    subject.delegate = self;
    body.delegate = self;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.scrollView layoutIfNeeded];
    self.scrollView.contentSize = self.textView.bounds.size;
}

- (void)viewDidAppear:(BOOL)animated
{
    
    Singleton* single = [Singleton sharedInstance];
    if (single.movieU != nil) {
        [ALToastView toastInView:self.view withText:@"Video recorded!"];
    }
    else
    {
        [ALToastView toastInView:self.view withText:@"No video detected."];
    }
}
/*
- (IBAction)pushToNavigate:(id)sender {
    NSLog(@"pushed");
    [self performSegueWithIdentifier:@"secondToThird" sender:self];
}*/

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}*/

- (void)keyboardWillShow:(NSNotification*)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0);
    
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    CGRect rect = self.view.frame;
    rect.size.height -= keyboardSize.height;
    
    if (!CGRectContainsPoint(rect, self.textView.frame.origin)) {
        CGPoint scrollPoint = CGPointMake(0.0, self.textView.frame.origin.y - keyboardSize.height);
        [self.scrollView setContentOffset:scrollPoint animated:YES];
    }
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}


- (IBAction) sendEmail
{
	NSLog(@"sendEmail");
	if ([MFMailComposeViewController canSendMail])
	{
		// set the sendTo address
		NSMutableArray *recipients = [[NSMutableArray alloc] initWithCapacity:1];
        if (toEmail.text != nil) {
            	NSLog(@"not nil");
            [recipients addObject:toEmail.text];
        }
		else {
            	NSLog(@"nil");
            [recipients addObject:@"clevelanm@sou.edu"];
        }
		
		MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
		controller.mailComposeDelegate = self;
		[controller setSubject:subject.text];
		[controller setMessageBody:body.text isHTML:NO];
		[controller setToRecipients:recipients];

		// add attachment
        Singleton* single = [Singleton sharedInstance];
        if (single.movieU != nil) {
            [controller addAttachmentData:[NSData dataWithContentsOfURL: single.movieU] mimeType:@"video/MOV" fileName:@"defectVideo.MOV"];
        }
        
		[self presentViewController:controller animated:YES completion:nil];
		
	}
	else
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Your device is not set up for email." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
		[alert show];
	}
	
}


- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    
	switch (result)
	{
		case MFMailComposeResultCancelled:
		{
            [ALToastView toastInView:self.view withText:@"Email Cancelled!"];
			break;
		}
		case MFMailComposeResultSaved:
		{
			break;
		}
		case MFMailComposeResultSent:
		{
            [ALToastView toastInView:self.view withText:@"Email Sent Successfully!"];
            //[self performSegueWithIdentifier: @"secondToThird" sender: self];
            break;
		}
		case MFMailComposeResultFailed:
		{
			break;
		}
		default:
		{
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email" message:@"Email Failed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
			[alert show];
		}
			break;
	}
	
	[self becomeFirstResponder];
    [self performSegueWithIdentifier: @"secondToThird" sender: self];
	[self dismissViewControllerAnimated:YES completion:nil];
}

// dismisses the keyboard when a user selects the return key
- (BOOL) textFieldShouldReturn: (UITextField *) theTextField
{
	[theTextField resignFirstResponder];
	return YES;
}

/*- (void)dealloc
{

}*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"secondToThird"])
	{
		ThirdViewController *destinationController = [segue destinationViewController];
		//thirdViewController.delegate = self;
	}
}




@end
