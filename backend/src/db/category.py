from typing import List, Optional


class CategoryDB:
    collection_name = "category"

    def __init__(self, db):
        self.db = db

    def get_categories(self):
        cursor = self.db.find({})
        categories = []
        for category in cursor:
            category["_id"] = str(category["_id"])
            categories.append(category)
        cursor.close()
        return categories

    def create_category(self, category_name : str, images : List[str]):
        item = {
            "category_name" : category_name,
            "images" : images
        }
        self.db.insert_one(item)
        print("categoria criada")

    def update_category(self, category_name : str, new_name : Optional[str], new_images : Optional[List[str]]):
        if new_name is None:
            new_name = category_name
        new_item = {}
        if new_images is None:
            new_item = {
                "$set": {
                    "category_name" : new_name
                }
            }
        else:
            new_item = {
                "$set": {
                    "category_name" : new_name,
                    "images" : new_images
                }
            }
        self.db.update_one({"category_name" : category_name}, new_item)
        print("categoria atualizada")

    def delete_category(self, category_name : str):
        self.db.delete_one({"category_name" : category_name})
        print("categoria deletada")

    def get_category_images(self):
        cursor = self.db.aggregate([{
            "$unwind" : "$images",
        },
        {
            "$lookup" : {
                "from" : "image_info",
                "localField" : "images",
                "foreignField" : "image_name",
                "as" : "image_info"
            },
        },
                       {"$unwind" : "$image_info"},
        {
            "$group" : {
                "_id" : {
                  "$toString" : "$_id"
                  },
                "category_name" : {
                    "$first" : "$category_name"
                },
                "images" : {
                    "$push" : {
                      "_id" : {"$toString" : "$image_info._id"},
                      "image_name" : "$image_info.image_name",
                      "image_description" : "$image_info.image_description",
                      "thumbnail" : "$image_info.thumbnail"
                    }
                }
            }
        },
        ])
        categories = list(cursor)
        cursor.close()
        return categories
