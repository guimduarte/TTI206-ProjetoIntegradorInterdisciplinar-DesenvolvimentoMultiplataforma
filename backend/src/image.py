import os
from fastapi import UploadFile
import pyvips
import osgeo_utils.gdal2tiles
import gzip
import tarfile


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
    
def decompress_file(upload_file : UploadFile):
    new_filename = upload_file.filename
    if new_filename is None:
        new_filename = "temp.tar.gz"
    new_filename = new_filename.removesuffix(".gz")
    with gzip.open(upload_file.file) as file, gzip.open(f"{new_filename}", "wb") as tarball:
        decompressed_file = file.read()
        tarball.write(decompressed_file)
    with tarfile.open(f"{new_filename}") as tar:
        tar.extractall()
        result_filename = [filename for filename in tar.getnames() if filename.endswith(".mrxs")][0]
    print(result_filename)
    return result_filename
