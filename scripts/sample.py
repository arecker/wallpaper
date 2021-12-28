#!/usr/bin/env python
import logging
import pathlib
import random
import shutil
import sys

logging.basicConfig(stream=sys.stderr, level=logging.INFO)


def main():
    wallpaper_dir = pathlib.Path('./output/albums/Wallpaper/')

    if not wallpaper_dir.is_dir():
        raise RuntimeError(f'can\'t find {wallpaper_dir}!')
    logging.info('validated %s exists', wallpaper_dir)

    sample_dir = pathlib.Path('./sample/')
    sample_dir.mkdir(exist_ok=True)
    logging.info('validated %s exists', sample_dir)

    samples = [e for e in sample_dir.glob('*') if e.is_file()]
    for entry in samples:
        entry.unlink()
        logging.debug('deleted %s', entry)
    logging.info('cleaned %d file(s) from %s', len(samples), sample_dir)

    samples = [e for e in wallpaper_dir.glob('*') if e.is_file()]
    samples = random.sample(samples, 100)
    logging.info('built new sample list of %d file(s)', len(samples))

    for source in samples:
        destination = sample_dir / source.name
        shutil.copy(str(source), str(destination))
        logging.debug('copied %s to %s', source, destination)
    logging.info('copied %d file(s) to %s', len(samples), sample_dir)


if __name__ == '__main__':
    main()
