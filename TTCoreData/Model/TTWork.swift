//
//  TTWork.swift
//  TTProduct
//
//  Created by Toj on 1/14/21.
//

public struct TTWork: TTJSONCodable {
    public init() { }
    public var workPage: TTWorkPage?
    public var freeCodeList:[TTWorkFreeCode]?
}

public struct TTWorkPage: TTJSONCodable {
    public init() { }
    /// 总数量
    public var total : Int = 0
    /// 当前页
    public var pageNum: Int = 0
    // 当前页的数量
    public var pageSize: Int = 0
    public var list: [WorkModel]?
}

public struct TTWorkFreeCode: TTJSONCodable {
    public init() { }
    public var url: String = ""
    public var name: String = ""
    public var imgUrl: String = ""
}

public struct WorkModel: TTJSONCodable {
    public init() { }
    public var workType: Int = 0
    public var icon: String = ""
    public var lastUpdateTime: Int = 0
    public var workName: String = ""
    public var lessonTimeName: String = ""
    public var workViewUrl: String = ""
    public var workUpdateUrl: String = ""
}
