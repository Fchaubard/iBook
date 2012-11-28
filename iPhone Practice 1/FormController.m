//
//  SecondViewController.m
//  iPhone Practice 1
//
//  Created by Francois Chaubard on 11/8/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "FormController.h"
#import "AppDelegate.h"
#import "TableViewController.h"
@class UserInfo;


@implementation FormController

@synthesize titleData;
@synthesize descriptionData;
@synthesize fetchedResultsController;
@synthesize objectToEdit;
@synthesize userInfoToEdit;
@synthesize managedObjectContext;
@synthesize descriptionTextField;
@synthesize productTextField;


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    if (managedObjectContext == nil) 
    { 
        managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext]; 
        NSLog(@"After managedObjectContext: %@",  managedObjectContext);
    }
    
    //populate the Text Fields with the edit object
    if (objectToEdit!=nil) {
        
        [productTextField setText:[userInfoToEdit linkName]];
        [descriptionTextField setText:userInfoToEdit.link];
        
    }
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)addTime:(id)sender {
	
	UserInfo *event = (UserInfo *)[NSEntityDescription insertNewObjectForEntityForName:@"UserInfo" inManagedObjectContext:managedObjectContext];
	[event setTimeStamp: [NSDate date]];
    [event setLink: self.descriptionTextField.text];
    [event setLinkName: self.productTextField.text];
    
	
	NSError *error;
	if (![managedObjectContext save:&error]) {
		// This is a serious error saying the record could not be saved.
		// Advise the user to restart the application
        NSLog(@"BIGGG ISSUEE");
	}
	
	[titleData insertObject:event atIndex:0];
    
    
    
    //Start Segue
    // locally store the navigation controller since
    // self.navigationController will be nil once we are popped
    UINavigationController *navController = self.navigationController;
    
    // retain ourselves so that the controller will still exist once it's popped off
    [[self retain] autorelease];
    
    // Pop this controller and replace with another
    //[navController popViewControllerAnimated:NO];
    //TableViewController * tableViewController = [[TableViewController alloc] init];

    // Force the pop to occur 
    [navController popToRootViewControllerAnimated:YES];
    //[navController pushViewController:tableViewController animated:YES];

	
}


- (IBAction)editEntry:(id)sender {
	
    //delete the object in the Database
    
    [managedObjectContext deleteObject:objectToEdit];
    
    
    // Reimplement it with the new data
    
	UserInfo *event = (UserInfo *)[NSEntityDescription insertNewObjectForEntityForName:@"UserInfo" inManagedObjectContext:managedObjectContext];
	[event setTimeStamp: userInfoToEdit.timeStamp];
    [event setLink: self.descriptionTextField.text];
    [event setLinkName: self.productTextField.text];
    
	
	NSError *error;
	if (![managedObjectContext save:&error]) {
		// This is a serious error saying the record could not be saved.
		// Advise the user to restart the application
        NSLog(@"BIGGG ISSUEE");
	}
	
	[titleData insertObject:event atIndex:0];
    
    
    
    //Start Segue
    // locally store the navigation controller since
    // self.navigationController will be nil once we are popped
    UINavigationController *navController = self.navigationController;
    
    // retain ourselves so that the controller will still exist once it's popped off
    [[self retain] autorelease];
    
    // Pop this controller and replace with another
    //[navController popViewControllerAnimated:NO];
    //TableViewController * tableViewController = [[TableViewController alloc] init];
    
    // Force the pop to occur 
    [navController popToRootViewControllerAnimated:YES];
    //[navController pushViewController:tableViewController animated:YES];
    
	
}









- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
