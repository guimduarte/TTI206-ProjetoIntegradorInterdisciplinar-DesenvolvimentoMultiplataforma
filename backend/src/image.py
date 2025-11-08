from io import BytesIO
from PIL.Image import Image, Resampling, fromarray
import os
from fastapi import UploadFile
import pyvips
import osgeo_utils.gdal2tiles
import gzip
import tarfile
import openslide

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
    
def decompress_file(file : UploadFile):
    with open(f"{file.filename}", "wb") as tarball:
        tarball.write(file.file.read())
    with tarfile.open(f"{file.filename}") as tar:
        tar.extractall()
        result_filename = [filename for filename in tar.getnames() if filename.endswith(".mrxs")][0]
    print(result_filename)
    return result_filename

def generate_thumbnail(filename : str):
    slide = openslide.OpenSlide(filename)
    print(slide.properties)
    slide_image = pyvips.Image.openslideload(f"{filename}", autocrop = True)
    numpy_array = slide_image.numpy()
    image = fromarray(numpy_array)
    temp = BytesIO()
    image.thumbnail((1024,1024), Resampling.LANCZOS)
    image.save(temp, format="png")
    return temp.getvalue()
    
    
