//
//  GameTableViewCell.h
//  ProjetoFinal_HugoMeireles
//
//  Created by Hugo Meireles on 03/05/2019.
//  Copyright © 2019 Hugo Meireles. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MatchTableViewCell : UITableViewCell
@property (strong,nonatomic) IBOutlet UILabel *kickOffHour;
@property (strong,nonatomic) IBOutlet UILabel *homeTeam;
@property (strong,nonatomic) IBOutlet UILabel *awayTeam;
@property (strong,nonatomic) IBOutlet UILabel *matchResult;
@property (strong,nonatomic) IBOutlet UILabel *matchStatus;
@end

NS_ASSUME_NONNULL_END
