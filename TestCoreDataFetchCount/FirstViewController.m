//
//  FirstViewController.m
//  TestCoreDataFetchCount
//
//  Created by Pan Peter on 13/7/18.
//  Copyright (c) 2013年 Pan Peter. All rights reserved.
//

#import "FirstViewController.h"
#import "AppDelegate.h"
#import "SportSync.h"

@interface FirstViewController ()
{
    UITextField *countTextField;
    UILabel *fetchTimeLabel;
    UILabel *fetchCountLabel;

}

@end

@implementation FirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIButton *createBut = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 100, 40)];
    [createBut setTitle:@"create" forState:UIControlStateNormal];
    [createBut setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:createBut];
    [createBut addTarget:self action:@selector(create:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *getBut = [[UIButton alloc] initWithFrame:CGRectMake(130, 10, 100, 40)];
    [getBut setTitle:@"get" forState:UIControlStateNormal];
    [getBut setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:getBut];
    [getBut addTarget:self action:@selector(get:) forControlEvents:UIControlEventTouchUpInside];

    countTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 70, 300, 30)];
    countTextField.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:countTextField];
    countTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    countTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    fetchTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 120, 300, 30)];
    [self.view addSubview:fetchTimeLabel];
    
    fetchCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 170, 300, 30)];
    [self.view addSubview:fetchCountLabel];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createData:(UIView*)loadingView
{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSEntityDescription *syncEntity = [NSEntityDescription entityForName:@"SportSync" inManagedObjectContext:delegate.managedObjectContext];
    int i;
    for(i=0;i<[countTextField.text intValue];i++)
    {
        SportSync *syncRecord = [[SportSync alloc] initWithEntity:syncEntity insertIntoManagedObjectContext:delegate.managedObjectContext];
        syncRecord.action = @(0);
        syncRecord.createTime = [NSDate date];
        syncRecord.date = syncRecord.createTime ;
        syncRecord.uuid = [NSString stringWithFormat:@"%d", i];
        syncRecord.name = [NSString stringWithFormat:@"test%d", i];
        syncRecord.duration = @(100);
        syncRecord.calorie = @(300);
        
    }
    [delegate.managedObjectContext save:nil];

    [loadingView removeFromSuperview];
}

-(void)create:(id)sender
{
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activity.center = CGPointMake(160, 240);
    [self.view addSubview:activity];
    [activity startAnimating];
    [self performSelector:@selector(createData:) withObject:activity afterDelay:0.1];
    
        

}

-(void)getData:(UIView*)loadingView
{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSString *entityName = @"SportSync";
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:delegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    [fetchRequest setReturnsObjectsAsFaults:NO];
    
    
    if(countTextField.text.length)
    {
        [fetchRequest setFetchLimit:[countTextField.text intValue]];
        
    }
    
    
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:@"createTime" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    
    NSError *error;
    NSDate *beforeFetch = [NSDate date];
    NSArray *array = [delegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    NSDate *afterFetch = [NSDate date];
    NSTimeInterval interval = [afterFetch timeIntervalSinceDate:beforeFetch];
    fetchTimeLabel.text = [NSString stringWithFormat:@"fetch time: %.2f s", interval];
    fetchCountLabel.text = [NSString stringWithFormat:@"fetch count: %d", array.count];
    [loadingView removeFromSuperview];

}

-(void)get:(id)sender
{
    
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activity.center = CGPointMake(160, 240);
    [self.view addSubview:activity];
    [activity startAnimating];
    [self performSelector:@selector(getData:) withObject:activity afterDelay:0.1];

    
    
}

@end
