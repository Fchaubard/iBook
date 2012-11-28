//
//  FirstViewController.m
//  iPhone Practice 1
//
//  Created by Francois Chaubard on 11/8/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "WebViewController.h"



@implementation WebViewController

@synthesize webView;
@synthesize buttonView;
@synthesize back;
@synthesize forward;
@synthesize titleData;
@synthesize descriptionData;
@synthesize fetchedResultsController;
@synthesize managedObjectContext;
@synthesize m_activity;
@synthesize mySearchBar;
@synthesize hidebtnObject;

// Portrait Mode Coordinates
int hiddenHorizontalPosition_P = 270;
int hiddenVerticalPosition_P   = 300;
int horizontalPosition_P       = 0;
int verticalPosition_P         = 352;

//Landscape Mode Coordinates
int hiddenHorizontalPosition_L = 430; //x
int hiddenVerticalPosition_L   = 100;   //y
int horizontalPosition_L       = 0;   
int verticalPosition_L         = 200;

BOOL landscape = FALSE; // keep track of what orientation we are in
BOOL hidden    = FALSE; // keep track of if the scroll is hidden or not

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}


// draw button with static width and height
/*
-(void)drawbuttons2
{
    int w = 100; // width of the button
    int h = 35;  // height of buttons
    int x = 20;  // space between buttons
    int d = 5; // distance buttons are from the top of the scrollview
    
    int contentSize = 0; // how much content to scroll
    
    int numberOfButtons = [titleData count]; // number of buttons
    //UIButton *buttons[numberOfButtons];
    for(int j = 0; j<numberOfButtons; j++){
        
        UserInfo *event = [titleData objectAtIndex: j];
        //[arr_buttons addObject:buttons[j]];  //this is defined in the header as an NSMutableArray
            // button parameters coded here
        //[self.view addSubview:buttons[j]];
        //create button
        contentSize = j*w + (j+1)*x;
        UIButton *btn = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
        btn.frame = CGRectMake((j*w + (j+1)*x), d, w, h);
        btn.bounds = CGRectMake(0, 0, w, h);
        //[btn setImage:[self scaleAndRotateImage:[UIImage imageNamed:@"basicbutton.png"]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(loadWebsite:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = j; 
        //btn.titleLabel = [self.titleData objectAtIndex:j];
        
       
        [btn setTitle:[event linkName] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [self.buttonView addSubview:btn];
    }
    
    UIButton *btn = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
    btn.frame = CGRectMake(contentSize+x+w, d, h, h);
    btn.bounds = CGRectMake(0, 0, h, h);
    //[btn setImage:[self scaleAndRotateImage:[UIImage imageNamed:@"basicbutton.png"]] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(addTime:) forControlEvents:UIControlEventTouchUpInside];
    //btn.tag = numberOfButtons+1; 
    //btn.titleLabel = [self.titleData objectAtIndex:j];
    
    
    [btn setTitle:@"+" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.buttonView addSubview:btn];
    
    [buttonView setContentSize:CGSizeMake(contentSize+w+x+h, buttonView.bounds.size.height)];
    buttonView.clipsToBounds = YES;
}
*/


// draw button with dynamic width and height
-(void)drawbuttons
{
   
    int h = 35;  // height of buttons
    int x = 20;  // space between buttons
    int d = 10; // distance buttons are from the top of the scrollview
    int hideButton = 35; // width of the hideButton
    
    // Insert hideButton
    UIButton *hidebtn = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
   
    [hidebtn setBackgroundImage:[UIImage imageNamed:@"normal.png"] forState:UIControlStateNormal];
    [hidebtn setBackgroundImage:[UIImage imageNamed:@"normal.png"] forState:UIControlStateDisabled];
    [hidebtn setBackgroundImage:[UIImage imageNamed:@"normal.png"] forState:UIControlStateSelected];
    [hidebtn setBackgroundImage:[UIImage imageNamed:@"normal.png"] forState:UIControlStateHighlighted];
    [hidebtn setBackgroundImage:[UIImage imageNamed:@"normal.png"] forState:(UIControlStateHighlighted | UIControlStateSelected)];

    hidebtn.frame = CGRectMake(x, d, hideButton, h);
    hidebtn.bounds = CGRectMake(0, 0, hideButton, h);
    //[hidebtn setImage:[self scaleAndRotateImage:[UIImage imageNamed:@"basicbutton.png"]] forState:UIControlStateNormal];
    [hidebtn addTarget:self action:@selector(hideScroll) forControlEvents:UIControlEventTouchUpInside];
    
    hidebtnObject = hidebtn;
    
    //[hidebtn setTitle:@"::" forState:UIControlStateNormal];
    //[hidebtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    //[hidebtn setBackgroundColor:[UIColor redColor]];
    [self.buttonView addSubview:hidebtn];
 
    
    
    
    // Start populating the User Content
    int contentSize = 2*x+hideButton;
    int numberOfButtons = [titleData count]; // number of buttons
    //UIButton *buttons[numberOfButtons];
    for(int j = 0; j<numberOfButtons; j++){
        
        
        
        // Initialize the event, label, and btn
        UserInfo *event = [titleData objectAtIndex: j];
        
        NSString * myString = [event linkName];
        UIButton *btn = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
        CGSize stringsize = [myString sizeWithFont:[UIFont systemFontOfSize:20]]; 
        
        
        int h = 1.4*stringsize.height; // for the + button to be consistent
        // Start Populating the btn
        [btn setFrame:CGRectMake(contentSize,d,stringsize.width, h)];
        btn.bounds = CGRectMake(0, 0, stringsize.width, h);
        //[btn setImage:[self scaleAndRotateImage:[UIImage imageNamed:@"basicbutton.png"]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(loadWebsite:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = j; 
        [btn setTitle:myString forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [self.buttonView addSubview:btn];
        contentSize += stringsize.width + x;
    }
    
    
    NSString * myString = @"<Add Current Site>";
    CGSize stringsize = [myString sizeWithFont:[UIFont systemFontOfSize:20]]; 
    
    UIButton *btn = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
    btn.frame = CGRectMake(contentSize, d, stringsize.width, h);
    btn.bounds = CGRectMake(0, 0, stringsize.width, h);

    //[btn setImage:[self scaleAndRotateImage:[UIImage imageNamed:@"basicbutton.png"]] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(addTime:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:myString forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.buttonView addSubview:btn];
    
    [buttonView setContentSize:CGSizeMake(contentSize+x+stringsize.width, buttonView.bounds.size.height)];
    buttonView.clipsToBounds = YES;

}
 
// Didnt work because WE ARENT IN A NAV CONTROLLER
/*
#pragma mark - Reload table on return
- (void)navigationController:(UINavigationController *)navigationController 
       didShowViewController:(UIViewController *)viewController 
                    animated:(BOOL)animated{
    
    for (UIButton* buttons in titleData) {		
		[buttons removeFromSuperview];
	}	
    
    [self fetchRecords];
    
}
 */
- (void)reloadButtons{
    //int numberOfButtons = [titleData count]; // number of buttons
    //UIButton *buttons[numberOfButtons];
    /*for(int j = 0; j<numberOfButtons; j++)
     {		
     [self.buttonView removeFromSuperview];
     }
     */
    for(UIView *subview in [buttonView subviews]) {
        if([subview isKindOfClass:[UIButton class]]) {
            [subview removeFromSuperview];
        } else {
            // Do nothing - not a UIButton or subclass instance
        }
    }
    [self fetchRecords];
}

 
- (void)tabBarController:(UITabBarController *)tabBarController 
 didSelectViewController:(UIViewController *)viewController
{
    NSLog(@"-didSelectViewController:%@", viewController);
    
    //int tag = tabBarController.selectedIndex;
    
    //if (tag==0) 
    //{
        [self reloadButtons];

    //}
}


-(void)webViewDidStartLoad:(UIWebView *) portal {
    UIActivityIndicatorView *actInd = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    UIBarButtonItem *actItem = [[UIBarButtonItem alloc] initWithCustomView:actInd];
    
    self.navigationItem.rightBarButtonItem = actItem;
   
    [m_activity startAnimating];   
    [actInd startAnimating];
    [actInd release];
    [actItem release];
    
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [m_activity stopAnimating];  
    // Enable or disable back
    if(buttonView.frame.origin.x==0){
        [back setHidden:![self.webView canGoBack]];
    
        // Enable or disable forward
        [forward setHidden:![self.webView canGoForward]]; 
        
    }
}



-(IBAction)loadWebsite:(UIButton *)sender
{
    NSLog(@"Button Clicked");
    // load a page from the internet
    
    
    
    
    NSString *urlAddress = nil;
    /*switch (sender.tag) {
        case 0:
            urlAddress = @"http://www.google.com";
            break;
        case 1:
            urlAddress = @"http://www.busbookie.com";
            break;
        case 2:
            urlAddress = @"http://www.youtube.com/watch?v=UN2KqffYEdI";
            break;
        case 3:
            urlAddress = @"http://www.wikipedia.com";
            break;
        case 4:
            urlAddress = @"http://www.busbookie.com";
            break;
        default:
            break;
    }*/
    
    // Get link from the event by the tag of the button
    UserInfo *event = [titleData objectAtIndex: sender.tag];
    urlAddress = event.link;
    [self reloadWebPage:urlAddress];
    

}

- (void)dealloc {
    [titleData dealloc];
    [super dealloc];
}

#pragma mark - Hide Scroll View
- (IBAction)hideScroll{ 

    int animationLength = 1;
    int animationDelay = 0.1;
    
    CGAffineTransform current = hidebtnObject.transform;
    landscape = (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation));
    // Restore the ScrollView
    if(hidden==TRUE)
    {
        [forward setHidden:![webView canGoForward]];
        [back setHidden:![webView canGoBack]];
        
        [UIView animateWithDuration:animationLength
                              delay:animationDelay
                            options: UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             
                             [forward setHidden:![webView canGoForward]];
                             [back setHidden:![webView canGoBack]];
                             //set alpha?
                         } 
                         completion:^(BOOL finished){
                             NSLog(@"Done ");
                         }];
        
        [buttonView setScrollEnabled:TRUE];
        [mySearchBar setHidden:FALSE];


        [UIView animateWithDuration:animationLength
                              delay:animationDelay
                            options: UIViewAnimationCurveEaseOut
                         animations:^{
                             //basketTop.frame = basketTopFrame;
                             if (landscape) {
                                  [hidebtnObject setTransform:CGAffineTransformRotate(current,3.14)];
                                 [buttonView setFrame:CGRectMake(horizontalPosition_L,verticalPosition_L,buttonView.frame.size.width, buttonView.frame.size.height)];
                                 [self.tabBarController.tabBar setHidden:NO];

                             }
                             else{
                                  [hidebtnObject setTransform:CGAffineTransformRotate(current,3.14)];
                                  [buttonView setFrame:CGRectMake(horizontalPosition_P,verticalPosition_P,buttonView.frame.size.width, buttonView.frame.size.height)];
                                 [self.tabBarController.tabBar setHidden:NO];

                             }
                         } 
                         completion:^(BOOL finished){
                             NSLog(@"Done ");
                         }];
        
        


        [UIView animateWithDuration:0.3f animations:^{
           
        }];

        
        
        
        
        NSLog(@"Restoring the Scroll View");
        hidden=FALSE;
    }
    // Hide the ScrollView
    else
    {

        [forward setHidden:TRUE];
        [back setHidden:TRUE];
        [buttonView setScrollEnabled:FALSE];
        [mySearchBar setHidden:TRUE];
        
        [UIView animateWithDuration:animationLength
                              delay:animationDelay
                            options: UIViewAnimationCurveEaseOut
                         animations:^{
                             //basketTop.frame = basketTopFrame;
                             if (landscape) {
                                 
                               
                                 
                                 [buttonView setFrame:CGRectMake(hiddenHorizontalPosition_L,hiddenVerticalPosition_L,buttonView.frame.size.width, buttonView.frame.size.height)];
                                 [hidebtnObject setTransform:CGAffineTransformRotate(current,3.14)];
                                 [self.tabBarController.tabBar setHidden:YES];
                             }
                             else{
                                
                                 
                                [buttonView setFrame:CGRectMake(hiddenHorizontalPosition_P,hiddenVerticalPosition_P,buttonView.frame.size.width, buttonView.frame.size.height)];
                                [hidebtnObject setTransform:CGAffineTransformRotate(current,3.14)];
                                 
                                 [self.tabBarController.tabBar setHidden:YES];
                             }
                         } 
                         completion:^(BOOL finished){
                             NSLog(@"Done ");
                         }];
        
        
        NSLog(@"Hiding the Scroll View");
        hidden=TRUE;
    }

}

#pragma mark - Add an Entry
- (IBAction)addTime:(id)sender {
	
	UserInfo *event = (UserInfo *)[NSEntityDescription insertNewObjectForEntityForName:@"UserInfo" inManagedObjectContext:managedObjectContext];
	[event setTimeStamp: [NSDate date]];
    [event setLinkName: [webView.request.URL host]];
    [event setLink: [webView.request.URL relativeString]];
    
	
	NSError *error;
	if (![managedObjectContext save:&error]) {
		// This is a serious error saying the record could not be saved.
		// Advise the user to restart the application
        NSLog(@"BIGGG ISSUEE");
	}
	
	[titleData insertObject:event atIndex:0];
    
	[self reloadButtons];
}


#pragma mark - Load Persistant Data
- (void)fetchRecords {
	
	// Define our table/entity to use
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"UserInfo" inManagedObjectContext:managedObjectContext];
	
	// Setup the fetch request
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:entity];
	
	// Define how we will sort the records
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timeStamp" ascending:NO];
	NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
	
	[request setSortDescriptors:sortDescriptors];
	[sortDescriptor release];
	
	// Fetch the records and handle an error
	NSError *error;
	NSMutableArray *mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
	
	if (!mutableFetchResults) {
		// Handle the error.
		// This is a serious error and should advise the user to restart the application
        NSLog(@"SERIOUS ERROR");
	}
	NSLog(@"All Good 1");
    
	// Save our fetched data to an array
	self.titleData = mutableFetchResults;
	
    [self drawbuttons];
    
	[mutableFetchResults release];
	[request release];
	
}

#pragma mark - Search Bar 

//UISearchBarDelegate delegate methods

// called when keyboard search button pressed
/*- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    [mySearchBar resignFirstResponder];
    // Do something with the mySearchBar.text
    NSLog(@"clicked");
}

// called when cancel button pressed
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    
    [mySearchBar resignFirstResponder];
    NSLog(@"cancelled");
}
*/
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
     NSLog(@"User hit Search");
    [self handleSearch:mySearchBar];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
     NSLog(@"User edit search");
    //[self handleSearch:mySearchBar];
}

- (void)handleSearch:(UISearchBar *)searchBar {
   
    NSString *searchString = [searchBar text];

    NSLog(@"User searched for %@", searchString);
    
    [self reloadWebPage:searchBar.text];
    [searchBar resignFirstResponder]; // if you want the keyboard to go away
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar {
    NSLog(@"User canceled search");
    [searchBar resignFirstResponder]; // if you want the keyboard to go away
}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    // TO load a local page
    /*NSString *path = [[NSBundle mainBundle] pathForResource:@"google" ofType:@"html"];
	NSFileHandle *readHandle = [NSFileHandle fileHandleForReadingAtPath:path];
    
	NSString *htmlString = [[NSString alloc] initWithData: 
                            [readHandle readDataToEndOfFile] encoding:NSUTF8StringEncoding];
     
     */
    self.mySearchBar.delegate = self;
    self.tabBarController.delegate = self;
    //[[[[UIApplication sharedApplication] delegate] window] addSubview:self.navigationController.view];
    //[[[[UIApplication sharedApplication] delegate] window] addSubview:webView];
    //m_activity = nil;
    
    // getting data from the DB
    if (managedObjectContext == nil) 
    { 
        managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext]; 
        NSLog(@"After managedObjectContext: %@",  managedObjectContext);
    }

    
	[self fetchRecords];
    
    NSString * myString = [[titleData objectAtIndex: 0] link];
    
    // set the default home page in case core data returns nill
    if ([myString isEqualToString:nil]) {
        myString = @"http://www.google.com";
    }
    
    [self reloadWebPage:@"http://www.google.com"];
    
    //[self reloadWebPage:myString];
    
    [self hideScroll];
    
    webView.delegate = self;
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)reloadWebPage:(NSString *)urlAddress
{
    // load a page from the internet
    //NSString *urlAddress = @"http://www.google.com";
    
    //Create a URL object.
    //NSURL *url = [NSURL URLWithString:urlAddress];
    
    //URL Requst Object
    //NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    //Load the request in the UIWebView.
    //[webView loadRequest:requestObj];
	
    
    
	// to make html content transparent to its parent view -
	// 1) set the webview's backgroundColor property to [UIColor clearColor]
	// 2) use the content in the html: <body style="background-color: transparent">
	// 3) opaque property set to NO
	//
	//webView.opaque = NO;
	//webView.backgroundColor = [UIColor clearColor];
	webView.backgroundColor = [UIColor lightGrayColor];
	
    
    
    // more stuff for local
    //[self.webView loadHTMLString:htmlString baseURL:nil];
	//[htmlString release];
    
    
    [forward setHidden:![webView canGoForward]];
    [back setHidden:![webView canGoBack]];
    
    // Update the Search Bar
    [mySearchBar setText:urlAddress];
    
    //Create a URL object.
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    //URL Requst Object
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    //Load the request in the UIWebView.
    [webView loadRequest:requestObj];
	
    NSString *jsCommand = [NSString stringWithFormat:@"document.body.style.zoom = 1.5;"];
    [webView stringByEvaluatingJavaScriptFromString:jsCommand];
    
    
    //[self hideScroll];
}




- (void)viewDidUnload
{
    [webView release];
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
   
    
    UIActivityIndicatorView * activityIndicator1 = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]autorelease];
    
    activityIndicator1.frame=CGRectMake(0.0,0.0, 40.0, 40.0);
    
    activityIndicator1.center=self.view.center;
    
    [self.webView addSubview:activityIndicator1];

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
    landscape = (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation));
    //Landscape
    if (landscape){

        [forward setFrame:CGRectMake(410, forward.frame.origin.y, forward.frame.size.width, forward.frame.size.height)];
        
        if (hidden) {
            
        
            [buttonView setFrame:CGRectMake( hiddenHorizontalPosition_L,hiddenVerticalPosition_L ,buttonView.frame.size.width, buttonView.frame.size.height)];
        }else{
            
            [buttonView setFrame:CGRectMake(horizontalPosition_L,verticalPosition_L,buttonView.frame.size.width, buttonView.frame.size.height)];
        }
    }
    //Portrait
    else{
        
        [forward setFrame:CGRectMake(250, forward.frame.origin.y, forward.frame.size.width, forward.frame.size.height)];
        
        if (hidden) {
            
            
            [buttonView setFrame:CGRectMake( hiddenHorizontalPosition_P,hiddenVerticalPosition_P, buttonView.frame.size.width, buttonView.frame.size.height)];
        }else{
            
            [buttonView setFrame:CGRectMake(horizontalPosition_P,verticalPosition_P,buttonView.frame.size.width, buttonView.frame.size.height)];
        }
        
    }
    
    
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}





@end
