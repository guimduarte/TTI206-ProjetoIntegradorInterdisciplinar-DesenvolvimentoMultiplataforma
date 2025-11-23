from io import BytesIO
from PIL.Image import Image, Resampling, fromarray
import os
from fastapi import UploadFile
import pyvips
import osgeo_utils.gdal2tiles
import gzip
import tarfile
import openslide
import os

def generate_image(filename : str):
    image = pyvips.Image.openslideload(f"{filename}", autocrop = True)
    new_filename = filename + ".png"
    try :
        tiles_dir = f"{filename}-tiles"
        image.write_to_file(new_filename, Q = 95)
        osgeo_utils.gdal2tiles.main(["",f"./{new_filename}", "--s_srs=EPSG:4326","-praster","-d", "-n", f"{filename}-tiles"])
        return tiles_dir
    except Exception as e:
        return None
    
def decompress_file(files : list[UploadFile]):
    result_filename = ""
    base_dir = ""
    sub_dir = ""
    for file in files:
        if file.filename is not None and file.filename.endswith(".mrxs"):
            base_dir = file.filename
            os.mkdir(base_dir)
            sub_dir = f"{base_dir}/{file.filename.removesuffix('.mrxs')}"
            os.mkdir(sub_dir)
            result_filename = base_dir+"/"+file.filename
            with open(result_filename, "wb") as new_file:
                new_file.write(file.file.read())
                break
    for file in files:
        if file.filename is not None and not file.filename.endswith(".mrxs"):
            with open(sub_dir+"/"+file.filename, "wb") as new_file:
                new_file.write(file.file.read())
    return result_filename

def generate_thumbnail(filename : str):
    slide = openslide.OpenSlide(filename)
    slide_image = pyvips.Image.openslideload(f"{filename}", autocrop = True)
    numpy_array = slide_image.numpy()
    image = fromarray(numpy_array)
    temp = BytesIO()
    image.thumbnail((1024,1024), Resampling.LANCZOS)
    image.save(temp, format="png")
    return temp.getvalue()
    
    
