//
//  FirstViewController.h
//  iPhone Practice 1
//
//  Created by Francois Chaubard on 11/8/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface TableViewController : UITableViewController <UINavigationControllerDelegate, NSFetchedResultsControllerDelegate> 
{
       
        NSFetchedResultsController *fetchedResultsController;
        NSManagedObjectContext *managedObjectContext;
    	NSMutableArray *titleData;
    	NSMutableArray *descriptionData;
        NSString *sortType;
        BOOL orderAscending;
}

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property(nonatomic, retain) NSArray *titleData;
@property(nonatomic, retain) NSArray *descriptionData;
@property(nonatomic, retain) NSString *sortType;


- (void)fetchRecords;
- (IBAction)reorderTable:(UISegmentedControl *)sender;
- (IBAction)ascendingOrder:(UITapGestureRecognizer *)sender;

@end