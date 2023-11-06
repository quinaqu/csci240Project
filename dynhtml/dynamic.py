from flask import Flask, render_template, request

app = Flask(__name__)


@app.route('/')
def index():
    return render_template("index.html")

@app.route('/dget.html')
def dget():
    output = render_template('dget.html')
    return output


@app.route('/submitdget.html', methods=['GET'])
def resubmitdget():
    creaturename = request.args.get('cname')
    print(creaturename)
    armorclass = request.args.get('aclass')

    size = request.args.get('csize')
 
    output = render_template('table.html', creaturename=creaturename, armorclass=armorclass, size=size)
    return output 

@app.route('/dpost.html')
def dpost():
    output = render_template('dpost.html')
    return output 

@app.route('/submitdpost.html', methods=['POST'])
def submitdpost():
    creaturename = request.form.get('cname')
    armorclass = request.form.get('aclasss')
    size = request.form.get('csize')
    output = render_template('table.html', creaturename=creaturename, armorclass=armorclass, size=size)
    return output 

@app.route('/table-list.html')
def renderMultiple():
    exampleCollection = [{'cname':'place', 'aclass':'holder', 'csize':'data'},
                         {'cname':'is', 'aclass':'this', 'csize':'visible?'}]
    output = render_template('table-list.html', collection=exampleCollection)
    return output 

if __name__ == '__main__':
    app.run(port=5000)