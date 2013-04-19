//
//  MasterViewController.m
//  FlowerDetail
//
//  Created by Daniel Reid on 3/14/13.
//  Copyright (c) 2013 TitanTV BIM. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"

@interface MasterViewController () {
    NSMutableArray *_objects;
}

@property (nonatomic, strong)NSArray *flowerData;
@property (nonatomic, strong)NSArray *flowerSections;

-(void)CreateFlowerData;
@end

@implementation MasterViewController

-(NSArray *)flowerData
{
    if(!_flowerData){
        
        NSMutableArray *redFlowers = [[NSMutableArray alloc] init];
        NSMutableArray *blueFlowers = [[NSMutableArray alloc] init];
        
        [redFlowers addObject:@{@"name":@"Poppy",
                                @"picture":@"Poppy.png",
                                @"url":@"http://en.wikipedia.org/wiki/Poppy"}];
        [redFlowers addObject:@{@"name":@"Tulip",
                                @"picture":@"Tulip.png",
                                @"url":@"http://en.wikipedia.org/wiki/Tulip"}];
        [redFlowers addObject:@{@"name":@"Gerbera",
                                @"picture":@"Gerbera.png",
                                @"url":@"http://en.wikipedia.org/wiki/Gerbera"}];

        [blueFlowers addObject:@{@"name":@"Phlox",
         @"picture":@"Phlox.png",
         @"url":@"http://en.wikipedia.org/wiki/Phlox"}];
        [blueFlowers addObject:@{@"name":@"Pin Cushion Flower",
         @"picture":@"PinCushion Flower.png",
         @"url":@"http://en.wikipedia.org/wiki/Scabious"}];
        [blueFlowers addObject:@{@"name":@"Iris",
         @"picture":@"Iris.png",
         @"url":@"http://en.wikipedia.org/wiki/Iris"}];
        
        _flowerData = @[redFlowers,blueFlowers];
    }
    return _flowerData;
}

-(NSArray *)flowerSections{
    if(!_flowerSections) _flowerSections = @[@"Red Flowers",@"Blue Flowers"];
    return _flowerSections;
}

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;

    //UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    //self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - private messages
-(void)CreateFlowerData
{
    //do I need this method since I'm using properties and lazy instantiation?
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //return 1;
    return [self.flowerSections count];
    //access appropriate array then return count
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return _objects.count;
    return [self.flowerData[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"flowerCell"];
    //NSDate *object = _objects[indexPath.row];
    //cell.textLabel.text = [object description];
    cell.textLabel.text = self.flowerData[indexPath.section][indexPath.row][@"name"];//name of flower
    cell.detailTextLabel.text = self.flowerData[indexPath.section][indexPath.row][@"url"];//url for flower
    cell.imageView.image = [UIImage imageNamed:self.flowerData[indexPath.section][indexPath.row][@"picture"]];//the image.png
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    //return YES;
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
    //    NSDate *object = _objects[indexPath.row];
    //    self.detailViewController.detailItem = object;
   // }
    self.detailViewController.detailItem = self.flowerData[indexPath.section][indexPath.row];
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.flowerSections[section];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        //NSDate *object = _objects[indexPath.row];
        //[[segue destinationViewController] setDetailItem:object];
        [[segue destinationViewController] setDetailItem:self.flowerData[indexPath.section][indexPath.row]];
    }
}

@end
