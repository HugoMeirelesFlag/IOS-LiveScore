//
//  LeaguePositionTableViewCell.h
//  ProjetoFinal_HugoMeireles
//
//  Created by Hugo Meireles on 03/05/2019.
//  Copyright © 2019 Hugo Meireles. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LeaguePositionTableViewCell : UITableViewCell
@property (strong,nonatomic) IBOutlet UILabel *teamPosition;
@property (strong,nonatomic) IBOutlet UILabel *teamName;
@property (strong,nonatomic) IBOutlet UILabel *teamPoints;
@property (strong,nonatomic) IBOutlet UILabel *teamPlayedGames;
@property (strong,nonatomic) IBOutlet UILabel *teamWon;
@property (strong,nonatomic) IBOutlet UILabel *teamDraw;
@property (strong,nonatomic) IBOutlet UILabel *teamLost;
@property (strong,nonatomic) IBOutlet UILabel *teamGoalsFor;
@property (strong,nonatomic) IBOutlet UILabel *teamGoalsAgainst;
@end

NS_ASSUME_NONNULL_END
