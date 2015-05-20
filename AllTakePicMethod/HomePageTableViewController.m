//
//  HomePageTableViewController.m
//  AllTakePicMethod
//
//  Created by Chin-Hui Hsieh  on 5/19/15.
//  Copyright (c) 2015 Chin-Hui Hsieh. All rights reserved.
//
// http://furnacedigital.blogspot.tw/2012/02/uitableview_10.html#more
//

#import "HomePageTableViewController.h"
#import "CameraBySegue.h"
#import "CameraByDelegate.h"



@interface HomePageTableViewController () <UITableViewDelegate, UITableViewDataSource>
{

    NSMutableArray *allMethods,*takePhotoMethod, *otherMethod,*titleOfMethod;
    
    
}
@end

@implementation HomePageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //製作增加項目的UIBarButtonItem
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addMethodItem)];
    [self.navigationItem setLeftBarButtonItem:addButton];
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithTitle:@"編輯" style:UIBarButtonItemStyleDone target:self action:@selector(editMethodItem)];
    [self.navigationItem setRightBarButtonItem:editButton];

    
    
    takePhotoMethod =[[NSMutableArray alloc]initWithObjects:@"Take photo by segue",@"Take photo by delegate",@"From phone's album", nil];
    otherMethod = [[NSMutableArray alloc] initWithObjects:@"Method 01",@"Method 02",@"Method 03", nil];
    titleOfMethod = [[NSMutableArray alloc]initWithObjects:@"takePhotoMethod",@"otherMethod", nil];
    allMethods = [[NSMutableArray alloc]initWithObjects:takePhotoMethod,otherMethod, nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return [allMethods count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.tableView.editing) {
        return [[allMethods objectAtIndex:section] count] +1;
    } else {
        return [[allMethods objectAtIndex:section] count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    //製作可重復利用的表格欄位Cell
    static NSString *CellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    //設定欄位的內容與類型
    //設定按編輯時的新增欄位
    if (self.tableView.editing && indexPath.row == [[allMethods objectAtIndex:indexPath.section] count]) {
        cell.textLabel.text = @"點我增加項目";
    } else {
        cell.textLabel.text = [[allMethods objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    return cell;

}


//設定分類開頭標題
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
   
    return [titleOfMethod objectAtIndex:section];
}





//允許進行編輯
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
//編輯方式
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the row from the data source
        //刪除對應的陣列元素
        [[allMethods objectAtIndex:indexPath.section]removeObjectAtIndex:indexPath.row];
        
        //刪除對應的表格項目
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
        
        //如果該分類已沒有任何項目則刪除整個分類
        if ([[allMethods objectAtIndex:indexPath.section] count] == 0)
        {
            [allMethods removeObjectAtIndex:indexPath.section];
            [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
        }

        
    } else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        [[allMethods objectAtIndex:indexPath.section] addObject:@"被增加的項目"];
        [self.tableView reloadData];
    }   
}

//設定編輯時的類型
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [[allMethods objectAtIndex:indexPath.section] count]) {
        //最後一行時，該cell最前面顯示增加
        return UITableViewCellEditingStyleInsert;
    } else {
        //其餘cell最前面顯示刪除
        return UITableViewCellEditingStyleDelete;
    }
}



//在每個分類裡都添加一筆資料
- (void) addMethodItem {
    for (id item in allMethods) {
        [item addObject:@"被增加的項目"];
    }
    
    [self.tableView reloadData];
}

- (void)editMethodItem {
    if (self.tableView.editing) {
        [self.navigationItem.rightBarButtonItem setTitle:@"編輯"];
    } else {
        [self.navigationItem.rightBarButtonItem setTitle:@"完成"];
    }
    
    [self.tableView setEditing:!self.tableView.editing];
    [self.tableView reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0 && indexPath.row==0) {
        CameraBySegue *cameraVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CameraBySegueView"];
        [self.navigationController pushViewController:cameraVC animated:YES];

    }else if (indexPath.section==0 && indexPath.row==1)
    {
        CameraByDelegate *cameraVC1 = [self.storyboard instantiateViewControllerWithIdentifier:@"CameraByDelegateVC1"];
        [self.navigationController pushViewController:cameraVC1 animated:YES];
    }
    
    
    
    
}

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
