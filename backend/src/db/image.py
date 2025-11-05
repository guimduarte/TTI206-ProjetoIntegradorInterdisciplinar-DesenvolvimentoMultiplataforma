from io import BytesIO
import re
from os import walk
from os.path import join
import base64
from PIL.Image import Image

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
                        zxy = f"{groups[0]}/{groups[1]}/{filename.split('.')[0]}"                        
                        item = {
                            "image_name" : self.image_name,
                            "zxy" : zxy,
                            "src" : data
                        }
                        self.db.insert_one(item)
        print("enviado")
        
    def save_thumbnail(self, image_bytes : bytes):
        base64_bytes = base64.b64encode(image_bytes)
        data = base64_bytes.decode("ascii")
        image = {
            "image_name" : self.image_name,
            "thumbnail" : data
        }
        self.db.insert_one(image)
        print("thumbnail criada")
        
        
    def get_image(self, zxy : str):
        image = self.db.find_one({"image_name" : self.image_name, "zxy" : zxy})
        if image is None:
            return None
        return base64.b64decode(image["src"])

    def get_thumbnail(self):
        image = self.db.find_one({"image_name" : self.image_name})
        if image is None:
            return None
        return base64.b64decode(image["thumbnail"])
