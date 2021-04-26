import pymssql
import time

def get_time():
    time_str = time.strftime("%m{}%d{}%Y{} %X")
    return time_str.format(".", ".", "")


def get_conn():
    conn = pymssql.connect(server='localhost',
                           user='sa',
                           password='Zsystc290021!#',
                           database='Cov_vaccine')
    cursor = conn.cursor()
    return conn, cursor


def close_conn(conn, cursor):
    cursor.close()
    conn.close()


def query(sql):
    conn, cursor = get_conn()
    cursor.execute(sql)
    res = cursor.fetchall()
    close_conn(conn, cursor)
    return res

def shaws_star():
    '''
    :return: number of shaws and starkmarket
    '''
    sql = "SELECT Store, COUNT(*) " \
          "FROM BI " \
          "GROUP BY Store"
    res = query(sql)
    return res


def star_ava():
    '''
    :return: percentage of store could be schedule for star market
    '''
    sql = "SELECT Availability, COUNT(*) " \
          "FROM BI " \
          "WHERE Store = 'Star Market' " \
          "GROUP BY Availability"
    res = query(sql)
    return res


def shaws_ava():
    '''
    :return: percentage of store could be schedule for shaws
    '''
    sql = "SELECT Availability, COUNT(*) " \
          "FROM BI " \
          "WHERE Store = 'Shaws' " \
          "GROUP BY Availability"
    res = query(sql)
    return res


def city():
    '''
    :return: the schedule availability in each city
    '''
    sql = "SELECT *, (x.Available_Count*1.00)/(x.Total_Count*1.00)*100 AS availability_rate " \
          "FROM " \
          "(SELECT City, " \
          "SUM(CASE WHEN Availability LIKE '%Availability%' THEN 1 ELSE 0 END) AS Available_Count, " \
          "COUNT(*) AS Total_Count " \
          "FROM BI " \
          "GROUP BY City) x " \
          "ORDER BY x.Available_Count/x.Total_Count DESC"
    res = query(sql)
    return res


if __name__ == "__main__":
    print(star_ava())
