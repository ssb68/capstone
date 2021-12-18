import logging
from flask import Flask, render_template
from flask.logging import create_logger

app = Flask(__name__)
LOG = create_logger(app)
LOG.setLevel(logging.INFO)

@app.route('/hello/')
@app.route('/hello/<name>')
def hello(name=None):
    return render_template('hello-v1.html', name=name)

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=80, debug=True)
    