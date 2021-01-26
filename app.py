import os
import random
import sys

import flask

app = flask.Flask(__name__)

storage_path = os.environ['STORAGE_PATH']
photos_dir = os.path.join(os.path.expandvars(storage_path), 'albums/Wallpaper')
if os.path.isdir(photos_dir):
    app.logger.info('%s exists', photos_dir)
else:
    app.logger.error('cannot find %s', photos_dir)
    sys.exit(1)


def is_image(f):
    extensions = ['.JPG', '.JPEG', '.PNG']
    return os.path.splitext(f)[1].upper() in extensions


@app.route('/')
def random_image():
    images = filter(is_image, os.listdir(photos_dir))
    choice = random.choice(list(images))
    app.logger.info('random choice: %s', choice)
    return flask.send_file(os.path.join(photos_dir, choice), mimetype='image/jpeg')
