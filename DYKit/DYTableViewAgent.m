//
//  DYTableViewDataSouce.m
//  DYMVVMRAC
//
//  Created by DuYe on 2017/7/7.
//  Copyright © 2017年 DuYe. All rights reserved.
//

#import "DYTableViewAgent.h"

@implementation DYTableViewAgent

#pragma 过时的代理方法
//- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath NS_DEPRECATED_IOS(2_0, 3_0) __TVOS_PROHIBITED{}

#pragma dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.numberOfRowsInSection ? self.numberOfRowsInSection(tableView,section) : (self.data ? self.data.count : 0);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.cellForRowAtIndexPath) {
        return self.cellForRowAtIndexPath(tableView,indexPath);
    } else {
        NSString *cellIdentifier;
        if ([self.data[indexPath.row] conformsToProtocol:@protocol(DYTableViewCellViewModelProtocol)]) {
            id<DYTableViewCellViewModelProtocol> viewModel = self.data[indexPath.row];
            cellIdentifier = viewModel.cellIdentifier;
        } else {
            cellIdentifier = self.identifier ? self.identifier : DY_DEFAULT_ID;
        }
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        self.cellBindBlock(cell, self.data[indexPath.row], indexPath);
        return cell;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.numberOfSectionsInTableView ? self.numberOfSectionsInTableView(tableView) : 1;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.canEditRowAtIndexPath ? self.canEditRowAtIndexPath(tableView, indexPath) : (self.editActionsForRowAtIndexPath ? YES : NO);
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.titleForHeaderInSection ? self.titleForHeaderInSection(tableView,section) : nil;
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return self.titleForFooterInSection ? self.titleForFooterInSection(tableView,section) : nil;
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.canMoveRowAtIndexPath ? self.canMoveRowAtIndexPath(tableView,indexPath) : NO;
}
- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.sectionIndexTitlesForTableView ? self.sectionIndexTitlesForTableView(tableView) : nil;
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return self.sectionForSectionIndexTitle ? self.sectionForSectionIndexTitle(tableView,title,index) : 0;
}


#pragma delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.heightForRowAtIndexPath ? self.heightForRowAtIndexPath(tableView, indexPath) : tableView.rowHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return self.heightForHeaderInSection ? self.heightForHeaderInSection(tableView,section) : tableView.sectionHeaderHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return self.heightForFooterInSection ? self.heightForFooterInSection(tableView,section) : tableView.sectionFooterHeight;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(7_0){
    return self.estimatedHeightForRowAtIndexPath ? self.estimatedHeightForRowAtIndexPath(tableView,indexPath) : tableView.estimatedRowHeight;
}
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section NS_AVAILABLE_IOS(7_0){
//    return self.estimatedHeightForHeaderInSection ? self.estimatedHeightForHeaderInSection(tableView,section) : tableView.estimatedSectionHeaderHeight;
//}
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section NS_AVAILABLE_IOS(7_0){
//    return self.estimatedHeightForFooterInSection ? self.estimatedHeightForFooterInSection(tableView,section) : tableView.estimatedSectionFooterHeight;
//}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.viewForHeaderInSection ? self.viewForHeaderInSection(tableView,section) : nil;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return self.viewForFooterInSection ? self.viewForFooterInSection(tableView,section) : nil;
}
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(6_0){
    return self.shouldHighlightRowAtIndexPath ? self.shouldHighlightRowAtIndexPath(tableView,indexPath) : YES;
}
- (nullable NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.willSelectRowAtIndexPath ? self.willSelectRowAtIndexPath(tableView,indexPath) : indexPath;
}
- (nullable NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0){
    return self.willDeselectRowAtIndexPath ? self.willDeselectRowAtIndexPath(tableView,indexPath) : indexPath;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self tableView:tableView canEditRowAtIndexPath:indexPath]) {
        return self.editingStyleForRowAtIndexPath ? self.editingStyleForRowAtIndexPath(tableView,indexPath) : UITableViewCellEditingStyleDelete;
    } else {return UITableViewCellEditingStyleNone;}
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0) __TVOS_PROHIBITED{
    return self.titleForDeleteConfirmationButtonForRowAtIndexPath ? self.titleForDeleteConfirmationButtonForRowAtIndexPath(tableView,indexPath) : nil;
}
- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(8_0) __TVOS_PROHIBITED{
    if (self.editActionsForRowAtIndexPath) {
        self.canEditRowAtIndexPath = ^BOOL(UITableView *tableView, NSIndexPath *indexPath) {return YES;};
        return self.editActionsForRowAtIndexPath(tableView,indexPath);
    } else {return nil;}
}
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.shouldIndentWhileEditingRowAtIndexPath ? self.shouldIndentWhileEditingRowAtIndexPath(tableView,indexPath) : YES;
}
- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath{
    return self.targetIndexPathForMoveFromRowAtIndexPath ? self.targetIndexPathForMoveFromRowAtIndexPath(tableView,sourceIndexPath,proposedDestinationIndexPath) : proposedDestinationIndexPath;
}
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.indentationLevelForRowAtIndexPath ? self.indentationLevelForRowAtIndexPath(tableView,indexPath) : 0;
}
- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(5_0){
    return self.shouldShowMenuForRowAtIndexPath ? self.shouldShowMenuForRowAtIndexPath(tableView,indexPath) : NO;
}
- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender NS_AVAILABLE_IOS(5_0){
    return self.canPerformAction ? self.canPerformAction(tableView,action,indexPath) : NO;
}
- (BOOL)tableView:(UITableView *)tableView canFocusRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(9_0){
    return self.canFocusRowAtIndexPath ? self.canFocusRowAtIndexPath(tableView,indexPath) : NO;
}
- (BOOL)tableView:(UITableView *)tableView shouldUpdateFocusInContext:(UITableViewFocusUpdateContext *)context NS_AVAILABLE_IOS(9_0){
    return self.shouldUpdateFocusInContext ? self.shouldUpdateFocusInContext(tableView,context) : NO;
}
- (nullable NSIndexPath *)indexPathForPreferredFocusedViewInTableView:(UITableView *)tableView NS_AVAILABLE_IOS(9_0){
    return self.indexPathForPreferredFocusedViewInTableView ? self.indexPathForPreferredFocusedViewInTableView(tableView) : nil;
}


- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{}
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath NS_AVAILABLE_IOS(6_0){}
- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0){}
- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0){}
- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(6_0){}
- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(6_0){}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0){}
- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(nullable NSIndexPath *)indexPath __TVOS_PROHIBITED{}
- (void)tableView:(UITableView *)tableView didUpdateFocusInContext:(UITableViewFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator NS_AVAILABLE_IOS(9_0){}
- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender NS_AVAILABLE_IOS(5_0){}
- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath __TVOS_PROHIBITED{}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0){}
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0){}


@end