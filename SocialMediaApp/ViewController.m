//
//  ViewController.m
//  SocialMediaApp
//
//  Created by Sonja Riethig on 14/01/16.
//  Copyright © 2016 Sonja Riethig. All rights reserved.
//

#import "ViewController.h"
#import "Social/Social.h"

@interface ViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;

@property (weak, nonatomic) IBOutlet UITextView *textForTwitter;
@property (weak, nonatomic) IBOutlet UITextView *textForFacebook;
@property (weak, nonatomic) IBOutlet UITextView *textForMore;

- (void)styleTwitterTextView;
- (void)styleFacebookTextView;
- (void)styleMoreTextView;
- (void)resignAllFirstResponders;
- (void)showNotSignedInMessage:(NSString *)messageSignIn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self styleTwitterTextView];
    [self styleFacebookTextView];
    [self styleMoreTextView];
    
    self.textForTwitter.delegate = self;
    self.textForFacebook.delegate = self;
    self.textForMore.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonTwitterPressed:(id)sender {
    [self resignAllFirstResponders];
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]){
        SLComposeViewController *twitterController =
            [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        if ([self.textForTwitter.text length] < 140) {
            [twitterController setInitialText:self.textForTwitter.text];
        } else {
            [twitterController setInitialText:[self.textForTwitter.text substringToIndex:140]];
        }
        
        [self presentViewController:twitterController animated:YES completion:nil];
    } else {
        [self showNotSignedInMessage:@"you are not signed in to Twitter, please go to your SETTINGS and log in"];
    }
    
}

- (IBAction)buttonFacebookPressed:(id)sender {
    [self resignAllFirstResponders];
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]){
        SLComposeViewController *facebookController =
        [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [facebookController setInitialText:self.textForFacebook.text];
        
        [self presentViewController:facebookController animated:YES completion:nil];
    } else {
        [self showNotSignedInMessage:@"you are not signed in to Facebook, please go to your SETTINGS and log in"];
    }
}

- (IBAction)buttonMorePressed:(id)sender {
    [self resignAllFirstResponders];
    
    UIActivityViewController *moreController = [[UIActivityViewController alloc] initWithActivityItems:@[self.textForMore.text] applicationActivities:nil];
    
    [self presentViewController:moreController animated:YES completion:nil];
}

- (IBAction)buttonInfoPressed:(id)sender {
   [self resignAllFirstResponders];

    UIAlertController *popUpMessage = [UIAlertController alertControllerWithTitle:@"APP INFORMATION" message:@"You can share everything you want with this app. Let the world know, what you have to say!" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleDefault handler:nil];
    [popUpMessage addAction:cancelAction];
    
    [self presentViewController:popUpMessage animated:YES completion:nil];
}

- (void)showNotSignedInMessage:(NSString *)messageSignIn {
    UIAlertController *popUpMessage = [UIAlertController alertControllerWithTitle:@"" message:messageSignIn preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil];
    [popUpMessage addAction:cancelAction];
    
    [self presentViewController:popUpMessage animated:YES completion:nil];
}

- (void)styleTwitterTextView {
    [self.textForTwitter.layer setBackgroundColor:[UIColor colorWithRed:1.0 green:0.5 blue:0.5 alpha:1.0].CGColor];
    [self.textForTwitter.layer setBorderWidth:2.5];
    [self.textForTwitter.layer setCornerRadius:3.0];
}

- (void)styleFacebookTextView {
    [self.textForFacebook.layer setBackgroundColor:[UIColor colorWithRed:0.5 green:1.0 blue:0.5 alpha:1.0].CGColor];
    [self.textForFacebook.layer setBorderWidth:2.5];
    [self.textForFacebook.layer setCornerRadius:3.0];
}

- (void)styleMoreTextView {
    [self.textForMore.layer setBackgroundColor:[UIColor colorWithRed:0.5 green:0.5 blue:1.0 alpha:1.0].CGColor];
    [self.textForMore.layer setBorderWidth:2.5];
    [self.textForMore.layer setCornerRadius:3.0];
}

- (void)resignAllFirstResponders {
    if ([self.textForTwitter isFirstResponder]) {
        [self.textForTwitter resignFirstResponder];
    }
    if ([self.textForFacebook isFirstResponder]) {
        [self.textForFacebook resignFirstResponder];
    }
    if ([self.textForMore isFirstResponder]) {
        [self.textForMore resignFirstResponder];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

@end
