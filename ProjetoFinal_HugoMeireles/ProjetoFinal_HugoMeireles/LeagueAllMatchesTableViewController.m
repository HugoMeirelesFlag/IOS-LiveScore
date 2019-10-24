//
//  LeagueAllMatchesTableViewController.m
//  ProjetoFinal_HugoMeireles
//
//  Created by Hugo Meireles on 13/05/2019.
//  Copyright © 2019 Hugo Meireles. All rights reserved.
//

#import "LeagueAllMatchesTableViewController.h"
#import "LeagueMatchDayTableViewCell.h"
#import "FootballDataAPI.h"
#import "Match.h"
#import "FavoritesManager.h"

@interface LeagueAllMatchesTableViewController ()

@property (strong,nonatomic) IBOutlet UIStepper *matchDayStepper;

@property (strong,nonatomic) NSDictionary *leagueMatches;
@property (strong, nonatomic) FootballDataAPI *footballDataApi;


@end

@implementation LeagueAllMatchesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.footballDataApi = [FootballDataAPI new];
    self.matchDayStepper.value = self.leagueMatchDay.doubleValue;
    self.matchDayStepper.minimumValue = 1;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self updateModel];
    if([self.leagueMatches isKindOfClass:[NSNull class]]){
        if(self.leagueMatchDay.intValue != 1){
            self.leagueMatchDay = @(1);
            self.matchDayStepper.value = 1;
            [self updateModel];
            [self.tableView reloadData];
        }
    }
}


- (void)updateModel {
    
    __weak LeagueAllMatchesTableViewController *weakSelf = self;
    
    [self.footballDataApi getAllLeagueMatcheswithId:self.leagueId withMatchDay:self.leagueMatchDay completionBlock:^(NSDictionary * leagueMatches , NSError * error) {
        
        [NSOperationQueue.mainQueue addOperationWithBlock:^{
            
            if (error) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                [alertController addAction:action];
                [weakSelf presentViewController:alertController animated:YES completion:nil];
            } else {
                weakSelf.leagueMatches = leagueMatches;
            }
            
            [weakSelf.refreshControl endRefreshing];
        }];
        
    }];
    
}

- (void)setLeagueMatches:(NSDictionary *)leagueMatches{
    _leagueMatches = leagueMatches;
    [self.tableView reloadData];
    
}

-(IBAction)newMatchDay:(id)sender{
    self.leagueMatchDay = @(self.matchDayStepper.value);
    [self updateModel];
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.leagueMatches allKeys] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    Match *match = [self.leagueMatches allValues][0];
    return [NSString stringWithFormat:@"Match Day %@",match.matchDay];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LeagueMatchDayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"matchDayCell" forIndexPath:indexPath];
    
    Match *match = [self.leagueMatches allValues][indexPath.row];
    cell.matchDate.text = [NSString stringWithFormat:@"%@ %@",[match.kickOffHour substringWithRange:NSMakeRange(0, 10)],[match.kickOffHour substringWithRange:NSMakeRange(11,5)]];
    cell.homeTeam.text = match.homeTeam;
    cell.awayTeam.text = match.awayTeam;
    if([match.goalsAwayTeam isKindOfClass:[NSNull class]]){
        cell.matchResult.text = [NSString stringWithFormat:@"- x -"];
    }else{
        cell.matchResult.text = [NSString stringWithFormat:@"%@ x %@",match.goalshomeTeam,match.goalsAwayTeam];
    }
    if([FavoritesManager isFavoriteWithName:match.homeTeam]){
        cell.homeTeam.textColor = UIColor.redColor;
    }
    if([FavoritesManager isFavoriteWithName:match.awayTeam]){
        cell.awayTeam.textColor = UIColor.redColor;
    }
    cell.matchStatus.text = match.matchStatus;
    [self.tableView setRowHeight:90];
    return cell;
}

@end
