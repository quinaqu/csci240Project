from flask import Flask, render_template, request, redirect, url_for
import mysql.connector, json

with open('secrets.json','r') as secretFile:
    creds = json.load(secretFile)['mysqlCredentials']

app = Flask(__name__)

@app.route('/',methods=['GET'])
def showtable():

    connection = mysql.connector.connect(**creds)
    mycursor = connection.cursor(dictionary=True)
    creaturename = request.args.get('CreatureName')
    newcreature = request.args.get('CreatureName')
    newhp = request.args.get('HP')
    newmelee = request.args.get('MeleeDmg')
    newrng = request.args.get('RangeDmg')
    newac = request.args.get('AC')
    newsize = request.args.get('SizeType')
    newtype = request.args.get('PrimaryType')
    

    if newcreature is not None and newhp is not None and newsize is not None:
        mycursor = connection.cursor(dictionary=True)
        mycursor.execute("insert into PFMonsters.Creature (CreatureName, HP, MeleeDmg, RangeDmg, AC, SizeType, PrimaryType) values (%s, %s, %s, %s, %s, %s, %s)", (newcreature, newhp, newmelee, newrng, newac, newsize, newtype,))
        connection.commit()
        return redirect(url_for('showtable'))
    if request.args.get('delete') == 'true':
        delcreature = request.args.get('CreatureName')
        mycursor.execute('delete from Creature where CreatureName=%s',(delcreature,))
        connection.commit()
    
    mycursor.execute('Select * from Creature;')
    allcreatures = mycursor.fetchall()
    mycursor.close()
    connection.close()

    return render_template('Creature-list.html', allcreatures=allcreatures,)

@app.route("/creature-abilities", methods=['GET'])
def creatureabilities():
    connection = mysql.connector.connect(**creds)
    mycursor = connection.cursor(dictionary=True)
    creaturename = request.args.get('CreatureName')
    if creaturename is not None:
        mycursor.execute("""select ca.CreatureName,ae.AbilityName,ae.Effect
                            from CreatureAbility ca 
                            left join Creature c 
                            on ca.CreatureName = c.CreatureName 
                            inner join AbilityEffect ae 
                            on ae.AbilityName = ca.AbilityName
                            where c.CreatureName=%s;""",(creaturename,))
    creatureresult=mycursor.fetchall()
    if request.args.get('delete')== 'true':
        delcreature = request.args.get('CreatureName')
        delability = request.args.get('AbilityName')
        mycursor.execute('delete from CreatureAbility where CreatureName=%s and AbilityName=%s',(delcreature,delability,))
        connection.commit()
        mycursor.close()
        connection.close()
    try:
        return render_template('creature-abilities.html',creatureresult=creatureresult)
    except:
        return render_template('error.html', message= 'This creature has no abilities yet')

@app.route("/editability", methods = ['GET','POST'])
def editability():
    connection2 = mysql.connector.connect(**creds)
    mycursor2 = connection2.cursor(dictionary=True)
    creaturename = request.args.get('CreatureName')
    
   
    mycursor2.execute("Select CreatureName from Creature")
    creatures = mycursor2.fetchall()

    mycursor2.execute("Select Distinct AbilityName from Ability")
    collection = mycursor2.fetchall()
    
    addcreature= request.args.get("CreatureName")
    addability= request.args.get("AbilityName")
    if addcreature is not None:
        mycursor2 = connection2.cursor(dictionary=True)
        try:
            mycursor2.execute("insert into PFMonsters.CreatureAbility (CreatureName, AbilityName) values (%s,%s)",(addcreature,addability,))
            connection2.commit()
            
        except mysql.connector.Error as err:
            print("Error: {}".format(err))
            return render_template('error.html', message= 'This creature may already have this ability')
    mycursor2.close()
    connection2.close()
    
    return render_template('editability.html', creaturename=creaturename, collection=collection, creatures=creatures)
    

@app.route("/ability", methods=['GET'])
def showabilities():
    connection = mysql.connector.connect(**creds)
    mycursor = connection.cursor(dictionary=True)
    mycursor.execute('Select * from Ability')
    allabilities = mycursor.fetchall()
    abilityname = request.args.get('AbilityName')
    newabilityname = request.args.get('AbilityName')
    newabilitytype = request.args.get('AbilityType')
    
    if request.args.get('delete')== 'true':
        connection = mysql.connector.connect(**creds)
        mycursor2 = connection.cursor(dictionary=True)
        delability = request.args.get('AbilityName')
        try:
            mycursor2.execute('delete from Ability where AbilityName=%s',(delability,))
            connection.commit()
        except mysql.connector.Error as err:
            print("Error: {}".format(err))
            return render_template('error.html', message= 'Abilites must have any effects and creatures removed before deleting')

    if newabilityname is not None:

        newabilityname = request.args.get('AbilityName')
        newabilitytype = request.args.get('AbilityType')
        mycursor.execute("insert into PFMonsters.Ability (AbilityName,AbilityType) values (%s, %s)", (newabilityname, newabilitytype,))
        connection.commit()
        
    mycursor.close()
    connection.close()

    try:
        return render_template('ability-list.html', allabilities=allabilities,)
    except:
        return render_template('error.html', message='This ability is not assigned to any creatures')

@app.route("/abilityresults", methods=['GET'])
def filterabilities():
    connection = mysql.connector.connect(**creds)
    mycursor = connection.cursor(dictionary=True)
    abilityname = request.args.get('AbilityName')
    if abilityname is not None:
        mycursor.execute("""select ca.CreatureName,ae.AbilityName,ae.Effect
                        from CreatureAbility ca 
                        left join Creature c 
                        on ca.CreatureName = c.CreatureName 
                        inner join AbilityEffect ae 
                        on ae.AbilityName = ca.AbilityName
                        where ae.AbilityName=%s;""",(abilityname,))
        abilityresult=mycursor.fetchall()
        try:
            return render_template('abilityresults.html', abilityresult=abilityresult,)
        except: 
            return render_template('error.html', message='This ability is not assigned to any creatures')


@app.route("/updateCreature", methods=['GET'])
def updatecreature():
    connection2 = mysql.connector.connect(**creds)
    mycursor2 = connection2.cursor(dictionary=True)
    creaturename = request.args.get('CreatureName')
    newhp = request.args.get('HP')
    newmelee = request.args.get('MeleeDmg')
    newrng = request.args.get('RangeDmg')
    newac = request.args.get('AC')
    newsize = request.args.get('SizeType')
    newtype = request.args.get('PrimaryType')
    mycursor2.execute("Select * from Creature where CreatureName=%s",(creaturename,))
    collection = mycursor2.fetchall()

    if creaturename is not None and newhp is not None and newsize is not None:
        
        mycursor2.execute("UPDATE Creature set HP=%s, MeleeDmg=%s, RangeDmg=%s, AC=%s, SizeType=%s, PrimaryType=%s where CreatureName=%s;", (newhp, newmelee, newrng, newac, newsize, newtype, creaturename,))
        connection2.commit()
        return redirect(url_for('showtable'))
    mycursor2.close()
    connection2.close()
    try:
        return render_template('Creature-update.html', creaturename=creaturename, collection=collection)
    except:
        return render_template('error.html', message= "Test")

@app.route("/effects", methods=['GET'])
def effects():
    connection = mysql.connector.connect(**creds)
    mycursor = connection.cursor(dictionary=True)
    abilityname = request.args.get('AbilityName')
    mycursor.execute('''Select AbilityName from Ability 
                     where AbilityName=%s;''',(abilityname,))
    titlename= mycursor.fetchone()
    neweffect = request.args.get('Effect')
    if abilityname is not None:
        mycursor.execute("""select AbilityName,Effect
                        from AbilityEffect
                        where AbilityName=%s;""",(abilityname,))
        alleffects=mycursor.fetchall()

    if request.args.get('delete') == 'true':
        abilityname= request.args.get('AbilityName')
        deleffect = request.args.get('Effect')
        mycursor.execute('delete from AbilityEffect where Effect=%s',(deleffect,))
        connection.commit()

    if neweffect is not None:
        abilityname=request.args.get('AbilityName')
        neweffect=request.args.get('Effect')
        mycursor.execute('insert into AbilityEffect (AbilityName,Effect) values (%s,%s)',(abilityname,neweffect,))
        connection.commit()
    
    mycursor.close()
    connection.close()
    return render_template('effects.html', alleffects=alleffects, abilityname=abilityname,titlename=titlename)
    

if __name__ == '__main__':
    app.run(port=8000, debug=True, host="0.0.0.0")