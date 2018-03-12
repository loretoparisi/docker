#
# Yahoo! Open NSFW Web Service
# Not Suitable for Work (NSFW) classification using deep neural network Caffe models
# Adapted from https://github.com/loretoparisi/nsfwaas
# @see https://github.com/loretoparisi/nsfwaas
# @see https://github.com/yahoo/open_nsfw
#
# Copyright (c) 2018 Loreto Parisi - https://github.com/loretoparisi/docker
#

import os
import time
from flask import Flask, request, g, abort, jsonify, render_template
#from flask_limiter import Limiter
import nsfwnet

import traceback
import logging
import threading
import subprocess

class FuncThread(threading.Thread):
	def __init__(self, target, *args):
		self._target = target
		self._args = args
		threading.Thread.__init__(self)

	def run(self):
		self._target(*self._args)

#
# Exec a process
#
def runProcess(exe):
	p = subprocess.Popen(exe, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
	while(True):
	  retcode = p.poll() #returns None while subprocess is running
	  line = p.stdout.readline()
	  yield line
	  if(retcode is not None):
		break

app = Flask(__name__)
app.debug = True
#limiter = Limiter(app, global_limits=["100 per hour", "20 per minute"])

# retrieve env config
PORT = os.getenv('PORT', 9080)
DIST = os.getenv('DIST', 'prod')

app.config.update(
	VALID_HOSTS=['localhost:' + str(PORT), 'ai.musixmatch.com', 'ai-api.musixmatch.com']
)

class InvalidUsage(Exception):
    status_code = 400

    def __init__(self, message, status_code=None, payload=None):
        Exception.__init__(self)
        self.message = message
        if status_code is not None:
            self.status_code = status_code
        self.payload = payload

    def to_dict(self):
        rv = dict(self.payload or ())
        rv['message'] = self.message
        return rv

@app.before_request
def where_am_i_from():
	protocol = request.environ['wsgi.url_scheme']
	hostname = request.host
	if hostname not in app.config['VALID_HOSTS']:
		abort(503)
	g.host = hostname
	g.protocol = protocol

@app.errorhandler(InvalidUsage)
def handle_invalid_usage(error):
    response = jsonify(error.to_dict())
    response.status_code = error.status_code
    return response

@app.route("/")
def index():
    return "NSFWaaS/1.0"

@app.route("/classify", methods=["POST"])
def classify():
    global nsfw
    fsImage =  request.files.get("image")
    if fsImage:
        try:
            nsfw_score= "%f" % nsfwnet.nsfwnet.classify(fsImage.read())
            timestamp = int(time.time())
            results = {
                "score" : nsfw_score,
                "updated_time" : str(timestamp)
            }
            jsonResult = jsonify( results )
            return jsonResult
        except Exception as e:
            print(e)
            print(traceback.format_exc())
            raise InvalidUsage('bad image format', status_code=500)
    else:
        raise InvalidUsage('invalid image', status_code=500)

if __name__ == "__main__":

    # start backend server
    if DIST == 'prod':
        
        # run on Tornado instead, since running raw Flask in prod is not recommended
        print('runnin backend [tornado] on port %s' % PORT)
        
        from tornado.wsgi import WSGIContainer
        from tornado.httpserver import HTTPServer
        from tornado.ioloop import IOLoop
        from tornado.log import enable_pretty_logging

        app.debug = False

        # logging
        #timestr = time.strftime("%Y%m%d-%H%M%S")
        #log_file_filename = "/opt/logs/tornado/" + timestr + ".log"

        enable_pretty_logging()
        
        #tornado.options.options['log_file_prefix'].set(log_file_filename)
        #tornado.options.parse_command_line()

        #handler = logging.FileHandler(log_file_filename)
        #app_log = logging.getLogger("tornado.application")
        #app_log.addHandler(handler)

        http_server = HTTPServer(WSGIContainer(app))
        http_server.listen( PORT )
        IOLoop.instance().start()

    else:
        print('runnin backend [flask] on port %s' % PORT)
        app.run(debug=True, threaded=True, host='0.0.0.0', port=PORT)
