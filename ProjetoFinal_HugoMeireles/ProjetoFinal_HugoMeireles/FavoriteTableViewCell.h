//
//  FavoriteTableViewCell.h
//  ProjetoFinal_HugoMeireles
//
//  Created by Hugo Meireles on 11/05/2019.
//  Copyright © 2019 Hugo Meireles. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FavoriteTableViewCell : UITableViewCell

@property (strong,nonatomic) IBOutlet UILabel *teamId;
@property (strong,nonatomic) IBOutlet UILabel *teamName;
@property (strong,nonatomic) IBOutlet UILabel *competitionName;

@end

NS_ASSUME_NONNULL_END
