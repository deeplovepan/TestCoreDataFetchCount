//
//  SportSync.h
//  TestCoreDataFetchCount
//
//  Created by Pan Peter on 13/7/18.
//  Copyright (c) 2013年 Pan Peter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SportSync : NSManagedObject

@property (nonatomic, retain) NSNumber * action;
@property (nonatomic, retain) NSNumber * calorie;
@property (nonatomic, retain) NSDate * createTime;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * duration;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * uuid;

@end
