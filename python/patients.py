from peewee import *

db = SqliteDatabase('patientregistry.db')

class Patient(Model):
    name = CharField(max_length=255, unique = True)
    insurance = IntegerField(default=0)

    class Meta:
        database = db



if __name__ == '__main__':
    db.connect()
    db.create_tables([Patient], safe = True)

    #helpful commands below
    #.create(), .select(),.save(),.get(),.delete_instance()

