import TileStache

application = TileStache.WSGITileServer('/mnt/uwsgi/tilestache/tilestache.cfg', autoreload=True)
