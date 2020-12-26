//
//  AllLeaguesTableViewController.m
//  ProjetoFinal_HugoMeireles
//
//  Created by Hugo Meireles on 11/05/2019.
//  Copyright © 2019 Hugo Meireles. All rights reserved.
//

#import "AllLeaguesTableViewController.h"
#import "FootballDataAPI.h"
#import "League.h"
#import "LeagueTableViewCell.h"
#import "FavoritesManager.h"
#import "LeagueAllMatchesTableViewController.h"

@interface AllLeaguesTableViewController ()

@property (strong,nonatomic) NSDictionary *leagueList;
@property (strong, nonatomic) FootballDataAPI *footballDataApi;

@end

@implementation AllLeaguesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.footballDataApi = [FootballDataAPI new];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tableView.contentOffset = CGPointMake(0, -self.refreshControl.frame.size.height);
    [self.refreshControl beginRefreshing];
    [self updateModel];
}

- (void)updateModel {
    
    __weak AllLeaguesTableViewController *weakSelf = self;
    
    [self.footballDataApi getAllLeagues:^(NSDictionary * leagueList,NSError * error) {
        
        [NSOperationQueue.mainQueue addOperationWithBlock:^{
            
            if (error) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                [alertController addAction:action];
                [weakSelf presentViewController:alertController animated:YES completion:nil];
            } else {
                weakSelf.leagueList = leagueList;
            }
            
            [weakSelf.refreshControl endRefreshing];
        }];
        
    }];
    
}

- (void)setLeagueList:(NSDictionary *)leagueList{
    _leagueList = leagueList;
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.leagueList allKeys] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LeagueTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leagueCell" forIndexPath:indexPath];
    League *league = [self.leagueList allValues][indexPath.row];
    cell.leagueId.text = [NSString stringWithFormat:@"%d",[league.leagueId intValue]];
    cell.leagueName.text = league.leagueName;
    cell.leagueCountry.text = league.leagueCountry;
    if([FavoritesManager isFavoriteWithName:league.leagueName]){
        [self.tableView beginUpdates];
        [self.tableView moveRowAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.section]];
        [self.tableView endUpdates];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    League *league = [self.leagueList allValues][indexPath.row];
    [self performSegueWithIdentifier:@"goToLeagueMatches" sender:league];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.destinationViewController isKindOfClass:LeagueAllMatchesTableViewController.class]){
        League *league = sender;
        LeagueAllMatchesTableViewController *leagueMatches = segue.destinationViewController;
        leagueMatches.leagueId = league.leagueId;
        leagueMatches.leagueName = league.leagueName;
        leagueMatches.title = league.leagueName;
        leagueMatches.leagueMatchDay = @(1);
    }
}

@end
