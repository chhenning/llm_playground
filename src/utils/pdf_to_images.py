import base64

import pymupdf
from tqdm import tqdm


DPI = 300
IMAGE_FORMAT = "PNG"

pdf_fn = "data/someday.pdf"
pdf_doc = pymupdf.open(pdf_fn)

for page in tqdm(pdf_doc, total=pdf_doc.page_count):
    pix = page.get_pixmap(dpi=DPI)
    image_bytes = pix.tobytes(IMAGE_FORMAT)
    encoded_string = base64.b64encode(image_bytes).decode("utf-8")
    data_uri = f"data:image/png;base64,{encoded_string}"
