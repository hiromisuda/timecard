import RealmSwift
import Foundation

class TimeModel : Object{
    @objc dynamic var id: Int = 0
    @objc dynamic var date: String = "" //削除
    @objc dynamic var task: String = ""//同じタスク名でマージする
    @objc dynamic var hhStart: String = "" //削除
    @objc dynamic var mmStart: String = "" //削除
    @objc dynamic var hhEnd: String = "" //削除
    @objc dynamic var mmEnd: String = "" //削除
    
    @objc dynamic var startDate: Date? = nil //日本時間に変換が必要
    @objc dynamic var endDate: Date? = nil //日本時間に変換が必要
    @objc dynamic var total: String = "" //総労働時間（自動的に登録したい）
    var lunchTimes = List<LunchTimeModel>()

    override static func primaryKey() -> String? {
        return "id"
    }
    
}

class LunchTimeModel : Object{
    @objc dynamic var startDate: Date? = nil //日本時間に変換が必要
    @objc dynamic var endDate: Date? = nil //日本時間に変換が必要
}
