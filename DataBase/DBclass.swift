import UIKit
import SQLite3

class DBclass: NSObject {

  static func DML(query:String) -> Bool {
    var status : Bool = false
    
    var dbop : OpaquePointer? = nil
    if sqlite3_open(Utility.databasePath(), &dbop) == SQLITE_OK {
        var stmt : OpaquePointer? = nil
        if sqlite3_prepare_v2(dbop, query, -1, &stmt, nil) == SQLITE_OK{
            sqlite3_step(stmt)
            status = true
            sqlite3_finalize(stmt)
        }
        sqlite3_close(dbop)
    }
        return status
    }
    static func Get_MyCollectionPhotos() -> NSMutableArray {
        let query = "select * from tbl_mycollection_image order by id desc"
        let mainarr = NSMutableArray()
        var dbop :OpaquePointer? = nil
        if sqlite3_open(Utility.databasePath(), &dbop) == SQLITE_OK {
            var stmt : OpaquePointer? = nil
            if sqlite3_prepare_v2(dbop, query, -1, &stmt, nil) == SQLITE_OK{
                while sqlite3_step(stmt) == SQLITE_ROW {
                    
                    let temp = Dataobject()
                    temp.id  = String(cString: sqlite3_column_text(stmt, 0))
                    temp.image = String(cString: sqlite3_column_text(stmt, 1))
                    mainarr.add(temp)
                }
                sqlite3_finalize(stmt)
            }
            sqlite3_close(dbop)
        }
        print(mainarr.count)
        return mainarr
    }
    static func Get_MyCollectionVideo() -> NSMutableArray {
        let query = "select * from tbl_mycollection_video order by id desc"
        let mainarr = NSMutableArray()
        var dbop :OpaquePointer? = nil
        if sqlite3_open(Utility.databasePath(), &dbop) == SQLITE_OK {
            var stmt : OpaquePointer? = nil
            if sqlite3_prepare_v2(dbop, query, -1, &stmt, nil) == SQLITE_OK{
                while sqlite3_step(stmt) == SQLITE_ROW {
                    
                    let temp = Dataobject()
                    temp.id  = String(cString: sqlite3_column_text(stmt, 0))
                    temp.video = String(cString: sqlite3_column_text(stmt, 1))
                    temp.image = String(cString: sqlite3_column_text(stmt, 2))
                    mainarr.add(temp)
                }
                sqlite3_finalize(stmt)
            }
            sqlite3_close(dbop)
        }
        print(mainarr.count)
        return mainarr
    }
    static func Get_MyCreationPhotos() -> NSMutableArray {
        let query = "select * from tbl_mycreation order by id desc"
        let mainarr = NSMutableArray()
        var dbop :OpaquePointer? = nil
        if sqlite3_open(Utility.databasePath(), &dbop) == SQLITE_OK {
            var stmt : OpaquePointer? = nil
            if sqlite3_prepare_v2(dbop, query, -1, &stmt, nil) == SQLITE_OK{
                while sqlite3_step(stmt) == SQLITE_ROW {
                    
                    let temp = Dataobject()
                    temp.id  = String(cString: sqlite3_column_text(stmt, 0))
                    temp.image = String(cString: sqlite3_column_text(stmt, 1))
                    mainarr.add(temp)
                }
                sqlite3_finalize(stmt)
            }
            sqlite3_close(dbop)
        }
        print(mainarr.count)
        return mainarr
    }
    static func deleteImage(id: String) -> Bool {
        let query = "delete from tbl_mycollection_image where id = \(id)"
        var status : Bool = false
        var dbop :OpaquePointer? = nil
        if sqlite3_open(Utility.databasePath(), &dbop) == SQLITE_OK {
            var stmt : OpaquePointer? = nil
            if sqlite3_prepare_v2(dbop, query, -1, &stmt, nil) == SQLITE_OK{
                if sqlite3_step(stmt) == SQLITE_DONE {
                    print("Deleted")
                }
                status = true
                sqlite3_finalize(stmt)
            }
            sqlite3_close(dbop)
        }
        return status
    }
    static func delete_myCreationPhoto(id: String) -> Bool {
        let query = "delete from tbl_mycreation where id = \(id)"
        var status : Bool = false
        var dbop :OpaquePointer? = nil
        if sqlite3_open(Utility.databasePath(), &dbop) == SQLITE_OK {
            var stmt : OpaquePointer? = nil
            if sqlite3_prepare_v2(dbop, query, -1, &stmt, nil) == SQLITE_OK{
                if sqlite3_step(stmt) == SQLITE_DONE {
                    print("Deleted")
                }
                status = true
                sqlite3_finalize(stmt)
            }
            sqlite3_close(dbop)
        }
        return status
    }

    static func deleteVideo(id: String) -> Bool {
        let query = "delete from tbl_mycollection_video where id = \(id)"
        var status : Bool = false
        var dbop :OpaquePointer? = nil
        if sqlite3_open(Utility.databasePath(), &dbop) == SQLITE_OK {
            var stmt : OpaquePointer? = nil
            if sqlite3_prepare_v2(dbop, query, -1, &stmt, nil) == SQLITE_OK{
                if sqlite3_step(stmt) == SQLITE_DONE {
                    print("Deleted")
                }
                status = true
                sqlite3_finalize(stmt)
            }
            sqlite3_close(dbop)
        }
        return status
    }
    static func Get_my_collection_Quetos() -> NSMutableArray {
        let query = "select * from tbl_quetos order by id desc"
        let mainarr = NSMutableArray()
        var dbop :OpaquePointer? = nil
        if sqlite3_open(Utility.databasePath(), &dbop) == SQLITE_OK {
            var stmt : OpaquePointer? = nil
            if sqlite3_prepare_v2(dbop, query, -1, &stmt, nil) == SQLITE_OK{
                while sqlite3_step(stmt) == SQLITE_ROW {
                    
                    let temp = QuotedDataobj()
                    temp.id  = String(cString: sqlite3_column_text(stmt, 0))
                    temp.quetos_id = String(cString: sqlite3_column_text(stmt, 1))
                    temp.quetos = String(cString: sqlite3_column_text(stmt, 2))
                    temp.category_id = String(cString: sqlite3_column_text(stmt, 3))
                    temp.category_name = String(cString: sqlite3_column_text(stmt, 4))
                    mainarr.add(temp)
                }
                sqlite3_finalize(stmt)
            }
            sqlite3_close(dbop)
        }
        print(mainarr.count)
        return mainarr
    }
    static func delete_quetosData(id: String) -> Bool {
        let query = "delete from tbl_quetos where quetos_id = \(id)"
        var status : Bool = false
        var dbop :OpaquePointer? = nil
        if sqlite3_open(Utility.databasePath(), &dbop) == SQLITE_OK {
            var stmt : OpaquePointer? = nil
            if sqlite3_prepare_v2(dbop, query, -1, &stmt, nil) == SQLITE_OK{
                if sqlite3_step(stmt) == SQLITE_DONE {
                    print("Deleted")
                }
                status = true
                sqlite3_finalize(stmt)
            }
            sqlite3_close(dbop)
        }
        return status
    }
    static func check_Favourite_exits(CategoryID:String) -> Bool {
        let query = "select * from tblFavourite where cat_id='\(CategoryID)'"
        var mainarr : [Any] = []
        var dbop :OpaquePointer? = nil
        var status = false
        
        if sqlite3_open(Utility.databasePath(), &dbop) == SQLITE_OK {
            var stmt : OpaquePointer? = nil
            if sqlite3_prepare_v2(dbop, query, -1, &stmt, nil) == SQLITE_OK{
                while sqlite3_step(stmt) == SQLITE_ROW {
                    
                    let fav_id = String(cString: sqlite3_column_text(stmt, 0))
                    mainarr.append(fav_id)
                    status = true
                }
                sqlite3_finalize(stmt)
            }
            sqlite3_close(dbop)
        }
        return status
    }
    static func check_Quotes_exits(QuotesID:String) -> Bool {
        let query = "select * from tbl_quetos where quetos_id='\(QuotesID)'"
        var mainarr : [Any] = []
        var dbop :OpaquePointer? = nil
        var status = false
        
        if sqlite3_open(Utility.databasePath(), &dbop) == SQLITE_OK {
            var stmt : OpaquePointer? = nil
            if sqlite3_prepare_v2(dbop, query, -1, &stmt, nil) == SQLITE_OK{
                while sqlite3_step(stmt) == SQLITE_ROW {
                    
                    let fav_id = String(cString: sqlite3_column_text(stmt, 0))
                    mainarr.append(fav_id)
                    status = true
                }
                sqlite3_finalize(stmt)
            }
            sqlite3_close(dbop)
        }
        return status
    }
    static func deleteData(id: String) -> Bool {
        let query = "delete from tblFavourite where cat_id = \(id)"
        var status : Bool = false
        var dbop :OpaquePointer? = nil
        if sqlite3_open(Utility.databasePath(), &dbop) == SQLITE_OK {
            var stmt : OpaquePointer? = nil
            if sqlite3_prepare_v2(dbop, query, -1, &stmt, nil) == SQLITE_OK{
                if sqlite3_step(stmt) == SQLITE_DONE {
                    print("Deleted")
                }
                status = true
                sqlite3_finalize(stmt)
            }
            sqlite3_close(dbop)
        }
        return status
    }
    static func deleteallData() {
        let query = "delete from tbl_mycollection_video"
        var dbop :OpaquePointer? = nil
        if sqlite3_open(Utility.databasePath(), &dbop) == SQLITE_OK {
            var stmt : OpaquePointer? = nil
            if sqlite3_prepare_v2(dbop, query, -1, &stmt, nil) == SQLITE_OK{
                if sqlite3_step(stmt) == SQLITE_DONE {
                    print("Deleted")
                }
                sqlite3_finalize(stmt)
            }
            sqlite3_close(dbop)
        }
        
        let query2 = "delete from tbl_mycollection_image"
        var dbop2 :OpaquePointer? = nil
        if sqlite3_open(Utility.databasePath(), &dbop2) == SQLITE_OK {
            var stmt2 : OpaquePointer? = nil
            if sqlite3_prepare_v2(dbop2, query2, -1, &stmt2, nil) == SQLITE_OK{
                if sqlite3_step(stmt2) == SQLITE_DONE {
                    print("Deleted")
                }
                sqlite3_finalize(stmt2)
            }
            sqlite3_close(dbop2)
        }
        
        let query3 = "delete from tbl_quetos"
        var dbop3 :OpaquePointer? = nil
        if sqlite3_open(Utility.databasePath(), &dbop3) == SQLITE_OK {
            var stmt3 : OpaquePointer? = nil
            if sqlite3_prepare_v2(dbop3, query3, -1, &stmt3, nil) == SQLITE_OK{
                if sqlite3_step(stmt3) == SQLITE_DONE {
                    print("Deleted")
                }
                sqlite3_finalize(stmt3)
            }
            sqlite3_close(dbop3)
        }
        
        let query4 = "delete from tbl_mycreation"
        var dbop4 :OpaquePointer? = nil
        if sqlite3_open(Utility.databasePath(), &dbop4) == SQLITE_OK {
            var stmt4 : OpaquePointer? = nil
            if sqlite3_prepare_v2(dbop4, query4, -1, &stmt4, nil) == SQLITE_OK{
                if sqlite3_step(stmt4) == SQLITE_DONE {
                    print("Deleted")
                }
                sqlite3_finalize(stmt4)
            }
            sqlite3_close(dbop4)
        }
    }
    static func check_language_exits(languagename:String) -> Bool {
        let query = "select * from tbl_language where language_name='\(languagename)'"
        var mainarr : [Any] = []
        var dbop :OpaquePointer? = nil
        var status = false
        
        if sqlite3_open(Utility.databasePath(), &dbop) == SQLITE_OK {
            var stmt : OpaquePointer? = nil
            if sqlite3_prepare_v2(dbop, query, -1, &stmt, nil) == SQLITE_OK{
                while sqlite3_step(stmt) == SQLITE_ROW {
                    
                    let fav_id = String(cString: sqlite3_column_text(stmt, 0))
                    mainarr.append(fav_id)
                    status = true
                }
                sqlite3_finalize(stmt)
            }
            sqlite3_close(dbop)
        }
        return status
    }
    static func deletelanguage_Data(languagename:String) {
        let query = "delete from tbl_language where language_name='\(languagename)'"
        var dbop :OpaquePointer? = nil
        if sqlite3_open(Utility.databasePath(), &dbop) == SQLITE_OK {
            var stmt : OpaquePointer? = nil
            if sqlite3_prepare_v2(dbop, query, -1, &stmt, nil) == SQLITE_OK{
                if sqlite3_step(stmt) == SQLITE_DONE {
                    print("Deleted")
                }
                sqlite3_finalize(stmt)
            }
            sqlite3_close(dbop)
        }
    }
    static func Get_language_List() -> [String] {
        let query = "select language_name from tbl_language"
        var mainarr = [String]()
        var dbop :OpaquePointer? = nil
        if sqlite3_open(Utility.databasePath(), &dbop) == SQLITE_OK {
            var stmt : OpaquePointer? = nil
            if sqlite3_prepare_v2(dbop, query, -1, &stmt, nil) == SQLITE_OK{
                while sqlite3_step(stmt) == SQLITE_ROW {
                    
                    let temp = String(cString: sqlite3_column_text(stmt, 0))
                    mainarr.append(temp)
                }
                sqlite3_finalize(stmt)
            }
            sqlite3_close(dbop)
        }
        print(mainarr.count)
        print(mainarr)
        return mainarr
    }
}
