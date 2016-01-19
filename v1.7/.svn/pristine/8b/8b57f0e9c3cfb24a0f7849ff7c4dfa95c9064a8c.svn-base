//
//  ProductViedoTableViewController.m
//  CMCCMarketing
//
//  Created by kevin on 15/10/29.
//  Copyright © 2015年 talkweb. All rights reserved.
//

#import "ProductViedoTableViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "NetworkHandling.h"
@interface ProductViedoTableViewController ()<UIWebViewDelegate>
{
    NSArray *tableArray;
    MPMoviePlayerController *moviePlayer;
}

@end

@implementation ProductViedoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    tableArray=[[NSArray alloc] initWithObjects:@"四彩业务",@"集团业务产品",@"物联卡", nil];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return [tableArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductViedoCell" forIndexPath:indexPath];
    
   cell.textLabel.text=[tableArray objectAtIndex:indexPath.row];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSString *urlS3tring=@"dimjson/gprs_list.json";
//    NSString *baseUrlString=[NetworkHandling getBaseUrlString];
//    urlString = [baseUrlString stringByAppendingString:urlString];
    NSString *urlString;
    if(indexPath.row == 0)
    {
        urlString=@"viedo/sicaiyewu.mp4";
        }
    if(indexPath.row == 1)
    {
       urlString=@"viedo/jituanyewu.mp4";
    }
    if(indexPath.row == 2)
    {
        urlString=@"viedo/wulianka.mp4";
    }
    NSString *baseUrlString=[NetworkHandling getBaseUrlString];
    urlString = [baseUrlString stringByAppendingString:urlString];
     NSURL *url = [NSURL URLWithString:urlString];
    MPMoviePlayerViewController *movieVc=[[MPMoviePlayerViewController alloc]initWithContentURL:url];
    //弹出播放器
    [self presentMoviePlayerViewControllerAnimated:movieVc];

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
