//
//  Git.swift
//  Documentation
//
//  Created by Toj on 1/24/21.
//  Git branch
//  Git模型参考: https://nvie.com/posts/a-successful-git-branching-model
//

// MARK: - 第一种
// MARK: 1. 分支说明
/*
 1.1 master : 线上发布最新分支.
 说明: 线上分支, 禁止所有developer向该分支做push动作, 其不需要合并到任何分支.
 来源: 无来源, 根分支.
 目的: 无去向.
 规范: master
 eg : master
 
 1.2 develop: 开发最稳定分支, 接近master分支. 可以随时创建feature分支
 说明: 与master并行的分支，其不需要合并到任何分支.
 来源: master分支.
 目的: 无去向.
 规范: develop/ dev
 eg : dev
 
 1.3 feature: 新功能分支
 说明: 从develop创建新功能的分支.
 来源: develop分支.
 目的: develop分支.
 规范: branch-name-feature
 eg:  branch-tt-plugin
 
 1.4 release: 提测分支
 说明: 接近发布版本时拉出来的分支. 以后需要修改的都在该分支修改.
 一旦release分支打出, feature分支就无用了. 可以删除feature分支
 来源: develop分支.
 目的: develop分支和master分支.
 规范: release-featureName-version
 eg : release-plugin-0.9.2
 
 1.5 hotfix : 热更新分支
 说明: 用于线上出现问题及时进行修复.
 来源: master.
 目的: develop分支和master分支.
 规范: hotfix-version
 eg : hotfix-0.9.2.1
 
 1.6 Tag: 标签
 说明: release/ hotfix后用tag, 标记当前分支干什么用的, 上线什么功能. 解决什么bug
 规范: Tag-version
 eg : Tag-0.9.2.
 */
 
 // MARK: 2. 操作流程
 /*
 2.1 如何开发新功能
 2.1.1 从develop分支拉出分的feature分支.
 2.1.2 在feature分支上进行独立开发.
 2.1.3 开发完成后，按实际需求合并到develop分支.
 
 2.2 如何提测发布
 2.2.1 develop分支自测完成达到提测标准后, 从该分支拉出相应的release分支. feature分支废弃
 2.2.2 发提测邮件.
 2.2.3 在release分支修改QA提出的Bug.
 2.2.4 测试完成后, 发布版本.
 2.2.5 将release分支分别合并到develop和master分支, 并在master分支打上相应的Tag.
 
 2.3 hotfix版本
 当发布版本出现问题需要紧急处理时, 从master分支拉出相应的hotfix分支,
 修改发布完后再合并到develop和master分支, 并在master分支打上相应的Tag.
 
 2.4 注意事项
 2.4.1 只能在release/ hotfix分支提交版本号修改.
 */

// MARK: - 第二种, 个人推荐
// * 区别: 在release分支,
// * 好处: 保证develop分支随时切换出新分支, 不影响单一分支上线/ 作废
// MARK: 1. 分支说明
/*
 1.1 master : 线上发布最新分支.
 说明: 线上分支, 禁止所有developer向该分支做push动作, 其不需要合并到任何分支.
 来源: 无来源, 根分支.
 目的: 无去向.
 规范: master
 eg : master
 
 1.2 develop: 开发最稳定分支, 接近master分支. 可以随时创建feature分支, 不合并任何功能分支. 只合并上线(release)分支
 说明: 与master并行的分支，其不需要合并到任何分支.
 来源: master分支.
 目的: 开发完的feature分支
 规范: develop/ dev
 eg : dev
 
 1.3 feature: 开发功能分支
 说明: 新功能创建的分支.
 来源: develop分支.
 合并: 最新的develop分支
 目的: 创建对应的release分支, 然后该分支废弃
 规范: branch-name-feature.
 eg:  branch-tt-plugin.
 
 1.4 release: 提测分支
 说明: 接近发布版本时拉出来的分支.
 一旦该分支打出, 对应的feature分支废弃, 以后任何修改在该分支做改动
 来源: feature分支.
 目的: develop分支和master分支.
 规范: release-version
 eg : release-0.9.2
 
 1.5 hotfix : 热更新分支
 说明: 用于线上出现问题及时进行修复.
 来源: master.
 目的: develop分支和master分支.
 规范: hotfix-version
 eg : hotfix-0.9.2.1
 
 1.6 Tag: 标签
 说明: release/ hotfix后用tag, 标记当前分支干什么用的, 上线什么功能. 解决什么bug
 规范: Tag-version
 eg : Tag-0.9.2.
 */

// MARK: 2. 操作流程
/*
 2.1 如何开发新功能
 2.1.1 从develop分支拉出分的feature分支.
 2.1.2 在feature分支上进行独立开发.
 2.1.3 开发完成后，按实际需求develop合并到该feature分支.
 
 2.2 如何提测发布
 2.2.1 feature分支自测完成达到提测标准后, 从该分支拉出相应的release分支. feature分支废弃
 2.2.2 发提测邮件.
 2.2.3 在release分支修改QA提出的Bug.
 2.2.4 测试完成后, 发布版本.
 2.2.5 将release分支分别合并到develop和master分支, 并在master分支打上相应的Tag.
 
 2.3 hotfix版本
 当发布版本出现问题需要紧急处理时, 从master分支拉出相应的hotfix分支,
 修改发布完后再合并到develop和master分支, 并在master分支打上相应的Tag.
 
 2.4 注意事项
 2.4.1 只能在release/ hotfix分支提交版本号修改.
 */
