//
//  SecondViewController.h
//  iPhone Practice 1
//
//  Created by Francois Chaubard on 11/8/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "UserInfo.h"

@interface FormController : UIViewController <NSFetchedResultsControllerDelegate>  {
    
    NSFetchedResultsController *fetchedResultsController;
    NSManagedObjectContext *managedObjectContext;
    NSMutableArray *titleData;
    NSMutableArray *descriptionData;
    UITextField *productTextField;
    UITextField *descriptionTextField;   
    NSManagedObject *objectToEdit;
    UserInfo *userInfoToEdit;
    
}

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property(nonatomic, retain)  NSArray *titleData;
@property(nonatomic, retain)  NSArray *descriptionData;
@property(nonatomic, retain)  IBOutlet UITextField *productTextField;
@property(nonatomic, retain)  IBOutlet UITextField *descriptionTextField;
@property(nonatomic, retain)  NSManagedObject *objectToEdit;
@property(nonatomic, retain)  UserInfo *userInfoToEdit;

- (IBAction)addTime:(id)sender;
    
@end
