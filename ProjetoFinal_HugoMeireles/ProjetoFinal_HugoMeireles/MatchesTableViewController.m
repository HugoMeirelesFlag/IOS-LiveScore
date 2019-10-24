//
//  MatchesTableViewController.m
//  ProjetoFinal_HugoMeireles
//
//  Created by Hugo Meireles on 03/05/2019.
//  Copyright © 2019 Hugo Meireles. All rights reserved.
//

#import "MatchesTableViewController.h"
#import "Match.h"
#import "FootballDataAPI.h"
#import "MatchTableViewCell.h"
#import "LeagueTableViewController.h"
#import "FavoritesManager.h"

@interface MatchesTableViewController ()

@property (strong,nonatomic) IBOutlet UIDatePicker *MatchDatePicker;
@property (strong,nonatomic) IBOutlet UISwitch *inPlaySwitch;


@property (strong,nonatomic) NSDictionary *leagueAndMatches;
@property (strong,nonatomic) NSArray *sortleagueAndMatches;
@property (strong,nonatomic) NSDate *matchDay;
@property (strong, nonatomic) FootballDataAPI *footballDataApi;

@end

@implementation MatchesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.footballDataApi = [FootballDataAPI new];
    if(!self.matchDay){
        self.matchDay = [NSDate date];
    }
    [self.MatchDatePicker  setDate:self.matchDay];
    self.title = @"Football APP";
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tableView.contentOffset = CGPointMake(0, -self.refreshControl.frame.size.height);
    [self.refreshControl beginRefreshing];
    [self updateModel];
}

- (void)updateModel {

    __weak MatchesTableViewController *weakSelf = self;
    
    [self.footballDataApi getAllMatchesOfTheDay:self.inPlaySwitch.isOn dayOfMatch:self.matchDay completionBlock:^(NSDictionary * leagueAndMatches , NSError * error) {
        
        [NSOperationQueue.mainQueue addOperationWithBlock:^{
            
            if (error) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                [alertController addAction:action];
                [weakSelf presentViewController:alertController animated:YES completion:nil];
            } else {
                weakSelf.leagueAndMatches = leagueAndMatches;
                weakSelf.sortleagueAndMatches = [self sortedLeagueAndMatch];
            }
            
            [weakSelf.refreshControl endRefreshing];
        }];
        
    }];
    
}

- (void)setLeagueAndMatches:(NSDictionary *)leagueAndMatches{
    _leagueAndMatches = leagueAndMatches;
    [self.tableView reloadData];
}

- (void)setSortleagueAndMatches:(NSArray *)sortleagueAndMatches{
    _sortleagueAndMatches = sortleagueAndMatches;
    [self.tableView reloadData];
}

-(NSArray *)sortedLeagueAndMatch{
    NSMutableArray *temp = [NSMutableArray new];;
    
    for(NSArray *league in [self.leagueAndMatches allValues]){
        Match *match = league[0];
        if([FavoritesManager isFavoriteWithCompetition:match.matchCompetion]){
            [temp insertObject:league atIndex:0];
        }else{
            [temp addObject:league];
        }
    }
    return temp;
}

-(IBAction)newDate:(id)sender{
    self.matchDay = [self.MatchDatePicker date];
    [self updateModel];
}

- (IBAction)refresh:(UIRefreshControl *)sender {
    
    if (sender.isRefreshing) {
        [self updateModel];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.sortleagueAndMatches count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.sortleagueAndMatches[section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    Match *match = self.sortleagueAndMatches[section][0];
    return match.matchCompetion;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MatchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"matchCell" forIndexPath:indexPath];
    Match *match = self.sortleagueAndMatches[indexPath.section][indexPath.row];
    if([FavoritesManager isFavoriteWithName:match.homeTeam] || [FavoritesManager isFavoriteWithName:match.awayTeam]){
        [tableView beginUpdates];
        [tableView moveRowAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.section]];
        [tableView endUpdates];
    }
    cell.kickOffHour.text = [match.kickOffHour substringWithRange:NSMakeRange(11, 5)];
    cell.homeTeam.text = match.homeTeam;
    cell.awayTeam.text = match.awayTeam;
    if([FavoritesManager isFavoriteWithName:match.homeTeam]){
        cell.homeTeam.textColor = UIColor.redColor;
    }
    if([FavoritesManager isFavoriteWithName:match.awayTeam]){
        cell.awayTeam.textColor = UIColor.redColor;
    }
    if([match.goalsAwayTeam isKindOfClass:[NSNull class]]){
        cell.matchResult.text = [NSString stringWithFormat:@"- x -"];
    }else{
        cell.matchResult.text = [NSString stringWithFormat:@"%@ x %@",match.goalshomeTeam,match.goalsAwayTeam];
    }
    
    cell.matchStatus.text = match.matchStatus;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Match *match = self.sortleagueAndMatches[indexPath.section][indexPath.row];
    [self performSegueWithIdentifier:@"goToLeague" sender:match];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.destinationViewController isKindOfClass:LeagueTableViewController.class]){
        LeagueTableViewController *leagueTablevc = segue.destinationViewController;
        Match *match = sender;
        leagueTablevc.leagueId = match.matchCompetionId;
        leagueTablevc.leagueName = match.matchCompetion;
        leagueTablevc.title = match.matchCompetion;
        leagueTablevc.homeTeam = match.homeTeam;
        leagueTablevc.awayTeam = match.awayTeam;
    }
}

@end
