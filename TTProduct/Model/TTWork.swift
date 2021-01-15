//
//  TTWork.swift
//  TTProduct
//
//  Created by Toj on 1/14/21.
//

struct TTWork: TTJSONCodable {
    var workPage: TTWorkPage?
    var freeCodeList:[TTWorkFreeCode]?
}

struct TTWorkPage: TTJSONCodable {
    /// 总数量
    var total : Int = 0
    /// 当前页
    var pageNum: Int = 0
    // 当前页的数量
    var pageSize: Int = 0
    var list: [WorkModel]?
}

struct TTWorkFreeCode: TTJSONCodable {
    var url: String = ""
    var name: String = ""
    var imgUrl: String = ""
}

struct WorkModel: TTJSONCodable {
    var workType: Int = 0
    var icon: String = ""
    var lastUpdateTime: Int = 0
    var workName: String = ""
    var lessonTimeName: String = ""
    var workViewUrl: String = ""
    var workUpdateUrl: String = ""
}
