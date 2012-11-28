//
//  FirstViewController.h
//  iPhone Practice 1
//
//  Created by Francois Chaubard on 11/8/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>

@interface WebViewController : UIViewController <UITabBarControllerDelegate, NSFetchedResultsControllerDelegate, UIWebViewDelegate, UISearchBarDelegate> {
    
    UISearchBar   *mySearchBar;
    UIWebView     *webView;
    UIScrollView  *buttonView;
    UIButton      *back;
    UIButton      *forward;
    UIButton      *hidebtnObject;
    NSFetchedResultsController *fetchedResultsController;
    NSManagedObjectContext *managedObjectContext;
    NSMutableArray *titleData;
    NSMutableArray *descriptionData;
    IBOutlet UIActivityIndicatorView *m_activity;
}

@property (nonatomic, retain) UIActivityIndicatorView *m_activity;
@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, assign) IBOutlet UIScrollView *buttonView;
@property (nonatomic, retain) IBOutlet UIButton *back;
@property (nonatomic, retain) IBOutlet UIButton *forward;
@property (nonatomic, retain) IBOutlet UIButton *hidebtnObject;
@property (nonatomic, retain) IBOutlet UISearchBar   *mySearchBar;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property(nonatomic, retain) NSArray *titleData;
@property(nonatomic, retain) NSArray *descriptionData;


- (IBAction)addTime:(id)sender;
- (IBAction)hideScroll;
- (void)fetchRecords;
- (void)reloadWebPage:(NSString *)urlAddress;
- (void)handleSearch:(UISearchBar *)searchBar;

@end
