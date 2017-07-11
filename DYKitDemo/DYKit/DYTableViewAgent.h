//
//  DYTableViewDataSouce.h
//  DYMVVMRAC
//
//  Created by DuYe on 2017/7/7.
//  Copyright © 2017年 DuYe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYTableViewCellViewModelProtocol.h"

#define DY_DEFAULT_ID @"UITableViewCell"

#ifndef DYSYNTH_DYNAMIC_PROPERTY_OBJECT
#define DYSYNTH_DYNAMIC_PROPERTY_OBJECT(_getter_, _setter_, _association_, _type_) \
- (void)_setter_ : (_type_)object { \
[self willChangeValueForKey:@#_getter_]; \
objc_setAssociatedObject(self, _cmd, object, OBJC_ASSOCIATION_ ## _association_); \
[self didChangeValueForKey:@#_getter_]; \
} \
- (_type_)_getter_ { \
return objc_getAssociatedObject(self, @selector(_setter_:)); \
}
#endif

@interface DYTableViewAgent : NSObject <UITableViewDataSource,UITableViewDelegate>

typedef void(^CellBindBlock)(id cell,id viewModel,NSIndexPath *indexPath);
@property (nonatomic, copy) NSArray *data;
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) CellBindBlock cellBindBlock;


typedef CGFloat (^CGFloatTableViewIndexPath)(UITableView *tableView,NSIndexPath *indexPath);
@property (nonatomic, copy) CGFloatTableViewIndexPath heightForRowAtIndexPath;
@property (nonatomic, copy) CGFloatTableViewIndexPath estimatedHeightForRowAtIndexPath;

typedef CGFloat (^CGFloatTableViewNSInteger)(UITableView *tableView,NSInteger section);
@property (nonatomic, copy) CGFloatTableViewNSInteger heightForHeaderInSection;
@property (nonatomic, copy) CGFloatTableViewNSInteger heightForFooterInSection;
//@property (nonatomic, copy) CGFloatTableViewNSInteger estimatedHeightForHeaderInSection;
//@property (nonatomic, copy) CGFloatTableViewNSInteger estimatedHeightForFooterInSection;

typedef NSArray<UITableViewRowAction *> *(^EditActionsForRowAtIndexPath)(UITableView *tableView,NSIndexPath *indexPath);
@property (nonatomic, copy) EditActionsForRowAtIndexPath editActionsForRowAtIndexPath;

typedef BOOL (^BOOLTableViewIndexPath)(UITableView *tableView,NSIndexPath *indexPath);
@property (nonatomic, copy) BOOLTableViewIndexPath shouldHighlightRowAtIndexPath;
@property (nonatomic, copy) BOOLTableViewIndexPath canEditRowAtIndexPath;
@property (nonatomic, copy) BOOLTableViewIndexPath shouldIndentWhileEditingRowAtIndexPath;
@property (nonatomic, copy) BOOLTableViewIndexPath shouldShowMenuForRowAtIndexPath;
@property (nonatomic, copy) BOOLTableViewIndexPath canFocusRowAtIndexPath;

typedef NSInteger (^NSIntegerTableViewIndexPath)(UITableView *tableView,NSInteger section);
@property (nonatomic, copy) NSIntegerTableViewIndexPath numberOfRowsInSection;

typedef UITableViewCell *(^UITableViewCellTableViewIndexPath)(UITableView *tableView,NSIndexPath *indexPath);
@property (nonatomic, copy) UITableViewCellTableViewIndexPath cellForRowAtIndexPath;

typedef NSInteger (^NSIntegerUITableView)(UITableView *tableView);
@property (nonatomic, copy) NSIntegerUITableView numberOfSectionsInTableView;

typedef NSString *(^NSStringTableViewNSInteger)(UITableView *tableView,NSInteger section);
@property (nonatomic, copy) NSStringTableViewNSInteger titleForHeaderInSection;
@property (nonatomic, copy) NSStringTableViewNSInteger titleForFooterInSection;


@property (nonatomic, copy) BOOLTableViewIndexPath canMoveRowAtIndexPath;

typedef NSArray<NSString *> *(^SectionIndexTitlesForTableView)(UITableView *tableView);
@property (nonatomic, copy) SectionIndexTitlesForTableView sectionIndexTitlesForTableView;

typedef NSInteger (^NSIntegerUITableViewNSStringNSInteger)(UITableView *tableView,NSString *title,NSInteger index);
@property (nonatomic, copy) NSIntegerUITableViewNSStringNSInteger sectionForSectionIndexTitle;

typedef UIView *(^UIViewTableViewNSInteger)(UITableView *tableView,NSInteger section);
@property (nonatomic, copy) UIViewTableViewNSInteger viewForHeaderInSection;
@property (nonatomic, copy) UIViewTableViewNSInteger viewForFooterInSection;

typedef NSIndexPath *(^NSIndexPathUITableViewNSIndexPath)(UITableView *tableView,NSIndexPath *indexPath);
@property (nonatomic, copy) NSIndexPathUITableViewNSIndexPath willSelectRowAtIndexPath;
@property (nonatomic, copy) NSIndexPathUITableViewNSIndexPath willDeselectRowAtIndexPath;

typedef UITableViewCellEditingStyle (^UITableViewCellEditingStyleUITableViewNSIndexPath)(UITableView *tableView,NSIndexPath *indexPath);
@property (nonatomic, copy) UITableViewCellEditingStyleUITableViewNSIndexPath editingStyleForRowAtIndexPath;

typedef NSString *(^NSStringTableViewIndexPath)(UITableView *tableView,NSIndexPath *indexPath);
@property (nonatomic, copy) NSStringTableViewIndexPath titleForDeleteConfirmationButtonForRowAtIndexPath;


typedef NSIndexPath *(^NSIndexPathUITableViewNSIndexPathNSIndexPath)(UITableView *tableView,NSIndexPath *sourceIndexPath,NSIndexPath *proposedDestinationIndexPath);
@property (nonatomic, copy) NSIndexPathUITableViewNSIndexPathNSIndexPath targetIndexPathForMoveFromRowAtIndexPath;

typedef NSInteger (^NSIntegerUITableViewNSIndexPath)(UITableView *tableView,NSIndexPath *indexPath);
@property (nonatomic, copy) NSIntegerUITableViewNSIndexPath indentationLevelForRowAtIndexPath;

typedef BOOL (^BOOLUITableViewSELNSIndexPath)(UITableView *tableView,SEL action,NSIndexPath *indexPath);
@property (nonatomic, copy) BOOLUITableViewSELNSIndexPath canPerformAction;

typedef BOOL (^BOOLUITableViewFocusUpdateContext)(UITableView *tableView,UITableViewFocusUpdateContext *context);
@property (nonatomic, copy) BOOLUITableViewFocusUpdateContext shouldUpdateFocusInContext;

typedef NSIndexPath *(^NSIndexPathUITableView)(UITableView *tableView);
@property (nonatomic, copy) NSIndexPathUITableView indexPathForPreferredFocusedViewInTableView;

@end