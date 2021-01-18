//
//  TTWork.swift
//  TTProduct
//
//  Created by Toj on 1/14/21.
//

public struct TTWork: TTJSONCodable {
    public init() { }
    var workPage: TTWorkPage?
    var freeCodeList:[TTWorkFreeCode]?
}

public struct TTWorkPage: TTJSONCodable {
    public init() { }
    /// 总数量
    var total : Int = 0
    /// 当前页
    var pageNum: Int = 0
    // 当前页的数量
    var pageSize: Int = 0
    var list: [WorkModel]?
}

public struct TTWorkFreeCode: TTJSONCodable {
    public init() { }
    var url: String = ""
    var name: String = ""
    var imgUrl: String = ""
}

public struct WorkModel: TTJSONCodable {
    public init() { }
    var workType: Int = 0
    var icon: String = ""
    var lastUpdateTime: Int = 0
    var workName: String = ""
    var lessonTimeName: String = ""
    var workViewUrl: String = ""
    var workUpdateUrl: String = ""
}
