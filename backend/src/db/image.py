import re
from os import walk
from os.path import join
import base64

class ImageDB:
    collection_name = "images"

    def __init__(self, image_name : str, db):
        self.image_name = image_name
        self.db = db

    def save_image(self, path : str):
        for (dirpath, _, filenames) in walk(path):
            re_match = re.match(r".*(?:/|\\)(\d*)(?:/|\\)(\d*)$",dirpath)
            if re_match:
                groups = re_match.groups()
                for filename in filenames:
                    with open(join(dirpath, filename), "rb") as file:
                        base64_bytes = base64.b64encode(file.read())
                        data = base64_bytes.decode("ascii")
                        xyz = f"{groups[0]}/{groups[1]}/{filename.split('.')[0]}"                        
                        item = {
                            "image_name" : self.image_name,
                            "xyz" : xyz,
                            "src" : data
                        }
                        self.db.insert_one(item)
        print("enviado")

    def get_image(self, xyz : str):
        image = self.db.find_one({"image_name" : self.image_name, "xyz" : xyz})
        return base64.b64decode(image["src"])
