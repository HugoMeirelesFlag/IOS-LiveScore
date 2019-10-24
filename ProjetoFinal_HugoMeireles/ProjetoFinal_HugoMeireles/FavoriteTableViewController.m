//
//  FavoriteTableViewController.m
//  ProjetoFinal_HugoMeireles
//
//  Created by Hugo Meireles on 11/05/2019.
//  Copyright © 2019 Hugo Meireles. All rights reserved.
//

#import "FavoriteTableViewController.h"
#import "FavoriteTableViewCell.h"
#import "FavoritesManager.h"
#import "TeamMatchesTableViewController.h"

@interface FavoriteTableViewController ()

@property (strong, nonatomic) NSArray <FavoriteMO *> *favorites;

@end

@implementation FavoriteTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Meus Favoritos";
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.favorites = [FavoritesManager allFavorites];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.favorites.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FavoriteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"favoriteCell" forIndexPath:indexPath];
    
    FavoriteMO *favorite = self.favorites[indexPath.row];
    int teamid = favorite.teamId;
    cell.teamId.text = [NSString stringWithFormat:@"%d",teamid];
    cell.teamName.text = favorite.teamName;
    cell.competitionName.text = favorite.competitionName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FavoriteMO *favorite = self.favorites[indexPath.row];
    [self showAlert:favorite];
}

- (void)showAlert:(FavoriteMO *)favorite{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alerta!" message:@"Pretende remover de favoritos ou ver jogos do clube?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Remover" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSNumber *teamId = @(favorite.teamId);
        [FavoritesManager deleteFavorite:teamId];
        [self.tableView reloadData];
        
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"Ver Jogos" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self performSegueWithIdentifier:@"goToClubGames" sender:favorite];
        
    }];
    
    [alertController addAction:action1];
    [alertController addAction:action2];
    [alertController addAction:action3];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.destinationViewController isKindOfClass:TeamMatchesTableViewController.class]){
        FavoriteMO *favorite = sender;
        TeamMatchesTableViewController *clubvc = segue.destinationViewController;
        clubvc.teamId = @(favorite.teamId);
        clubvc.teamName = favorite.teamName;
        clubvc.title = favorite.teamName;
    }
}


@end
