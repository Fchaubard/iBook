//
//  Event.h
//  LapTimer
//
//  Created by Alex Eckermann on 2/05/10.
//  Created for MobTuts
//

#import <CoreData/CoreData.h>


@interface UserInfo :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * link;
@property (nonatomic, retain) NSString * linkName;
@property (nonatomic, retain) NSDate * timeStamp;

@end



