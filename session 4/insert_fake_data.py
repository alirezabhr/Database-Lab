import psycopg2
from faker import Faker
from dotenv import load_dotenv
import os


CITY_COUNT = 10000
CUSTOMERS_COUNT = 500000
CUSTOMER_ADDRESSES_COUNT = 100000


# Get all customers
def get_customers(cursor):
    cursor.execute("SELECT * FROM customer")
    customers = cursor.fetchall()
    return customers

# Get all cities
def get_cities(cursor):
    cursor.execute("SELECT * FROM city")
    cities = cursor.fetchall()
    return [c[0] for c in cities]
    

# Insert data into table
def insert_customers(cursor, connection):
    customers = get_customers(cur)
    phones = [customer[2] for customer in customers]

    for i in range(CUSTOMERS_COUNT):
        name = fake.name()[:60]
        
        while (phone_number := f'09{fake.random_int(min=100000000, max=999999999)}') in phones:
            continue

        phones.append(phone_number)

        print(f'Inserting Customer {i}: {name} - {phone_number}')

        cursor.execute("Insert INTO customer (name, phone) VALUES (%s, %s)", (name, phone_number))
    
    connection.commit()


def insert_cities(cursor, connection):
    cities = get_cities(cursor)

    for i in range(CITY_COUNT):
        while (city := fake.city()[:60]) in cities:
            continue
        cities.append(city)

        print(f'Inserting City {i}: {city}')

        # IMPORTANT: Second arg must be a tuple
        cursor.execute("Insert INTO city VALUES (%s)", (city,))
    
    connection.commit()


def insert_customers_addresses(cursor, connection):
    customers_id = fake.random_choices(elements=[c[0] for c in get_customers(cursor)], length=CUSTOMER_ADDRESSES_COUNT)
    cities_name = fake.random_choices(elements=get_cities(cursor), length=CUSTOMER_ADDRESSES_COUNT)

    for i in range(CUSTOMER_ADDRESSES_COUNT):
        customer_id = customers_id[i]
        city = cities_name[i]
        address_line = fake.street_address()
        coordinate = f'({fake.coordinate()}, {fake.coordinate()})'

        print(f'Inserting Customer Address {i}: {customer_id}, {city}, {address_line}, {coordinate}')

        # IMPORTANT: Second arg must be a tuple
        cursor.execute("Insert INTO customer_address (customer_id, city, address_line, coordinate)"
                        "VALUES (%s, %s, %s, %s)", (customer_id, city, address_line, coordinate))
    
    connection.commit()



def insert_test_users():
    for i in range(1000000):
        fn = fake.first_name()
        ln = fake.last_name()
        bd = fake.date()

        print(f'{i}: {fn} - {ln} - {bd}')
        cur.execute("Insert INTO test_user (first_name, last_name, birth_date) VALUES (%s, %s, %s)", (fn, ln, bd))
    
    conn.commit()

if __name__ == '__main__':
    # read from env file
    load_dotenv()

    # Connect to Database
    conn = psycopg2.connect(
        host="localhost",
        database=os.getenv("DB_NAME"),
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PASSWORD"),
    )

    cur = conn.cursor()

    # Create faker object
    fake = Faker(locale='en_US')

    insert_customers(cur, conn)
    insert_cities(cur, conn)
    insert_customers_addresses(cur, conn)
    get_cities(cur)
    get_customers(cur)
    
