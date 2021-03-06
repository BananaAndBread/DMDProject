import psycopg2


def connect_to_bd():
    '''
    Connects to bd
    :return: connection_cursor
    '''
    connection = psycopg2.connect('dbname=dmd_project user=dmd_project password=dmd_project host=localhost port=5432')
    return connection.cursor()


def headings(cursor):
    '''
    :param cursor
    :return: headings of the table in list
    '''
    return [x[0] for x in cursor.description]


def result(cursor):
    """
    Makes the output approvable by GUI
    :param cursor
    :return: list of headings and lists of values
    """
    return headings(cursor), cursor.fetchall()


def first_request():
    '''
    A customer claims she forgot her bag in a car and asks to help. She was using cars several
    times this day, but she believes the right car was red and its plate starts with “AN”. Find all
    possible cars that match the description.

    :return: list of headings and lists of values of this table
    '''
    cursor = connect_to_bd()
    cursor.execute('SELECT * FROM cars WHERE plate_number LIKE \'AN%\' AND color=\'red\';')
    return result(cursor)


def second_request(date):
    """
    Company management wants to get a statistics on the efficiency of charging stations
    utilization. Given a date, compute how many sockets were occupied each hour.
    :param date: date from the task
    :return: list of headings and lists of values of this table
    """
    cursor = connect_to_bd()
    array = list()
    for i in range(24):
        cursor.execute(
            '''
            SELECT COUNT(*)
            FROM charges
            JOIN charging_stations cs 
            ON charges.cs_id = cs.id
            WHERE 
            ((EXTRACT (hour from start_time) >= %s AND EXTRACT (hour from start_time) < %s+1)
            OR
            (EXTRACT (hour from (start_time + cs.time_of_charging * INTERVAL '1 second'))>=%s AND EXTRACT (hour from (start_time + cs.time_of_charging * INTERVAL '1 second'))<%s+1))
            AND 
            (start_time::date = %s::date OR ((start_time + cs.time_of_charging * INTERVAL '1 second')::date =  %s::date))



            ''', [i, i, i, i, date, date]
        )
        array.append((
            str(i) + 'h-' + str(i + 1) + 'h',
            *cursor.fetchone()
        ))
    return ('date', *headings(cursor)), array


def third_request():
    """
        Company management considers using price increasing coefficients. They need to gather
        statistics for one week on how many cars are busy (% to the total amount of taxis) during the
        morning (7AM - 10 AM), afternoon (12AM - 2PM) and evening (5PM - 7PM) time.
        :return list of headings and lists of values of this table
    """
    cursor = connect_to_bd()
    cursor.execute('''
    SELECT morning, afternoon, evening
    FROM orders
    JOIN (
        SELECT COUNT(*)::float/(SELECT COUNT(*) FROM cars)::float*100 as morning FROM 
    (SELECT car_id
    FROM orders
    WHERE EXTRACT(hour from creation_time)>=7
    AND EXTRACT(hour from creation_time)<10
    AND creation_time > now()::date - interval \'7 days\'
    GROUP BY car_id) p
    ) m ON TRUE
    JOIN (
    SELECT COUNT(*)::float/(SELECT COUNT(*) FROM cars)*100 as afternoon FROM 
    (SELECT car_id
    FROM orders
    WHERE EXTRACT(hour from creation_time)>=12
    AND EXTRACT(hour from creation_time)<14
    AND creation_time > now()::date - interval \'7 days\'
    GROUP BY car_id) p
    ) a ON TRUE
    JOIN (
    SELECT COUNT(*)::float/(SELECT COUNT(*) FROM cars)*100 as evening FROM 
    (SELECT car_id
    FROM orders
    WHERE EXTRACT(hour from creation_time)>=17
    AND EXTRACT(hour from creation_time)<19
    AND creation_time > now()::date - interval \'7 days\'
    GROUP BY car_id) p
    ) e ON TRUE 
    LIMIT 1
    ''')
    return result(cursor)


def fouth_request(user_id):
    '''
     A customer claims that he was charged twice for the trip, but he can’t say exactly what dayhappened (he deleted notification from his phone and he is too lazy to ask the bank), so you
    need to check all his payments for the last month to be be sure that nothing was doubled.

    :param user_id: id of user from the task
    :return: list of headings and lists of values of this table
    '''
    cursor = connect_to_bd()
    cursor.execute('''SELECT * 
                   FROM payments
                   JOIN orders
                   ON orders.id=payments.order_id
                   WHERE orders.creation_time > now() - interval \'1 month\' AND orders.user_id=%s''', [user_id])
    return result(cursor)


def fifth_request(date):
    '''
     The department of development has requested the following statistics:
    - Average distance a car has to travel per day to customer’s order location
    - Average trip duration
    Given a date as an input, compute the statistics above.
    :param date: date from the task
    :return: list of headings and lists of values of this table
    '''
    cursor = connect_to_bd()
    cursor.execute('''
    SELECT AVG(distance) as average_distance, AVG(difference_in_time_in_sec) as average_trip_duration
    FROM(
    SELECT SQRT((car_location_upon_order_creation_lat-pick_up_lat)^2 + (car_location_upon_order_creation_long-pick_up_long)^2) 
    as distance , 
    EXTRACT(EPOCH FROM pick_up_time - creation_time) as difference_in_time_in_sec
    FROM orders
    WHERE creation_time::date = %s::date) b
    ''', [date])
    return result(cursor)


def sixth_request():
    '''
    In order to accommodate traveling demand, the company decided to distribute cars accordinto demand locations. Your task is to compute top-3 most popular pick-up locations and travdestination for each time of day: morning (7am-10am), afternoon (12am-2pm) and evening
    (5pm-7pm).

    :return: list of headings and lists of values of this table
    '''
    cursor = connect_to_bd()
    cursor.execute('''
        SELECT pick_up_lat, pick_up_long, COUNT(*) AS cnt
        FROM orders 
        WHERE 
            EXTRACT(hour from creation_time) >= 7 AND 
            EXTRACT(hour from creation_time) < 10 
        GROUP BY (pick_up_lat, pick_up_long) 
        ORDER BY cnt DESC
        LIMIT 3
     ''')
    morning = cursor.fetchall()
    cursor.execute('''
        SELECT pick_up_lat, pick_up_long, COUNT(*) AS cnt
        FROM orders 
        WHERE 
            EXTRACT(hour from creation_time) >= 12 AND 
            EXTRACT(hour from creation_time) < 14
        GROUP BY (pick_up_lat, pick_up_long) 
        ORDER BY cnt DESC
        LIMIT 3
     ''')
    afternoon = cursor.fetchall()
    cursor.execute('''
        SELECT pick_up_lat, pick_up_long, COUNT(*) AS cnt
        FROM orders 
        WHERE 
            EXTRACT(hour from creation_time) >= 17 AND 
            EXTRACT(hour from creation_time) < 19
        GROUP BY (pick_up_lat, pick_up_long) 
        ORDER BY cnt DESC 
        LIMIT 3
     ''')
    evening = cursor.fetchall()

    headings = ('pick_up_lat', 'pick_up_long', 'time of day', 'cnt')
    data = (
        *[(x[0], x[1], 'morning', x[2]) for x in morning],
        *[(x[0], x[1], 'afternoon', x[2]) for x in afternoon],
        *[(x[0], x[1], 'evening', x[2]) for x in evening]
    )
    return headings, data


def seventh_request():
    '''
    Despite the wise management, the company is going through hard times and can’t afford
    anymore to maintain the current amount of self-driving cars. The management decided to stop
    using 10% of all self-driving cars, which take least amount of orders for the last 3 months.

    :return: list of headings and lists of values of this table
    '''
    cursor = connect_to_bd()
    cursor.execute('''
    SELECT cars.*, COALESCE(count.cnt,0) as cnt from cars 
    LEFT OUTER JOIN(
    SELECT car_id, COUNT(car_id) AS cnt
    from orders
    WHERE orders.creation_time>now()::date - INTERVAL '3 months'
    GROUP BY car_id) count
    ON cars.id = count.car_id
    ORDER BY cnt 
    LIMIT((SELECT COUNT(*)/10 AS cnt 
    FROM cars))             ''')

    return result(cursor)


def eighth_request():
    '''
    The company management decided to participate in the research on “does customer location
    of residence depend on how many charging station the self-driving cars was using the same
    day”. Now you as DB developer need to provide this data. You’ve decided to collect the data
    or each day within one month and then sum them up.

    :return: list of headings and lists of values of this table
    '''
    cursor = connect_to_bd()
    cursor.execute(
        '''
        SELECT DISTINCT orders.user_id as user_id, COUNT(DISTINCT charges.id)  as num_of_charges
        from charges
        JOIN cars 
        ON charges.car_id = cars.id
        JOIN orders
        ON orders.car_id = cars.id
        AND orders.creation_time::date = charges.start_time::date
        WHERE orders.creation_time > now()::date - INTERVAL '1 month'
        GROUP BY user_id
   
        '''
    )

    return result(cursor)


def ninth_request():
    '''
     The company management decided to optimize repair costs by buying parts in bulks from
    providers for every workshop. Help them decide which parts are used the most every week by
    every workshop and compute the necessary amount of parts to order.

    :return: list of headings and lists of values of this table
    '''
    cursor = connect_to_bd()
    cursor.execute(
        '''
        SELECT workshop_id, type_car_part_id, num_of_type_of_car_part
        FROM(
        SELECT  r.workshop_id, repair_used_car_part.type_car_part_id,  (SUM(number)/p.weeks) as num_of_type_of_car_part from workshops
        JOIN repairs r on workshops.id = r.workshop_id
        JOIN repair_used_car_part 
        ON r.id = repair_used_car_part.repair_id 
        JOIN (SELECT id, (now()::date - creation_time::date)/7 as weeks
         FROM workshops) p
         ON p.id = r.workshop_id
        GROUP BY (r.workshop_id, repair_used_car_part.type_car_part_id, p.weeks)
        ORDER BY workshop_id, num_of_type_of_car_part DESC 
        ) p
        WHERE num_of_type_of_car_part!=0
        '''
    )

    return result(cursor)


def tenth_request():
    '''
    The company management decided to cut costs by getting rid of the most expensive car to
    maintain. Find out which car type has had the highest average (per day) cost of repairs and
    charging (combined).

    :return: list of headings and lists of values of this table
    '''
    cursor = connect_to_bd()
    cursor.execute(

        '''
            SELECT type_of_car_id, SUM(price) as average_price_per_day
            FROM (
            SELECT type_of_car_id, (COALESCE(cs.price_per_second, 0) * COALESCE(cs.time_of_charging, 0) + COALESCE(repair_used_car_part.number,0) * COALESCE(types_of_car_parts.price,0)):: float / num_of_days.num as price
            FROM cars
            LEFT JOIN repairs
            ON repairs.car_id = cars.id
            LEFT JOIN (
                SELECT id, now()::date - launch_date::date as num
                    FROM cars
            ) num_of_days
            ON cars.id = num_of_days.id
            LEFT JOIN repair_used_car_part
            ON repairs.id = repair_used_car_part.repair_id
            LEFT JOIN types_of_cars
            ON cars.type_of_car_id = types_of_cars.id
            LEFT JOIN types_of_car_parts
            ON repair_used_car_part.type_car_part_id = types_of_car_parts.id
            LEFT JOIN charges
            ON charges.car_id = cars.id
            LEFT JOIN charging_stations cs 
            on charges.cs_id = cs.id  
            GROUP BY (type_of_car_id, cs.price_per_second, cs.time_of_charging, repair_used_car_part.number, types_of_car_parts.price, num_of_days.num)
            ) p
            GROUP BY (type_of_car_id)
            ORDER BY average_price_per_day DESC
            '''

    )

    return result(cursor)


def custom(query):
    """
    Implements custom query
    :param query: query to execute
    :return: list of headings and lists of values of this table
    """
    cursor = connect_to_bd()
    cursor.execute(query)
    return result(cursor)


if __name__ == '__main__':
    print(first_request())
    print(second_request('2018-11-10'))
