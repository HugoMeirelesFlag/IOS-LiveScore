//
//  LeagueTableViewController.m
//  ProjetoFinal_HugoMeireles
//
//  Created by Hugo Meireles on 03/05/2019.
//  Copyright © 2019 Hugo Meireles. All rights reserved.
//

#import "LeagueTableViewController.h"
#import "LeaguePosition.h"
#import "FootballDataAPI.h"
#import "LeaguePositionTableViewCell.h"
#import "FavoritesManager.h"
#import "TeamMatchesTableViewController.h"

@interface LeagueTableViewController ()

@property (strong,nonatomic) NSDictionary *leaguePositions;

@property (strong, nonatomic) FootballDataAPI *footballDataApi;


@end

@implementation LeagueTableViewController

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
    [self updateModel];
}

- (void)updateModel {
    
    __weak LeagueTableViewController *weakSelf = self;
    
    [self.footballDataApi getAllLeaguePositionsForCompetitionWithId:self.leagueId completionBlock:^(NSDictionary * leaguePositions,NSError * error) {
        
        [NSOperationQueue.mainQueue addOperationWithBlock:^{
            
            if (error) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                [alertController addAction:action];
                [weakSelf presentViewController:alertController animated:YES completion:nil];
            } else {
                weakSelf.leaguePositions = leaguePositions;
            }
            
            [weakSelf.refreshControl endRefreshing];
        }];
        
    }];
    
}

- (void)setLeaguePositions:(NSDictionary *)leaguePositions{
    _leaguePositions = leaguePositions;
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.leaguePositions allKeys] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"   P   |    N    |   JG   |   V   |  E  |  D  |  GM  |  GS  |  PS  "];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LeaguePositionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"teamCell" forIndexPath:indexPath];
    
    NSNumber *current = @(indexPath.row + 1);
    LeaguePosition *team = [self.leaguePositions objectForKey:current];
    cell.teamPosition.text = [NSString stringWithFormat:@"%@",team.teamPosition];
    cell.teamName.text = team.teamName;
    cell.teamPlayedGames.text = [NSString stringWithFormat:@"%@",team.teamPlayedGames];
    cell.teamWon.text = [NSString stringWithFormat:@"%@",team.teamWon];
    cell.teamDraw.text = [NSString stringWithFormat:@"%@",team.teamDraw];
    cell.teamLost.text = [NSString stringWithFormat:@"%@",team.teamLost];
    cell.teamGoalsFor.text = [NSString stringWithFormat:@"%@",team.teamGoalsFor];
    cell.teamGoalsAgainst.text = [NSString stringWithFormat:@"%@",team.teamGoalsAgainst];
    cell.teamPoints.text = [NSString stringWithFormat:@"%@",team.teamPoints];
    if([FavoritesManager isFavorite:team.teamId]){
        cell.teamName.textColor = UIColor.redColor;
    }else{
        cell.teamName.textColor = UIColor.blackColor;
    }
    if([cell.teamName.text isEqualToString:self.homeTeam] || [cell.teamName.text isEqualToString:self.awayTeam]){
        cell.backgroundColor = UIColor.yellowColor;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSNumber *current = @(indexPath.row + 1);
    LeaguePosition *team = [self.leaguePositions objectForKey:current];
    [self showAlert:team League:self.leagueName];
}

- (void)showAlert:(LeaguePosition *)team League:(NSString *)teamLeague {
    NSString *msg;
    if(![FavoritesManager isFavorite:team.teamId]){
        msg = [NSString stringWithFormat:@"Adicionar!"];
    }else{
        msg = [NSString stringWithFormat:@"Remover!"];
    }
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Opçoes!" message:@"Seleccione a oppçao que deseja. Adicionar/Remover a/de Favoritos ou ver lista de jogos." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:msg style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if(![FavoritesManager isFavorite:team.teamId]){
            [FavoritesManager createFavoriteWithTeamId:team.teamId TeamName:team.teamName WithTeamCompetition:teamLeague];
            
            [self.tableView reloadData];
        }else{
            [FavoritesManager deleteFavorite:team.teamId];
            
            [self.tableView reloadData];
        }
        
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"Ver Jogos" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self performSegueWithIdentifier:@"goToClubGames" sender:team];
        
    }];
    
    [alertController addAction:action1];
    [alertController addAction:action2];
    [alertController addAction:action3];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.destinationViewController isKindOfClass:TeamMatchesTableViewController.class]){
        LeaguePosition *leaguePosition = sender;
        TeamMatchesTableViewController *clubvc = segue.destinationViewController;
        clubvc.teamId = leaguePosition.teamId;
        clubvc.teamName = leaguePosition.teamName;
        clubvc.title= leaguePosition.teamName;
    }
}

@end
