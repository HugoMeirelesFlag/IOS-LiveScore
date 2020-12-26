//
//  ClubGameTableViewCell.h
//  ProjetoFinal_HugoMeireles
//
//  Created by Hugo Meireles on 13/05/2019.
//  Copyright © 2019 Hugo Meireles. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TeamMatchTableViewCell : UITableViewCell

@property (strong,nonatomic) IBOutlet UILabel *teamMatchDate;
@property (strong,nonatomic) IBOutlet UILabel *opposingTeam;
@property (strong,nonatomic) IBOutlet UILabel *matchResult;

@end

NS_ASSUME_NONNULL_END
