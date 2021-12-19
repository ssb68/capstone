import logging
import os
from flask import Flask, render_template
from flask.logging import create_logger

app = Flask(__name__)
LOG = create_logger(app)
LOG.setLevel(logging.INFO)

hello_version = os.environ['HELLO_VERSION']
print("Running with version: %s" % hello_version)

@app.route('/hello/')
@app.route('/hello/<name>')
def hello(name=None):
    return render_template(hello_version, name=name)

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=80, debug=True)
