//
//  FirstViewController.m
//  iPhone Practice 1
//
//  Created by Francois Chaubard on 11/8/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TableViewController.h"
#import "FormController.h"
#import "UserInfo.h"
#import "AppDelegate.h"

@implementation TableViewController


@synthesize titleData;
@synthesize descriptionData;
@synthesize fetchedResultsController;
@synthesize managedObjectContext;
@synthesize sortType;



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{   
    //self.titleData = [[NSArray alloc] initWithObjects:@"iPhone", @"iPod", @"iPad",nil];
    //self.descriptionData = [[NSArray alloc] initWithObjects:@"iPhone description",  @"iPod description", @"iPad description",nil];  
    
    
    
    fetchedResultsController.delegate = self;
    self.navigationController.delegate = self;
    
	
    
    if (managedObjectContext == nil) 
    { 
        managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext]; 
        NSLog(@"After managedObjectContext: %@",  managedObjectContext);
    }
    
    sortType=@"timeStamp";
    orderAscending=NO;
    
	[self fetchRecords];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}


#pragma mark - Reload table on return
- (void)navigationController:(UINavigationController *)navigationController 
       didShowViewController:(UIViewController *)viewController 
                    animated:(BOOL)animated{
    [self fetchRecords];
    [self.tableView reloadData];
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

- (void)dealloc {
    [titleData dealloc];
    [super dealloc];
}


#pragma mark - Add an Entry
- (void)addTime:(id)sender {
	
	UserInfo *event = (UserInfo *)[NSEntityDescription insertNewObjectForEntityForName:@"UserInfo" inManagedObjectContext:managedObjectContext];
	[event setTimeStamp: [NSDate date]];
	
	NSError *error;
	if (![managedObjectContext save:&error]) {
		// This is a serious error saying the record could not be saved.
		// Advise the user to restart the application
	}
	
	[titleData insertObject:event atIndex:0];
	[self.tableView reloadData];
	
}

#pragma mark - Segmented Control
-(IBAction)reorderTable:(UISegmentedControl *)sender
{

    switch (sender.selectedSegmentIndex) {
        case 0:
            sortType = @"timeStamp";
            orderAscending=NO;
            break;
        case 1:
            sortType = @"linkName";
            orderAscending=YES;
            break;
        case 2:
            sortType = @"link";
            orderAscending=YES;
            break;
        default:
            break;
    }
    [self fetchRecords];
    [self.tableView reloadData];

}

- (IBAction)ascendingOrder:(UITapGestureRecognizer *)sender{
    NSLog(@"asdfa");
    orderAscending=!orderAscending;
    [self fetchRecords];
    [self.tableView reloadData];
}

#pragma mark - Load Persistant Data
- (void)fetchRecords {
	
	// Define our table/entity to use
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"UserInfo" inManagedObjectContext:managedObjectContext];
	
	// Setup the fetch request
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:entity];
	
	// Define how we will sort the records
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sortType ascending:orderAscending];
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
	
	[mutableFetchResults release];
	[request release];
	
}


/*

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    	return [self.titleData count];
}
	 

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	 
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView
    	dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) 
    {
    	cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle 
                                      reuseIdentifier:cellIdentifier] autorelease];
    }
        

    NSUInteger row = [indexPath row];
    cell.textLabel.text = [titleData objectAtIndex:row];
    cell.detailTextLabel.text = [descriptionData objectAtIndex:row];
    
    return cell;
}
*/
#pragma mark -
#pragma mark Table view selection

- (void)prepareForSegue:(UIStoryboardSegue *)segue 
                 sender:(id)sender {
    
    /*
     When a row is selected, the segue creates the detail view controller as the destination.
     Set the detail view controller's detail item to the item associated with the selected row.
     */
    /*if ([[segue identifier] isEqualToString:@"ShowSelectedPlay"]) {
        
        NSIndexPath *selectedRowIndex = [self.tableView indexPathForSelectedRow];
        SecondViewController *detailViewController = [segue secondViewController];
        detailViewController.play = [dataController objectInListAtIndex:selectedRowIndex.row];
    }
     */
    
    if ([[segue identifier] isEqualToString:@"ShowSelected"]) {
     
        
        //NSIndexPath *selectedRowIndex = [self.tableView indexPathForSelectedRow];
        NSLog(@"All Good 2");
        // Assume self.view is the table view
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        
        NSManagedObject *objectToEdit = [titleData objectAtIndex: [path row]];
        //[managedObjectContext deleteObject:eventToDelete];
         
        UserInfo *userInfoToEdit = [titleData objectAtIndex: [path row]];
        [segue.destinationViewController setObjectToEdit:objectToEdit];
        [segue.destinationViewController setUserInfoToEdit:userInfoToEdit];
    }
    
    if ([[segue identifier] isEqualToString:@"AddSelected"]) {
        	
        NSLog(@"All Good 3");
        
        
    }
}



#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // There are three sections, for date, genre, and characters, in that order.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section {
    
	/*
	 The number of rows varies by section.
	 */
    NSInteger rows = 0;
    switch (section) {
        case 0:
        case 1:
            // For genre and date there is just one row.
            rows = [self.titleData count];
            break;
        default:
            break;
    }
    return rows;
}


- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier]; // makes the segue work
   
    //UITableViewCell *cell = nil;
    if (cell == nil) {
    
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        
        //cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    
    // Cache a date formatter to create a string representation of the date object
    static NSDateFormatter *dateFormatter = nil;
    
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        //[dateFormatter setDateFormat:@"yyyy"];
        [dateFormatter setDateFormat:@"h:mm.ss a"];
    }
    
    // Set the text in the cell for the section/row.
    
    UserInfo *event = [titleData objectAtIndex: [indexPath row]];
    
    //NSString *cellText = nil;
    //NSUInteger row = [indexPath row];
    switch (indexPath.section) {
        case 0:
            //cellText = [dateFormatter stringFromDate:play.date];
            
            
            [cell.textLabel       setText: [event linkName]];
            [cell.detailTextLabel setText: [event link]];
            
            //[cell.detailTextLabel setText: [dateFormatter stringFromDate: [event timeStamp]]];
            
            //cell.textLabel.text = [titleData objectAtIndex:row];
            //cell.detailTextLabel.text = [descriptionData objectAtIndex:row];
            break;
        case 1:
            //cellText = play.genre;
            
            //cell.textLabel.text = [titleData objectAtIndex:row];
            //cell.detailTextLabel.text = [descriptionData objectAtIndex:row];
            break;
        default:
            break;
    }
    
    //cell.textLabel.text = cellText;
    return cell;
}


#pragma mark - For Deleting from a table
-  (void)tableView:(UITableView *)tableView 
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 
 forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // Delete the managed object at the given index path.
        
        NSManagedObject *eventToDelete = [titleData objectAtIndex:indexPath.row];
        
        [managedObjectContext deleteObject:eventToDelete];
        
        
        // Update the array and table view.
        
        [titleData removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
        
        
        // Commit the change.
        
        NSError *error = nil;
        
        if (![managedObjectContext save:&error]) {
            
            // Handle the error.
            
        }
        
    }
    
}




#pragma mark -
#pragma mark Section header titles

/*
 HIG note: In this case, since the content of each section is obvious, there's probably no need to provide a title, but the code is useful for illustration.
 */

- (NSString *)tableView:(UITableView *)tableView 
titleForHeaderInSection:(NSInteger)section {
    
    NSString *title = nil;
    switch (section) {
        case 0:
            title = NSLocalizedString(@"Home", @"Home section title");
            break;
        case 1:
            title = NSLocalizedString(@"Work", @"Work section title");
            break;
        default:
            break;
    }
    return title;
}

@end
