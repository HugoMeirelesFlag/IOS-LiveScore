//
//  ClubGamesTableViewController.m
//  ProjetoFinal_HugoMeireles
//
//  Created by Hugo Meireles on 13/05/2019.
//  Copyright © 2019 Hugo Meireles. All rights reserved.
//

#import "TeamMatchesTableViewController.h"
#import "TeamMatchTableViewCell.h"
#import "FootballDataAPI.h"
#import "Match.h"
#import "FavoritesManager.h"

@interface TeamMatchesTableViewController ()

@property (strong,nonatomic) NSDictionary *teamMatches;
@property (strong,nonatomic) FootballDataAPI *footballDataApi;

@end

@implementation TeamMatchesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.footballDataApi = [FootballDataAPI new];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self updateModel];
}


- (void)updateModel {
    
    __weak TeamMatchesTableViewController *weakSelf = self;
    
    [self.footballDataApi getAllTeamMatcheswithId:self.teamId completionBlock:^(NSDictionary * teamGames , NSError * error) {
        
        [NSOperationQueue.mainQueue addOperationWithBlock:^{
            
            if (error) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                [alertController addAction:action];
                [weakSelf presentViewController:alertController animated:YES completion:nil];
            } else {
                weakSelf.teamMatches = teamGames;
            }
            
            [weakSelf.refreshControl endRefreshing];
        }];
        
    }];
    
}

- (void)setTeamMatches:(NSDictionary *)teamMatches{
    _teamMatches = teamMatches;
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.teamMatches allKeys] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.teamMatches allValues][section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [self.teamMatches allKeys][section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TeamMatchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"teamMatchCell" forIndexPath:indexPath];
    Match *match = [self.teamMatches allValues][indexPath.section][indexPath.row];
    cell.teamMatchDate.text = [match.kickOffHour substringWithRange:NSMakeRange(0, 10)];
    NSString *homeOrAway;
    if([match.goalsAwayTeam isKindOfClass:[NSNull class]]){
        homeOrAway = [NSString stringWithFormat:@"- x -"];
        //[self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }else{
        homeOrAway = [NSString stringWithFormat:@"%d - %d",match.goalshomeTeam.intValue,match.goalsAwayTeam.intValue];
    }
    if([match.homeTeam isEqualToString:self.teamName]){
        cell.opposingTeam.text = match.awayTeam;
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:homeOrAway];
        [text addAttribute:NSFontAttributeName
                     value:[UIFont boldSystemFontOfSize:18]
                     range:NSMakeRange(0, 1)];
        cell.matchResult.attributedText = text;
    }else{
        cell.opposingTeam.text = match.homeTeam;
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:homeOrAway];
        [text addAttribute:NSFontAttributeName
                     value:[UIFont boldSystemFontOfSize:18]
                     range:NSMakeRange(4, 1)];
        cell.matchResult.attributedText = text;
    }
    
    if([FavoritesManager isFavoriteWithName:cell.opposingTeam.text]){
        cell.opposingTeam.textColor = UIColor.redColor;
    }
    
    return cell;
}

@end
