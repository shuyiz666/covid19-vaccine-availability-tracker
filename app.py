from flask import Flask
from flask import render_template
from flask import jsonify
import utils

app = Flask(__name__)

@app.route('/')
def web():
    return render_template("main.html")

@app.route("/time")
def get_time():
    return utils.get_time()

@app.route("/shaws_star")
def shaws_star():
    stores_numbers = utils.shaws_star()
    data = []
    for store, number in stores_numbers:
        data.append({'value': number, 'name': store})
    return jsonify({"data": data})

@app.route("/store_ava")
def store_ava():
    star = utils.star_ava()
    shaws = utils.shaws_ava()
    star_ava, shaws_ava = [], []

    for availability, number in star:
        star_ava.append({'value': number, 'name': availability})

    for availability, number in shaws:
        shaws_ava.append({'value': number, 'name': availability})

    return jsonify({"star": star_ava, "shaws": shaws_ava})

@app.route("/city")
def city():
    cities = utils.city()
    data = []
    for city, ava, total, rate in cities:
        data.append({'city': city, 'available': ava, 'total': total, 'available rate (%)': str(round(rate, 2))+'%'})

    return jsonify({"data": data})


if __name__ == '__main__':
    app.run()
